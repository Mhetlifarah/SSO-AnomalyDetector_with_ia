import numpy as np
#!/usr/bin/env python3
# ==============================================================================
# DETECTOR_SLACK.PY - Detecteur d'anomalies avec alertes Slack (v5 — FINAL)
# ==============================================================================
#
# ARCHITECTURE :
#   Kafka → CE SCRIPT → Analyse → Slack (alertes) + Elasticsearch (stockage)
#                                          |
#                                        Kibana (visualisation)
#
# 14 REGLES DE DETECTION + ML Isolation Forest (CONSENSUS)
#
# CHANGEMENTS v5 (vs v4) :
#   1. FIX BRUTE_FORCE COUNT: maxlen=500 (etait 20 → count bloque a 20)
#   2. FIX DeprecationWarning: document= au lieu de body= pour ES
#   3. ANTI-SPAM: Cooldown 60s par (type, user, IP) — herite de v4
#   4. ES RETRY: Creation index auto + retry + logs detailles — herite de v4
#   5. PRIMARY TYPE FIX: Type = alerte du plus haut niveau — herite de v4
#   6. AUTH RULES: Brute force/credential stuffing/enum toujours alertes — herite de v4
#
# EMPLACEMENT : /app/detector_slack.py (dans le conteneur)
# ==============================================================================

import json, sys, time, requests, logging, os
from datetime import datetime
from collections import defaultdict, deque
from confluent_kafka import Consumer #lire kafka
from elasticsearch import Elasticsearch #stock les alertes

sys.path.append('/app')
from config import * #lire tous les seuils de parametres
from models.isolation_forest import AnomalyDetectorModel #modele ML ( class)
from responder import respond

# ==============================================================================
# LOGGING : pour voir ce qui ce passe
# ==============================================================================
logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger("detector-slack")


# ==============================================================================
# SMART IP FILTERING — Helper functions
# ==============================================================================
### fixation les ip internes
def _is_internal_ip(ip):
    """
    Verifie si une IP est interne (Docker/LAN/bridge).
    Utilise is_internal_ip() de config.py si disponible, sinon fallback local.
    """
    try:
        return is_internal_ip(ip)
    except NameError:
        # Fallback si is_internal_ip n'existe pas dans config.py
        if not ip or ip == 'unknown':
            return False
        trusted = ['172.18.', '192.168.', '10.', '172.16.', '172.17.']
        attacker_ips = ['192.168.222.143']
        safe_ips = ['192.168.222.1', '192.168.222.146', '192.168.222.50']
        if ip in attacker_ips:
            return False
        if ip in safe_ips:
            return True
        return any(ip.startswith(p) for p in trusted)


def _is_docker_proxy_ip(ip):
    """IP du reseau Docker bridge (172.18.0.x) = proxy interne.
    Ces IPs ne representent pas de vrais clients, ce sont les containers
    proxy (Nginx, app) qui font les requetes CODE_TO_TOKEN cote serveur.
    On les ignore pour TOKEN_THEFT et CODE_INTERCEPTION."""
    if not ip or ip == 'unknown':
        return False
    return ip.startswith('172.18.0.')

def _skip_volume_alert(ip):
    """
    Determine si on doit ignorer une alerte de VOLUME PUR pour cette IP.
    Les IPs internes (Docker, bridge, LAN) generent naturellement beaucoup
    de trafic (healthchecks, proxies, load balancers). On les ignore pour
    les regles de volume PUR uniquement (DOS, DDOS_AUTH).

    IMPORTANT: Les regles d'AUTHENTIFICATION (BRUTE_FORCE, CREDENTIAL_STUFFING,
    ACCOUNT_ENUMERATION) ne sont PAS skippees car un brute force depuis
    l'interieur = insider attack / machine compromise = reel threat.
    """
    return _is_internal_ip(ip)


# ==============================================================================
# ALERT DEDUPLICATION — Anti-Spam==> eviter envoie +++ meme alertes meme attque
# ==============================================================================
# Cooldown par (alert_type, username, ip): on n'envoie pas 2 alertes
# identiques dans la fenetre de cooldown. Seule une ESCALADE de niveau
# (WARNING → CRITICAL → URGENT) peut passer.
# ==============================================================================
ALERT_COOLDOWN_SECONDS = 300  # 300s entre 2 alertes identiques
alert_last_sent = {}  # (alert_type, username, ip) → (timestamp, level)


def _should_send_alert(alert_type, username, ip, level):
    """
    Determine si on doit envoyer cette alerte ou si c'est du spam.
    - Si meme (type, user, ip) dans les 60s et meme niveau = SPAM → skip
    - Si niveau SUPERIEUR (escalade) → envoyer (c'est une aggravation)
    - Si nouvelle attaque → envoyer
    """
    key = (alert_type, username, ip)
    now = time.time()

    if key in alert_last_sent:
        last_ts, last_level = alert_last_sent[key]
        time_since = now - last_ts

        # Niveaux en ordre croissant
        level_order = {"WARNING": 1, "CRITICAL": 2, "URGENT": 3}
        current_rank = level_order.get(level, 0)
        last_rank = level_order.get(last_level, 0)

        # Escalade (niveau superieur) → toujours envoyer
        if current_rank > last_rank:
            alert_last_sent[key] = (now, level)
            return True

        # Meme niveau ou inferieur dans la fenetre → SPAM
        if time_since < ALERT_COOLDOWN_SECONDS:
            return False

    # Nouvelle alerte ou cooldown expire → envoyer
    alert_last_sent[key] = (now, level)
    return True


