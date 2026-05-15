"""
detector.py - PFE DevSecOps Anomaly Detector v7
─────────────────────────────────────────────────
Detection volume-based (par IP, fenetre 60s):
  - BRUTE_FORCE    : >=5 login_errors    -> CRITICAL
  - DOS_DDOS       : >=30 total_events   -> CRITICAL
  - DDOS_AUTH      : >=15 login_attempts  -> HIGH
  - ENUM_USERS     : >=3 distinct users   -> HIGH
  - CRED_STUFFING  : >=6 login_errors + >=3 users -> CRITICAL
  - ML_ISOLATION_FOREST : anomalie ML     -> HIGH

Detection single-event (par evenement):
  - SUSPICIOUS_HOUR  : login 22h-6h       -> WARNING
  - NEW_IP_LOGIN     : IP jamais vue pour cet user -> WARNING

Slack webhook integre via notifier.py
"""

import json
import time
import logging
import traceback
from datetime import datetime, timezone
from collections import defaultdict

import requests
import urllib3

from config import *
from config import is_alert_whitelisted
from notifier import notify

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(name)s] %(levelname)s %(message)s",
)
logger = logging.getLogger("detector")

# ── Etat global ──────────────────────────────────────

# Volume-based: fenetre glissante par IP
ip_windows: dict[str, dict] = defaultdict(lambda: {
    "login_errors":   [],
    "login_attempts": [],
    "total_events":   [],
    "distinct_users": set(),
    "enum_not_found": [],   # timestamps des erreurs user_not_found
})

# Single-event: historique IP par utilisateur
user_ip_history: dict[str, set] = defaultdict(set)

# Deduplication
alerted_keys: set[str] = set()

# ── Modele ML global ────────────────────────────────
# ml_model doit etre au niveau du MODULE pour etre accessible
# par detect_ml_anomaly(). Le bloc __main__ tourne au scope
# du module, donc l'assignation ml_model = ... fonctionne.
ml_model = None


# ── Utilitaires ──────────────────────────────────────

def _now_ts() -> str:
    return datetime.now(timezone.utc).isoformat()


def _prune_window(win: dict, now: float):
    """Supprime les evenements plus vieux que 60s."""
    cutoff = now - 60.0
    for key in ("login_errors", "login_attempts", "total_events", "enum_not_found"):
        win[key] = [t for t in win[key] if t > cutoff]
    # FIX: aussi nettoyer distinct_users (reconstruire depuis login_attempts)
    if not win["login_attempts"]:
        win["distinct_users"].clear()


def _make_alert(alert_type: str, severity: str, reason: str,
                event: dict, ip: str = "", username: str = "",
                **extra) -> dict:
    """Construit un dictionnaire alerte standardise."""
    alert = {
        "timestamp":   _now_ts(),
        "alert_type":  alert_type,
        "severity":    severity,
        "source_ip":   ip,
        "username":    username,
        "reason":      reason,
        "event":       event,
        "detector":    "anomaly-detector-v7",
    }
    alert.update(extra)
    return alert


def _is_dedup(key: str) -> bool:
    """Dedup simple: meme cle dans les 300s."""
    if key in alerted_keys:
        return True
    alerted_keys.add(key)
    return False


# ── Chargement historique IP au demarrage ────────────

def load_ip_history():
    """Charge les couples username/ip depuis ES pour eviter les faux positifs NEW_IP_LOGIN."""
    logger.info("Chargement historique IP depuis ES...")
    try:
        url = f"{ES_HOST}/{ES_INDEX}-*/_search"
        headers = {"Content-Type": "application/json"}

        # On utilise une aggregation composite pour paginer
        all_pairs = set()
        after_key = None

        while True:
            query = {
                "size": 0,
                "aggs": {
                    "user_ip": {
                        "composite": {
                            "size": 1000,
                            **({"after": after_key} if after_key else {}),
                            "sources": [
                                {"username": {"terms": {"field": "username.keyword"}}},
                                {"ip": {"terms": {"field": "source_ip.keyword"}}},
                            ],
                        }
                    }
                },
                "query": {
                    "bool": {
                        "must": [
                            {"exists": {"field": "username"}},
                            {"exists": {"field": "source_ip"}},
                        ]
                    }
                },
            }

            resp = requests.post(
                url, json=query, headers=headers,
                auth=(ES_USER, ES_PASS), verify=ES_VERIFY, timeout=30,
            )
            data = resp.json()
            buckets = data.get("aggregations", {}).get("user_ip", {}).get("buckets", [])

            if not buckets:
                break

            for b in buckets:
                u = b["key"]["username"]
                ip = b["key"]["ip"]
                if u and ip:
                    all_pairs.add((u, ip))

            after_key = data["aggregations"]["user_ip"].get("after_key")
            if not after_key:
                break

        for u, ip in all_pairs:
            user_ip_history[u].add(ip)

        logger.info("Historique IP charge: %d utilisateurs, %d paires user/IP",
                     len(user_ip_history), len(all_pairs))

    except Exception as e:
        logger.warning("Impossible de charger l'historique IP: %s", e)