# ==============================================================================
# SLACK - Webhook pour envoyer les alertes
# ==============================================================================
SLACK_WEBHOOK_URL = os.getenv("SLACK_WEBHOOK_URL", "https://hooks.slack.com/services/CHANGER_ICI")

def send_slack(username, event_type, ip, level, msg, count=0, alert_type=""):
    """Envoie une alerte formatee au canal Slack."""
    try:
        color = {"WARNING": "#FFA500", "CRITICAL": "#FF6600", "URGENT": "#FF0000"}.get(level, "#FF0000")

        fields = [
            {"title": "Type d'attaque", "value": str(alert_type), "short": True},
            {"title": "Utilisateur", "value": str(username), "short": True},
            {"title": "Evenement", "value": str(event_type), "short": True},
            {"title": "IP Source", "value": str(ip), "short": True},
            {"title": "Heure", "value": datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "short": True},
            {"title": "Niveau", "value": str(level), "short": True},
            {"title": "Detail", "value": msg, "short": False}
        ]
        if count > 0:
            fields.append({"title": "Compteur", "value": str(count), "short": True})

        payload = {
            "attachments": [{
                "color": color,
                "title": f"ALERTE SECURITE - {level} - {alert_type}",
                "fields": fields,
                "footer": "PFE DevSecOps | IA Anomaly Detector",
                "ts": int(datetime.now().timestamp())
            }]
        }

        r = requests.post(SLACK_WEBHOOK_URL, json=payload, timeout=5)
        if r.status_code == 200:
            logger.info("Alerte Slack envoyee")
        else:
            logger.warning(f"Slack retour: {r.status_code}")

    except requests.exceptions.Timeout:
        logger.warning("Slack: Timeout (5s)")
    except Exception as e:
        logger.warning(f"Slack erreur: {e}")


# ==============================================================================
# ELASTICSEARCH — avec retry et creation auto d'index
# ==============================================================================
es = None

def _init_elasticsearch():
    """Initialise la connexion Elasticsearch avec retry."""
    global es
    try:
        es = Elasticsearch([ES_HOST], request_timeout=10)
        if es.ping():
            logger.info(f"Connecte a Elasticsearch: {ES_HOST}")
            # Creer l'index pattern si il n'existe pas
            _ensure_index_template()
            return True
        else:
            logger.error(f"Elasticsearch ping echoue: {ES_HOST}")
            es = None
            return False
    except Exception as e:
        logger.error(f"Elasticsearch connexion echouee: {e}")
        es = None
        return False


def _ensure_index_template():
    """Cree un template d'index pour que Kibana trouve les donnees."""
    if es is None:
        return
    try:
        template_name = "security-events-template"
        # Verifier si le template existe deja
        if es.indices.exists_template(name=template_name):
            logger.info(f"Index template '{template_name}' existe deja")
            return

        template_body = {
            "index_patterns": ["security-events-*"],
            "settings": {
                "number_of_shards": 1,
                "number_of_replicas": 0
            },
            "mappings": {
                "properties": {
                    "timestamp": {"type": "date"},
                    "detected_at": {"type": "date"},
                    "type": {"type": "keyword"},
                    "level": {"type": "keyword"},
                    "username": {"type": "keyword"},
                    "event_type": {"type": "keyword"},
                    "ip_address": {"type": "keyword"},
                    "session_id": {"type": "keyword"},
                    "message": {"type": "text"},
                    "source": {"type": "keyword"},
                    "alert_count": {"type": "integer"},
                    "is_internal_ip": {"type": "boolean"},
                    "ml_consensus": {"type": "boolean"}
                }
            }
        }
        es.indices.put_template(name=template_name, body=template_body)
        logger.info(f"Index template '{template_name}' cree")
    except Exception as e:
        logger.warning(f"Template creation echouee (non critique): {e}")


# Initialiser ES
_init_elasticsearch()


def index_anomaly(anomaly_data):
    """Ecrit une anomalie dans l'index Elasticsearch avec retry."""
    global es
    if es is None:
        # Re-essayer la connexion
        if not _init_elasticsearch():
            logger.error("ES toujours indisponible, alerte non indexee")
            return

    try:
        today = datetime.now().strftime('%Y.%m.%d')
        index_name = f"security-events-{today}"

        # Creer l'index du jour s'il n'existe pas
        if not es.indices.exists(index=index_name):
            es.indices.create(index=index_name, ignore=400)
            logger.info(f"Index cree: {index_name}")

        # FIX v5: document= au lieu de body= (DeprecationWarning)
        result = es.index(index=index_name, document=anomaly_data, refresh=True)
        logger.info(f"Alerte indexee dans ES: {index_name} id={result.get('_id', '?')}")
    except Exception as e:
        logger.error(f"Erreur ecriture ES: {e}")
        # Marquer ES comme indisponible pour retry au prochain tour
        es = None

##****Le détecteur garde en mémoire un historique des dernières actions (connexions, erreurs, sessions) pour reconnaître quand un comportement devient suspect.***
# ==============================================================================
# HISTORIQUES EN MEMOIRE (fenetres glissantes)
# ==============================================================================
# --- Regles originales ---
# FIX v5: maxlen=500 (etait BRUTE_FORCE_ATTEMPTS*4=20 → count bloque a 20)
user_attempts = defaultdict(lambda: deque(maxlen=500))
user_ips = defaultdict(lambda: deque(maxlen=20))
ip_requests = defaultdict(lambda: deque(maxlen=DOS_REQUEST_THRESHOLD * 2))

# --- Nouvelles regles SSO ---
session_ips = defaultdict(lambda: deque(maxlen=20))
session_uas = defaultdict(lambda: deque(maxlen=20))
ip_user_errors = defaultdict(lambda: deque(maxlen=100))
user_login_ip = {}
user_refreshes = defaultdict(lambda: deque(maxlen=REFRESH_ABUSE_THRESHOLD * 2))
user_admin_attempts = defaultdict(lambda: deque(maxlen=20))
ip_enum_attempts = defaultdict(lambda: deque(maxlen=50))
global_auth_requests = deque(maxlen=DDOS_AUTH_THRESHOLD * 2)
user_login_history = defaultdict(lambda: deque(maxlen=20))
logged_out_sessions = {}
session_last_ua = {}


# ==============================================================================
# REGLE 1 : BRUTE FORCE
# ==============================================================================

def _extract_attack_features_v2(event, ip_address):
    """Extrait les 4 nouvelles features V2 pour le modele IForest"""
    import time as _time
    now = _time.time()

    # Utiliser les vraies structures de donnees du detecteur
    # ip_requests[ip] = deque de timestamps
    # ip_user_errors[ip] = deque de (timestamp, username)
    # user_attempts[user] = deque de timestamps
    # ip_enum_attempts[ip] = deque de timestamps

    error_count = 0
    distinct_users = set()
    total_events_ip = 0

    # Compter les requetes de cette IP dans les 60 dernieres secondes
    try:
        ip_reqs = ip_requests.get(ip_address, [])
        for t in ip_reqs:
            if isinstance(t, (int, float)) and now - t < 60:
                total_events_ip += 1
    except:
        pass

    # Compter les erreurs et utilisateurs distincts de cette IP
    try:
        ip_errs = ip_user_errors.get(ip_address, [])
        for item in ip_errs:
            if isinstance(item, tuple) and len(item) >= 2:
                t, user = item[0], item[1]
                if isinstance(t, (int, float)) and now - t < 60:
                    error_count += 1
                    if user and user != '(empty)':
                        distinct_users.add(user)
            elif isinstance(item, (int, float)) and now - item < 60:
                error_count += 1
    except:
        pass

    # Compter les tentatives enumeration
    try:
        ip_enums = ip_enum_attempts.get(ip_address, [])
        for t in ip_enums:
            if isinstance(t, (int, float)) and now - t < 60:
                error_count += 1
    except:
        pass

    # Calculer interval moyen entre requetes
    intervals = []
    try:
        ip_reqs = ip_requests.get(ip_address, [])
        recent = sorted([t for t in ip_reqs if isinstance(t, (int, float)) and now - t < 300])
        for i in range(1, len(recent)):
            dt = recent[i] - recent[i-1]
            if 0 < dt < 300:
                intervals.append(dt)
    except:
        pass

    try:
        import numpy as _np
        avg_interval = float(_np.mean(intervals)) if intervals else 60.0
    except:
        avg_interval = float(sum(intervals) / len(intervals)) if intervals else 60.0

    error_rate = error_count / total_events_ip if total_events_ip > 0 else 0.0
    is_rapid = 1 if avg_interval < 5 else 0

    return {
        'error_count_60s': error_count,
        'distinct_users_ip': max(len(distinct_users), 1),
        'error_rate_ip': round(error_rate, 3),
        'is_rapid_requests': is_rapid,
    }


def check_brute_force(username, ts):
    cutoff = ts - BRUTE_FORCE_WINDOW_SECONDS
    user_attempts[username].append(ts)
    count = len([t for t in user_attempts[username] if t > cutoff])
    if count >= URGENT_THRESHOLD:
        return "URGENT", f"BRUTE FORCE CONFIRME: {count} echecs en {BRUTE_FORCE_WINDOW_SECONDS}s", count
    elif count >= CRITICAL_THRESHOLD:
        return "CRITICAL", f"Brute force probable: {count} echecs en {BRUTE_FORCE_WINDOW_SECONDS}s", count
    elif count >= WARNING_THRESHOLD:
        return "WARNING", f"Comportement suspect: {count} echecs en {BRUTE_FORCE_WINDOW_SECONDS}s", count
    return None, None, 0