# ── Detection volume-based ──────────────────────────

def detect_all(event: dict):
    """Analyse volume-based pour une IP donnee."""
    # FIX: ajouter fallback "source_ip" pour l'extraction IP
    ip = event.get("ip_address", event.get("source_ip", "unknown"))
    # FIX: ajouter fallback "user" et "clientId"/"client_id"/"client" pour le username
    username = (event.get("username", "") or event.get("user", "")
                or event.get("clientId", "") or event.get("client_id", "")
                or event.get("client", "") or event.get("user_id", "")
                or "unknown")
    # FIX: ajouter fallback "type" pour l'extraction event_type
    event_type = event.get("event_type", event.get("action", event.get("type", "")))
    now = time.time()

    win = ip_windows[ip]
    _prune_window(win, now)

    # Comptage - UNIQUEMENT les evenements d'authentification
    is_auth = event_type in ("LOGIN", "LOGIN_ERROR", "LOGIN_FAILED", "TOKEN_ERROR")
    if event_type in ("LOGIN_ERROR", "LOGIN_FAILED", "TOKEN_ERROR"):
        win["login_errors"].append(now)
    if is_auth:
        win["login_attempts"].append(now)
        win["total_events"].append(now)
    if is_auth and username:
        win["distinct_users"].add(username)

    # Comptage des user_not_found (enumeration d'utilisateurs)
    if event.get("error") == "user_not_found":
        win["enum_not_found"].append(now)

    logger.debug("Window %s: errors=%d attempts=%d events=%d users=%s",
                 ip, len(win["login_errors"]), len(win["login_attempts"]),
                 len(win["total_events"]), win["distinct_users"])

    # ── BRUTE_FORCE ─────────────────────────────────
    if len(win["login_errors"]) >= BRUTE_FORCE_THRESHOLD:
        key = f"BRUTE_FORCE:{ip}:{int(now / DEDUP_TTL)}"
        if not _is_dedup(key):
            alert = _make_alert(
                "BRUTE_FORCE", "CRITICAL",
                f"{len(win['login_errors'])} login errors from {ip} in 60s",
                event, ip=ip, username=username,
                login_errors=len(win["login_errors"]),
            )
            logger.warning("BRUTE_FORCE: %s", ip)
            notify(alert)

    # ── DOS_DDOS ────────────────────────────────────
    if len(win["total_events"]) >= DOS_DDOS_THRESHOLD:
        key = f"DOS_DDOS:{ip}:{int(now / DEDUP_TTL)}"
        if not _is_dedup(key):
            alert = _make_alert(
                "DOS_DDOS", "CRITICAL",
                f"{len(win['total_events'])} events from {ip} in 60s",
                event, ip=ip, username=username,
                total_events=len(win["total_events"]),
            )
            logger.warning("DOS_DDOS: %s", ip)
            notify(alert)

    # ── DDOS_AUTH ───────────────────────────────────
    if len(win["login_attempts"]) >= DDOS_AUTH_THRESHOLD:
        key = f"DDOS_AUTH:{ip}:{int(now / DEDUP_TTL)}"
        if not _is_dedup(key):
            alert = _make_alert(
                "DDOS_AUTH", "HIGH",
                f"{len(win['login_attempts'])} auth attempts from {ip} in 60s",
                event, ip=ip, username=username,
                login_attempts=len(win["login_attempts"]),
            )
            logger.warning("DDOS_AUTH: %s", ip)
            notify(alert)

    # ── ENUM_USERS ──────────────────────────────────
    enum_total = max(len(win["distinct_users"]), len(win["enum_not_found"]))
    if enum_total >= ENUM_USERS_THRESHOLD:
        key = f"ENUM_USERS:{ip}:{int(now / DEDUP_TTL)}"
        if not _is_dedup(key):
            nf_count = len(win["enum_not_found"])
            alert = _make_alert(
                "ENUM_USERS", "HIGH",
                f"{enum_total} user enumeration attempts from {ip} in 60s "
                f"({len(win['distinct_users'])} known + {nf_count} not-found)",
                event, ip=ip, username=username,
                distinct_users=enum_total,
            )
            logger.warning("ENUM_USERS: %s", ip)
            notify(alert)

    # ── CRED_STUFFING ───────────────────────────────
    cred_distinct = max(len(win["distinct_users"]), len(win["enum_not_found"]))
    if (len(win["login_errors"]) >= CRED_STUFFING_THRESHOLD
            and cred_distinct >= 3):
        key = f"CRED_STUFFING:{ip}:{int(now / DEDUP_TTL)}"
        if not _is_dedup(key):
            alert = _make_alert(
                "CRED_STUFFING", "CRITICAL",
                f"{len(win['login_errors'])} errors + {cred_distinct} users from {ip}",
                event, ip=ip, username=username,
                login_errors=len(win["login_errors"]),
                distinct_users=cred_distinct,
            )
            logger.warning("CRED_STUFFING: %s", ip)
            notify(alert)