# ==============================================================================
# REGLE 2 : HEURE SUSPECTE
# ==============================================================================
def check_suspicious_hour(ts):
    hour = datetime.fromtimestamp(ts).hour
    if hour in SUSPICIOUS_HOURS:
        return True, f"Connexion a heure suspecte ({hour}h00 - periode 20h-6h)"
    return False, None


# ==============================================================================
# REGLE 3 : MULTI-IP
# ==============================================================================
def check_multi_ip(username, ip, ts):
    user_ips[username].append((ip, ts))
    cutoff = ts - MULTI_IP_WINDOW_SECONDS
    recent_ips = set(i for i, t in user_ips[username] if t > cutoff)
    if len(recent_ips) >= MAX_IPS_PER_USER:
        return True, f"{len(recent_ips)} IPs differentes en {MULTI_IP_WINDOW_SECONDS}s: {', '.join(list(recent_ips)[:5])}", len(recent_ips)
    return False, None, 0


# ==============================================================================
# REGLE 4 : DOS/DDOS
# ==============================================================================
def check_dos(ip, ts):
    ip_requests[ip].append(ts)
    cutoff = ts - DOS_WINDOW_SECONDS
    count = len([t for t in ip_requests[ip] if t > cutoff])
    if count >= DOS_REQUEST_THRESHOLD:
        return "URGENT", f"DOS/DDOS: {count} requetes en {DOS_WINDOW_SECONDS}s depuis {ip}", count
    elif count >= DOS_REQUEST_THRESHOLD // 2:
        return "WARNING", f"Pics de requetes: {count} req/{DOS_WINDOW_SECONDS}s depuis {ip}", count
    return None, None, 0


# ==============================================================================
# REGLE 5 : TOKEN THEFT / REPLAY
# ==============================================================================
def check_token_theft(session_id, ip, ts):
    if not session_id or session_id == "":
        return None, None, 0
    session_ips[session_id].append((ip, ts))
    cutoff = ts - TOKEN_THEFT_WINDOW_SECONDS
    recent_ips = set(i for i, t in session_ips[session_id] if t > cutoff)
    # FIX: Filtrer les IPs Docker proxy (172.18.0.x)
    real_ips = set(i for i in recent_ips if not _is_docker_proxy_ip(i))
    if len(real_ips) >= TOKEN_THEFT_MIN_IPS:
        ips_str = ", ".join(list(real_ips)[:5])
        return "CRITICAL", \
            f"TOKEN THEFT: session {session_id[:8]}... utilisee depuis {len(real_ips)} IPs reelles: {ips_str}", \
            len(real_ips)
    return None, None, 0

# ==============================================================================
# REGLE 6 : SESSION HIJACKING
# ==============================================================================
def check_session_hijacking(session_id, user_agent, ts):
    if not session_id or session_id == '':
        return None, None, 0
    if not user_agent or user_agent == 'unknown':
        return None, None, 0
    session_uas[session_id].append((user_agent, ts))
    cutoff = ts - SESSION_HIJACK_WINDOW_SECONDS
    recent_uas = set(ua for ua, t in session_uas[session_id] if t > cutoff)
    if len(recent_uas) >= SESSION_HIJACK_DIFFERENT_UA:
        return "CRITICAL", \
            f"SESSION HIJACKING: session {session_id[:8]}... utilisee avec {len(recent_uas)} user-agents differents", \
            len(recent_uas)
    return None, None, 0


# ==============================================================================
# REGLE 7 : CREDENTIAL STUFFING
# ==============================================================================
def check_credential_stuffing(ip, username, ts):
    if ip == 'unknown':
        return None, None, 0
    ip_user_errors[ip].append((username, ts))
    cutoff = ts - CREDENTIAL_STUFFING_WINDOW_SECONDS
    recent_users = set(u for u, t in ip_user_errors[ip] if t > cutoff)
    if len(recent_users) >= CREDENTIAL_STUFFING_MIN_USERS:
        return "CRITICAL", \
            f"CREDENTIAL STUFFING: {len(recent_users)} utilisateurs differents echouent depuis {ip}", \
            len(recent_users)
    return None, None, 0


# ==============================================================================
# REGLE 8 : CODE INTERCEPTION
# ==============================================================================
def check_code_interception(username, ip, ts):
    if username not in user_login_ip:
        user_login_ip[username] = (ip, ts)
        return None, None, 0
    login_ip, login_ts = user_login_ip[username]
    # FIX: Skip si l'une des IPs est un proxy Docker
    if _is_docker_proxy_ip(ip) or _is_docker_proxy_ip(login_ip):
        user_login_ip[username] = (ip, ts)
        return None, None, 0
    if login_ip != ip and login_ip != "unknown" and ip != "unknown":
        return "CRITICAL", \
            f"CODE INTERCEPTION: LOGIN depuis {login_ip} mais CODE_TO_TOKEN depuis {ip}", 2
    user_login_ip[username] = (ip, ts)
    return None, None, 0

# ==============================================================================
# REGLE 9 : TOKEN REFRESH ABUSE
# ==============================================================================
def check_refresh_abuse(username, ts):
    user_refreshes[username].append(ts)
    cutoff = ts - REFRESH_ABUSE_WINDOW_SECONDS
    count = len([t for t in user_refreshes[username] if t > cutoff])
    if count >= REFRESH_ABUSE_THRESHOLD:
        return "WARNING", \
            f"TOKEN REFRESH ABUSE: {count} refresh en {REFRESH_ABUSE_WINDOW_SECONDS}s pour {username}", count
    return None, None, 0


# ==============================================================================
# REGLE 10 : PRIVILEGE ESCALATION
# ==============================================================================
def check_privilege_escalation(username, event_type, ts, roles=None):
    if not is_privilege_escalation_action(event_type):
        return None, None, 0
    user_admin_attempts[username].append(ts)
    cutoff = ts - PRIVILEGE_ESCALATION_WINDOW_SECONDS
    count = len([t for t in user_admin_attempts[username] if t > cutoff])
    if roles and isinstance(roles, (list, str)):
        roles_str = str(roles).lower()
        if 'admin' in roles_str or 'realm-admin' in roles_str:
            return None, None, 0
    if count >= PRIVILEGE_ESCALATION_ATTEMPTS:
        return "CRITICAL", \
            f"PRIVILEGE ESCALATION: {count} tentatives d'acces admin par {username}", count
    return None, None, 0


# ==============================================================================
# REGLE 11 : ACCOUNT ENUMERATION
# ==============================================================================
def check_account_enumeration(ip, details, ts):
    if ip == 'unknown':
        return None, None, 0
    if not is_account_enum_error(details):
        return None, None, 0
    ip_enum_attempts[ip].append(ts)
    cutoff = ts - ACCOUNT_ENUM_WINDOW_SECONDS
    count = len([t for t in ip_enum_attempts[ip] if t > cutoff])
    if count >= ACCOUNT_ENUM_MIN_ATTEMPTS:
        return "WARNING", \
            f"ACCOUNT ENUMERATION: {count} erreurs 'user not found' depuis {ip}", count
    return None, None, 0


# ==============================================================================
# REGLE 12 : DDoS Auth
# ==============================================================================
def check_ddos_auth(ts):
    global_auth_requests.append(ts)
    cutoff = ts - DDOS_AUTH_WINDOW_SECONDS
    count = len([t for t in global_auth_requests if t > cutoff])
    if count >= DDOS_AUTH_THRESHOLD:
        return "URGENT", \
            f"DDOS AUTH: {count} requetes d'auth en {DDOS_AUTH_WINDOW_SECONDS}s sur le systeme", count
    elif count >= DDOS_AUTH_THRESHOLD // 2:
        return "WARNING", \
            f"Pics d'auth: {count} requetes en {DDOS_AUTH_WINDOW_SECONDS}s", count
    return None, None, 0


# ==============================================================================
# REGLE 13 : IMPOSSIBLE TRAVEL
# ==============================================================================
def check_impossible_travel(username, ip, ts):
    user_login_history[username].append((ip, ts))
    logins = list(user_login_history[username])
    if len(logins) < 2:
        return None, None, 0
    prev_ip, prev_ts = logins[-2]
    curr_ip, curr_ts = logins[-1]
    distance = estimate_ip_distance(prev_ip, curr_ip)
    time_diff = curr_ts - prev_ts
    if time_diff <= 0 or time_diff > IMPOSSIBLE_TRAVEL_WINDOW_SECONDS:
        return None, None, 0
    speed = (distance / time_diff) * 3600
    if speed > IMPOSSIBLE_TRAVEL_SPEED_KMH and distance > 100:
        return "CRITICAL", \
            f"IMPOSSIBLE TRAVEL: {username} login depuis {prev_ip} puis {curr_ip} en {int(time_diff)}s (~{int(distance)}km, ~{int(speed)}km/h)", \
            int(speed)
    return None, None, 0


# ==============================================================================
# REGLE 14 : SESSION FIXATION
# ==============================================================================
def check_session_fixation(session_id, ts, event_type=None):
    if not session_id or session_id == '':
        return None, None, 0
    # FIX: Ignorer les login_attempt (pas de vrai logout)
    if event_type and event_type.lower() in ("login_attempt",):
        return None, None, 0
    if event_type and event_type.lower() in ('logout',):
        logged_out_sessions[session_id] = ts
        return None, None, 0
    if session_id in logged_out_sessions:
        logout_ts = logged_out_sessions[session_id]
        time_since_logout = ts - logout_ts
        if 0 < time_since_logout <= SESSION_FIXATION_WINDOW_SECONDS:
            return "CRITICAL", \
                f"SESSION FIXATION: session {session_id[:8]}... reutilisee {int(time_since_logout)}s apres logout", \
                int(time_since_logout)
        elif time_since_logout > SESSION_FIXATION_WINDOW_SECONDS:
            del logged_out_sessions[session_id]
    return None, None, 0