# ── Detection single-event ──────────────────────────

def detect_single_event(event: dict):
    """Detecte les anomalies sur un seul evenement (heure suspecte, nouvelle IP)."""
    # FIX: ajouter fallback "user" pour le username
    username = (event.get("username", "") or event.get("user", "")
                or event.get("clientId", "") or event.get("client_id", "")
                or event.get("client", "") or event.get("user_id", "")
                or "unknown")
    ip = event.get("ip_address", event.get("source_ip", ""))
    # FIX: ajouter fallback "type" pour l'event_type
    event_type = event.get("event_type", event.get("action", event.get("type", "")))

    # Ne detecte que les logins reussis
    if event_type not in ("LOGIN",):
        return
    if not username or not ip:
        return

    # ── SUSPICIOUS_HOUR ─────────────────────────────
    check_suspicious_hour(event, username, ip)

    # ── NEW_IP_LOGIN ────────────────────────────────
    check_new_ip_login(event, username, ip)


def check_suspicious_hour(event: dict, username: str, ip: str):
    """Detecte un login entre 22h et 6h (heure UTC du serveur)."""
    try:
        ts_str = event.get("timestamp", event.get("@timestamp", ""))
        if ts_str:
            dt = datetime.fromisoformat(ts_str.replace("Z", "+00:00"))
        else:
            dt = datetime.now(timezone.utc)

        hour = dt.hour

        # Heure suspecte: 22h-6h
        if hour >= SUSPICIOUS_HOUR_START or hour < SUSPICIOUS_HOUR_END:
            key = f"SUSPICIOUS_HOUR:{username}:{ip}:{dt.strftime('%Y%m%d%H')}"
            if not _is_dedup(key):
                alert = _make_alert(
                    "SUSPICIOUS_HOUR", SUSPICIOUS_HOUR_SEVERITY,
                    f"Login at suspicious hour ({hour}h) for user '{username}' from {ip}",
                    event, ip=ip, username=username,
                )
                logger.warning("SUSPICIOUS_HOUR: %s at %dh from %s", username, hour, ip)
                notify(alert)
    except Exception as e:
        logger.error("SUSPICIOUS_HOUR check error: %s", e)


def check_new_ip_login(event: dict, username: str, ip: str):
    """Detecte un login depuis une IP jamais vue pour cet utilisateur."""
    if ip in user_ip_history[username]:
        # IP deja connue, on ne signale pas
        return

    # Nouvelle IP !
    key = f"NEW_IP_LOGIN:{username}:{ip}"
    if not _is_dedup(key):
        known_count = len(user_ip_history[username])
        alert = _make_alert(
            "NEW_IP_LOGIN", NEW_IP_SEVERITY,
            f"User '{username}' logged in from new IP {ip} "
            f"(previously {known_count} known IPs)",
            event, ip=ip, username=username,
        )
        logger.warning("NEW_IP_LOGIN: %s from new IP %s", username, ip)
        notify(alert)

    # Ajouter cette IP a l'historique pour eviter les futures alertes
    user_ip_history[username].add(ip)


# ── ML Isolation Forest ─────────────────────────────

def detect_ml_anomaly(event: dict):
    """Detection d'anomalie via Isolation Forest (si active)."""
    if not ML_ENABLED:
        return

    if ml_model is None:
        return

    try:
        # predict() retourne (is_anomaly: bool, score: float)
        # score < 0 = anomalie, score > 0 = normal
        is_anomaly, score = ml_model.predict(event)

        if is_anomaly:
            ip = event.get("ip_address", event.get("source_ip", "unknown"))
            # FIX: ajouter fallback "user" pour le username
            username = (event.get("username", "") or event.get("user", "")
                        or event.get("clientId", "") or event.get("client_id", "")
                        or event.get("client", "") or event.get("user_id", "")
                        or "unknown")
            # FIX: utiliser ML_ANOMALY_THRESHOLD negatif pour severite
            # score tres negatif (< ML_ANOMALY_THRESHOLD, ex: -0.3) => CRITICAL
            # score legerement negatif => HIGH
            severity = "CRITICAL" if score < ML_ANOMALY_THRESHOLD else "HIGH"
            key = f"ML_ISOLATION_FOREST:{ip}:{username}:{int(time.time() / DEDUP_TTL)}"
            if not _is_dedup(key):
                alert = _make_alert(
                    "ML_ISOLATION_FOREST", severity,
                    f"ML anomaly detected (score={score:.3f}) from {ip}",
                    event, ip=ip, username=username,
                    ml_score=score,
                )
                logger.warning("ML_ISOLATION_FOREST: score=%.3f ip=%s user=%s",
                               score, ip, username)
                notify(alert)
    except ImportError:
        logger.debug("IsolationForest model not available, skipping ML detection")
    except Exception as e:
        logger.error("ML detection error: %s", e)


# ── Traitement d'un evenement Kafka ─────────────────

def process_event(event: dict):
    """Point d'entree: traite un evenement Kafka."""
    # Filtre whitelist: ignorer les IPs internes (sauf IPs attaquantes exclues)
    ip = event.get("ip_address", event.get("source_ip", ""))
    if is_alert_whitelisted(ip):
        return

    # 1. Detection volume-based (par IP)
    detect_all(event)

    # 2. Detection single-event (heure suspecte, nouvelle IP)
    detect_single_event(event)

    # 3. Detection ML
    detect_ml_anomaly(event)


# ── Main ─────────────────────────────────────────────

if __name__ == "__main__":
    from confluent_kafka import Consumer

    logger.info("=" * 60)
    logger.info("PFE Anomaly Detector v7 demarre")
    logger.info("=" * 60)

    load_ip_history()

    # Chargement du modele ML
    if ML_ENABLED:
        try:
            from models.isolation_forest import AnomalyDetectorModel
            ml_model = AnomalyDetectorModel()
            ml_model.load()
            logger.info("Modele ML Isolation Forest charge")
        except Exception as e:
            logger.warning("Modele ML non disponible: %s", e)
            ml_model = None

    # FIX: auto.offset.reset = "earliest" pour relire les evenements existants
    # "latest" = ne lit que les NOUVEAUX messages apres connexion
    # "earliest" = relit depuis le debut du topic
    consumer_conf = {
        "bootstrap.servers": KAFKA_BOOTSTRAP,
        "group.id":         KAFKA_GROUP,
        "auto.offset.reset": "earliest",
        "enable.auto.commit": True,
        "session.timeout.ms": 30000,
    }
    consumer = Consumer(consumer_conf)
    consumer.subscribe([KAFKA_TOPIC])
    logger.info("Kafka consumer connecte: %s / %s (offset=earliest)", KAFKA_BOOTSTRAP, KAFKA_TOPIC)

    try:
        while True:
            msg = consumer.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                logger.error("Kafka erreur: %s", msg.error())
                continue
            try:
                event = json.loads(msg.value().decode("utf-8"))
                process_event(event)
            except json.JSONDecodeError:
                logger.warning("Evenement JSON invalide")
            except Exception as e:
                logger.error("Traitement erreur: %s", e)
                traceback.print_exc()
    except KeyboardInterrupt:
        logger.info("Arret demande")
    finally:
        consumer.close()
        logger.info("Consumer Kafka ferme")