# ==============================================================================
# CHARGEMENT DU MODELE ML
# ==============================================================================
try:
    ml_model = AnomalyDetectorModel()
    ml_model.load()
    logger.info("Modele ML Isolation Forest charge (13 features)")
except Exception as e:
    ml_model = None
    logger.warning(f"ML non disponible: {e} — 14 regles actives sans ML")


# ==============================================================================
# CONNEXION KAFKA :lire events
# ==============================================================================
conf = {
    'bootstrap.servers': KAFKA_BOOTSTRAP,
    'group.id': 'slack-detector-v5',
    'auto.offset.reset': 'earliest',
    'enable.auto.commit': True,
    'session.timeout.ms': 30000
}
consumer = Consumer(conf)
consumer.subscribe([KAFKA_TOPIC])

logger.info(f"Surveillance active — Kafka: {KAFKA_BOOTSTRAP}, Topic: {KAFKA_TOPIC}")
logger.info(f"  14 regles + ML CONSENSUS | Anti-spam: {ALERT_COOLDOWN_SECONDS}s cooldown | ES: {'OK' if es else 'NON CONNECTE'}")

anomaly_count = 0
total_events = 0
skipped_spam = 0 


# ==============================================================================
# BOUCLE PRINCIPALE : traite chaque events kafka 
# ==============================================================================
try:
    while True:
        msg = consumer.poll(1.0) #attend 1s

        if msg is None:
            continue
        if msg.error():
            logger.error(f"Erreur Kafka: {msg.error()}")
            continue

        try:
            event = json.loads(msg.value().decode('utf-8'))
        except json.JSONDecodeError:
            continue

        # Encapsuler tout le traitement dans un try/except
        try:
            total_events += 1

            # --- Extraire les infos ---
            event_type = event.get('event_type', event.get('type', event.get('action', 'UNKNOWN')))
            username = event.get('username', event.get('user_id', event.get('user', 'unknown')))
            ip = event.get('ip_address', 'unknown')
            session_id = event.get('session_id', '')
            user_agent = event.get('user_agent', event.get('details', {}).get('user_agent', 'unknown'))
            details = event.get('details', {})
            error_msg = event.get('error', '')
            if error_msg:
                details['error'] = error_msg
            roles = event.get('roles', None)

            raw_time = event.get('event_time', event.get('timestamp', 0))
            ts = parse_event_time(raw_time)
            dt = datetime.fromtimestamp(ts) # stocker la requete pour features ML
            et_lower = event_type.lower() if event_type else ''

            # ==================================================================
            # ANALYSE MULTI-CRITERES
            # ==================================================================
            alerts = []
            highest_level = None
            highest_msg = None
            highest_alert_type = None  # FIX v4: type du plus haut niveau
            extra_count = 0
            rule_fired = False

            # --- Regle 1 : Brute Force ---
            # AUTH RULE: Toujours alerter, meme depuis IP interne.
            if is_login_error_action(event_type):
                level, msg_str, count = check_brute_force(username, ts)
                if level:
                    alerts.append(("BRUTE_FORCE", level, msg_str))
                    if highest_level in (None, "WARNING") or level == "URGENT":
                        highest_level = level
                        highest_msg = msg_str
                        highest_alert_type = "BRUTE_FORCE"
                    extra_count = count
                    rule_fired = True

                # --- Regle 7 : Credential Stuffing ---
                cs_level, cs_msg, cs_count = check_credential_stuffing(ip, username, ts)
                if cs_level:
                    alerts.append(("CREDENTIAL_STUFFING", cs_level, cs_msg))
                    if cs_level == "URGENT" or highest_level in (None, "WARNING"):
                        highest_level = cs_level
                        highest_msg = cs_msg
                        highest_alert_type = "CREDENTIAL_STUFFING"
                        extra_count = cs_count
                    rule_fired = True

                # --- Regle 11 : Account Enumeration ---
                ae_level, ae_msg, ae_count = check_account_enumeration(ip, details, ts)
                if ae_level:
                    alerts.append(("ACCOUNT_ENUMERATION", ae_level, ae_msg))
                    if not highest_level:
                        highest_level = ae_level
                        highest_msg = ae_msg
                        highest_alert_type = "ACCOUNT_ENUMERATION"
                    rule_fired = True

            # --- Regle 2 : Heure suspecte (BOOST-ONLY) ---
            if is_login_success_action(event_type) or is_login_error_action(event_type):
                is_susp, hour_msg = check_suspicious_hour(ts)
                if is_susp:
                    if rule_fired and highest_level:
                        alerts.append(("HEURE_SUSPECTE", "INFO", hour_msg))
                        if highest_level == "WARNING":
                            highest_level = "CRITICAL"
                            highest_msg = f"{highest_msg} + Heure suspecte ({hour_msg})"

            # --- Regle 3 : Multi-IP ---
            if is_login_success_action(event_type):
                is_multi, ip_msg, ip_count = check_multi_ip(username, ip, ts)
                if is_multi:
                    alerts.append(("MULTI_IP", "CRITICAL", ip_msg))
                    if highest_level in (None, "WARNING"):
                        highest_level = "CRITICAL"
                        highest_msg = ip_msg
                        highest_alert_type = "MULTI_IP"
                    rule_fired = True

                # --- Regle 13 : Impossible Travel ---
                it_level, it_msg, it_count = check_impossible_travel(username, ip, ts)
                if it_level:
                    alerts.append(("IMPOSSIBLE_TRAVEL", it_level, it_msg))
                    if it_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = it_level
                        highest_msg = it_msg
                        highest_alert_type = "IMPOSSIBLE_TRAVEL"
                    rule_fired = True

            # --- Regle 4 : DOS/DDOS ---
            # VOLUME PUR: Skip internal IPs
            dos_level, dos_msg, dos_count = check_dos(ip, ts)
            if dos_level:
                if _skip_volume_alert(ip):
                    logger.debug(f"DOS_DDOS skip (IP interne): {ip} - {dos_count} req")
                else:
                    alerts.append(("DOS_DDOS", dos_level, dos_msg))
                    if dos_level == "URGENT" or not highest_level:
                        highest_level = dos_level
                        highest_msg = dos_msg
                        highest_alert_type = "DOS_DDOS"
                    extra_count = dos_count
                    rule_fired = True

            # --- Regle 5 : Token Theft ---
            if session_id:
                tt_level, tt_msg, tt_count = check_token_theft(session_id, ip, ts)
                if tt_level:
                    alerts.append(("TOKEN_THEFT", tt_level, tt_msg))
                    if tt_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = tt_level
                        highest_msg = tt_msg
                        highest_alert_type = "TOKEN_THEFT"
                    rule_fired = True

                # --- Regle 6 : Session Hijacking ---
                sh_level, sh_msg, sh_count = check_session_hijacking(session_id, user_agent, ts)
                if sh_level:
                    alerts.append(("SESSION_HIJACKING", sh_level, sh_msg))
                    if sh_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = sh_level
                        highest_msg = sh_msg
                        highest_alert_type = "SESSION_HIJACKING"
                    rule_fired = True

                # --- Regle 14 : Session Fixation ---
                sf_level, sf_msg, sf_count = check_session_fixation(session_id, ts, event_type)
                if sf_level:
                    alerts.append(("SESSION_FIXATION", sf_level, sf_msg))
                    if sf_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = sf_level
                        highest_msg = sf_msg
                        highest_alert_type = "SESSION_FIXATION"
                    rule_fired = True

            # --- Regle 8 : Code Interception ---
            if et_lower == 'code_to_token':
                ci_level, ci_msg, ci_count = check_code_interception(username, ip, ts)
                if ci_level:
                    alerts.append(("CODE_INTERCEPTION", ci_level, ci_msg))
                    if ci_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = ci_level
                        highest_msg = ci_msg
                        highest_alert_type = "CODE_INTERCEPTION"
                    rule_fired = True

            # --- Regle 9 : Token Refresh Abuse ---
            if et_lower == 'refresh_token':
                ra_level, ra_msg, ra_count = check_refresh_abuse(username, ts)
                if ra_level:
                    alerts.append(("TOKEN_REFRESH_ABUSE", ra_level, ra_msg))
                    if not highest_level:
                        highest_level = ra_level
                        highest_msg = ra_msg
                        highest_alert_type = "TOKEN_REFRESH_ABUSE"
                    rule_fired = True

            # --- Regle 10 : Privilege Escalation ---
            if is_privilege_escalation_action(event_type):
                pe_level, pe_msg, pe_count = check_privilege_escalation(username, event_type, ts, roles)
                if pe_level:
                    alerts.append(("PRIVILEGE_ESCALATION", pe_level, pe_msg))
                    if pe_level == "CRITICAL" or highest_level in (None, "WARNING"):
                        highest_level = pe_level
                        highest_msg = pe_msg
                        highest_alert_type = "PRIVILEGE_ESCALATION"
                    rule_fired = True

            # --- Regle 12 : DDoS Auth ---
            if is_login_success_action(event_type) or is_login_error_action(event_type):
                ddos_level, ddos_msg, ddos_count = check_ddos_auth(ts)
                if ddos_level:
                    alerts.append(("DDOS_AUTH", ddos_level, ddos_msg))
                    if ddos_level == "URGENT" or highest_level in (None, "WARNING"):
                        highest_level = ddos_level
                        highest_msg = ddos_msg
                        highest_alert_type = "DDOS_AUTH"
                        extra_count = ddos_count
                    rule_fired = True

            # --- Regle 15 : ML Isolation Forest (CONSENSUS UNIQUEMENT) ---
            if ml_model:
                try:
                    # === Features V2 ===
                    attack_feats = _extract_attack_features_v2(event, ip)
                    is_anomaly, score = ml_model.predict(event, attack_features=attack_feats)
                    logger.info(f"ML score: {score:.4f} anomaly={is_anomaly} rule_fired={rule_fired} type={event_type} errors={attack_feats.get('error_count_60s','?')} users={attack_feats.get('distinct_users_ip','?')} rate={attack_feats.get('error_rate_ip','?')} rapid={attack_feats.get('is_rapid_requests','?')}")

                    if rule_fired and score < ML_CONSENSUS_THRESHOLD:
                        if score < ML_ANOMALY_THRESHOLD:
                            ml_msg = f"ML Confirme: Score={score:.3f}"
                            alerts.append(("ML_ISOLATION_FOREST", "CRITICAL", ml_msg))
                            if highest_level == "WARNING":
                                highest_level = "CRITICAL"
                                highest_msg = f"{highest_msg} + ML Confirme ({score:.3f})"
                        else:
                            ml_msg = f"ML Soutien: Score={score:.3f}"
                            alerts.append(("ML_ISOLATION_FOREST", "INFO", ml_msg))

                    elif not rule_fired and is_anomaly:
                        logger.debug(f"ML seul ignore: score={score:.3f} ip={ip} (consensus-only)")
# si score > seuil -> ML ne comfirme pas -> pas dalerte
                except Exception as e:
                    logger.debug(f"ML prediction erreur: {e}")
#-------envoie les alertes ----------
            # ==================================================================
            # TRAITEMENT DES RESULTATS (avec ANTI-SPAM)
            # ==================================================================
            if highest_level:
                # Determiner le type d'alerte principal (celui du plus haut niveau)
                primary_alert_type = highest_alert_type or (alerts[0][0] if alerts else "UNKNOWN")

                # Anti-spam: skip si meme alerte dans les 60s (sauf escalade)
                if not _should_send_alert(primary_alert_type, username, ip, highest_level):
                    skipped_spam += 1
                    # Toujours logger en debug meme si spam
                    logger.debug(f"SPAM skip: {primary_alert_type} {username} {ip} ({highest_level})")
                    # Mais on indexe TOUJOURS dans ES (Kibana doit voir tout)
                    anomaly_doc = {  # spam pas indexe dans ES
                        "timestamp": dt.isoformat(),
                        "detected_at": datetime.now().isoformat(),
                        "type": primary_alert_type,
                        "level": highest_level,
                        "username": username,
                        "event_type": event_type,
                        "ip_address": ip,
                        "session_id": session_id[:8] + "..." if session_id and len(session_id) > 8 else session_id,
                        "message": highest_msg,
                        "all_alerts": [{"type": a[0], "level": a[1], "msg": a[2]} for a in alerts],
                        "source": event.get("source", "unknown"),
                        "alert_count": len(alerts),
                        "is_internal_ip": _is_internal_ip(ip),
                        "ml_consensus": any(a[0] == "ML_ISOLATION_FOREST" for a in alerts),
                        "spam_filtered": True
                    }
                    # index_anomaly(anomaly_doc)  # SKIP: spam pas dans ES
                    continue

                anomaly_count += 1

                logger.warning(f"ALERTE {highest_level} #{anomaly_count} — {username} | {event_type} | {ip}")
                for a_type, a_level, a_msg in alerts:
                    logger.warning(f"  [{a_type}] {a_msg}")

                # Envoyer l'alerte a Slack (anti-spam applique)
                send_slack(username, event_type, ip, highest_level, highest_msg, extra_count, primary_alert_type)

                # Ecrire dans Elasticsearch (toujours)
                anomaly_doc = {
                    "timestamp": dt.isoformat(),
                    "detected_at": datetime.now().isoformat(),
                    "type": primary_alert_type,
                    "level": highest_level,
                    "username": username,
                    "event_type": event_type,
                    "ip_address": ip,
                    "session_id": session_id[:8] + "..." if session_id and len(session_id) > 8 else session_id,
                    "message": highest_msg,
                    "all_alerts": [{"type": a[0], "level": a[1], "msg": a[2]} for a in alerts],
                    "source": event.get("source", "unknown"),
                    "alert_count": len(alerts),
                    "is_internal_ip": _is_internal_ip(ip),
                    "ml_consensus": any(a[0] == "ML_ISOLATION_FOREST" for a in alerts),
                    "spam_filtered": False
                }
                index_anomaly(anomaly_doc)
                respond(anomaly_doc)  # Actions reactives automatiques

            else:
                logger.debug(f"OK {event_type:20} | {username:15} | {ip:15}")

        except Exception as e:
            logger.error(f"Erreur traitement evenement #{total_events}: {e}")
            continue
#log tous les 100 events
        if total_events % 100 == 0:
            logger.info(f"Stats: {total_events} events, {anomaly_count} alertes, {skipped_spam} spam filtre, ES={'OK' if es else 'DOWN'}")

except KeyboardInterrupt:
    logger.info(f"Arret — {total_events} events, {anomaly_count} alertes, {skipped_spam} spam filtre")
finally:
    consumer.close()
    logger.info("Deconnecte de Kafka")
