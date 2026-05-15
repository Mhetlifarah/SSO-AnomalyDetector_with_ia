#!/usr/bin/env python3
# ==============================================================================
# KEYCLOAK_TO_KAFKA.PY — Bridge PostgreSQL → Kafka (VERSION CORRIGÉE V2)
# ==============================================================================
#
# RÔLE : Lit les événements de sécurité dans les BDD PostgreSQL et les
#        envoie vers Apache Kafka pour le détecteur d'anomalies.
#
# ARCHITECTURE :
#   PostgreSQL (4 BDD) → CE SCRIPT → Kafka (topic: keycloak-events)
#
# LES 4 SOURCES (avec les VRAIS noms de colonnes) :
#   1. keycloak-db  → event_entity    (type, event_time bigint, ip_address...)
#   2. iam-db       → audit_log       (username, action, timestamp, ip_address...)
#   3. ticketing-db → ticket_history  (changed_by, changed_at, status, ip_address...)
#   4. audit-db     → action_logs     (username, action, details, timestamp, ip_address...)
#
# EMPLACEMENT : ./scripts/keycloak_to_kafka.py
# ==============================================================================

import json
import time
import psycopg2
from kafka import KafkaProducer
import logging
import os
from datetime import datetime

# ==============================================================================
# LOGGING
# ==============================================================================
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s'
)
logger = logging.getLogger("bridge")

# ==============================================================================
# PARAMÈTRES DE CONNEXION (depuis docker-compose.yml)
# ==============================================================================
PG_HOST = os.getenv("POSTGRES_HOST", "postgres")
PG_USER = os.getenv("POSTGRES_USER", "pfe")
PG_PASS = os.getenv("POSTGRES_PASSWORD", "pfe_secret")

KC_DB    = os.getenv("POSTGRES_DB", "keycloak")
IAM_DB   = os.getenv("IAM_DB_NAME", "iam_db")
TICK_DB  = os.getenv("TICKETING_DB_NAME", "ticketing_db")
AUD_DB   = os.getenv("AUDIT_DB_NAME", "audit_db")

KAFKA_BOOTSTRAP = os.getenv("KAFKA_BOOTSTRAP", "kafka:9092")
KAFKA_TOPIC = os.getenv("KAFKA_TOPIC", "keycloak-events")

# ==============================================================================
# PERSISTANCE — Reprendre où on en était après redémarrage
# ==============================================================================
LAST_TIME_DIR = "/tmp"

def get_last_time(db_name):
    """Lit le dernier timestamp traité. Par défaut : il y a 1 heure."""
    filepath = os.path.join(LAST_TIME_DIR, f"last_time_{db_name}.txt")
    try:
        with open(filepath, 'r') as f:
            return float(f.read().strip())
    except (FileNotFoundError, ValueError):
        return time.time() - 3600

def save_last_time(db_name, ts):
    """Sauvegarde le dernier timestamp traité."""
    filepath = os.path.join(LAST_TIME_DIR, f"last_time_{db_name}.txt")
    try:
        with open(filepath, 'w') as f:
            f.write(str(ts))
    except Exception as e:
        logger.warning(f"Impossible de sauvegarder {filepath}: {e}")

# ==============================================================================
# FONCTIONS UTILITAIRES
# ==============================================================================

def get_connection(dbname):
    """Ouvre une connexion PostgreSQL vers la base spécifiée."""
    return psycopg2.connect(
        host=PG_HOST, port=5432,
        dbname=dbname, user=PG_USER, password=PG_PASS
    )

def table_exists(conn, table_name):
    """
    ⚠️ CRITIQUE : Vérifie si une table existe AVANT de requêter.
    Sans cette vérification, le bridge CRASH si la table n'existe pas.
    """
    try:
        with conn.cursor() as cur:
            cur.execute("""
                SELECT EXISTS (
                    SELECT 1 FROM information_schema.tables
                    WHERE table_schema = 'public' AND table_name = %s
                )
            """, (table_name,))
            return cur.fetchone()[0]
    except Exception as e:
        logger.warning(f"Erreur vérification table {table_name}: {e}")
        return False

# ==============================================================================
# PRODUCTEUR KAFKA (avec retry)
# ==============================================================================

def create_producer():
    """Crée le producteur Kafka avec retry automatique."""
    for attempt in range(24):
        try:
            producer = KafkaProducer(
                bootstrap_servers=KAFKA_BOOTSTRAP.split(','),
                value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                key_serializer=lambda k: str(k).encode('utf-8') if k else None,
                acks='all',
                retries=3,
                retry_backoff_ms=1000
            )
            logger.info(f"Producteur Kafka connecté: {KAFKA_BOOTSTRAP}")
            return producer
        except Exception as e:
            logger.warning(f"Tentative {attempt+1}/24 - Kafka non prêt: {e}")
            time.sleep(5)
    logger.error("Impossible de se connecter à Kafka après 2 minutes")
    return None

# ==============================================================================
# PARTIE 1 : Keycloak event_entity
# ==============================================================================
# Colonnes réelles :
#   id (varchar), client_id, details_json, error, ip_address,
#   realm_id, session_id, event_time (BIGINT millisecondes !),
#   type (varchar), user_id
#
# ⚠️ event_time = BIGINT en millisecondes, PAS un timestamp SQL !
# ⚠️ La colonne s'appelle "type", PAS "event_type" !
# ==============================================================================
def poll_keycloak_events(producer):
    """Lit les événements Keycloak depuis event_entity."""
    last_time = get_last_time("keycloak")

    try:
        conn = get_connection(KC_DB)

        if not table_exists(conn, "event_entity"):
            logger.warning("[Keycloak] Table event_entity inexistante — ignorée")
            conn.close()
            return

        with conn.cursor() as cur:
            # event_time est un BIGINT en millisecondes
            # Convertir last_time (secondes) en millisecondes pour la comparaison
            last_time_ms = int(last_time * 1000)

            cur.execute("""
                SELECT e.id, e.event_time, e.realm_id, e.client_id, e.user_id,
                       e.session_id, e.ip_address, e.error, e.type, u.username
                FROM event_entity e LEFT JOIN user_entity u ON e.user_id = u.id
                WHERE e.event_time > %s
                ORDER BY e.event_time ASC
                LIMIT 500
            """, (last_time_ms,))

            rows = cur.fetchall()
            count = 0
            max_time_ms = last_time_ms

            for row in rows:
                event_id, evt_time, realm_id, client_id, user_id, \
                    session_id, ip_address, error, evt_type, username = row

                event = {
                    "source": "keycloak",
                    "event_id": str(event_id),
                    "event_time": evt_time,                          # Bigint millisecondes
                    "timestamp": datetime.fromtimestamp(evt_time / 1000.0).isoformat(),
                    "realm": realm_id,
                    "client": client_id,
                    "user_id": user_id,
                    "username": username or "",
                    "session_id": session_id,
                    "ip_address": ip_address or "unknown",
                    "error": error,
                    "event_type": evt_type,                          # ⚠️ "type" → "event_type" dans Kafka
                    "is_login": evt_type == "LOGIN",
                    "is_login_error": evt_type == "LOGIN_ERROR"
                }

                producer.send(KAFKA_TOPIC, key=user_id or "unknown", value=event)
                count += 1

                # Garder le timestamp le plus élevé
                if evt_time > max_time_ms:
                    max_time_ms = evt_time

            if rows:
                # Sauvegarder en secondes
                save_last_time("keycloak", max_time_ms / 1000.0)
                logger.info(f"[Keycloak] {count} événements envoyés")

        conn.close()

    except Exception as e:
        logger.error(f"[Keycloak] Erreur lecture event_entity: {e}")


# ==============================================================================
# PARTIE 2 : IAM audit_log
# ==============================================================================
# Colonnes réelles :
#   id (integer), keycloak_id, username, action, timestamp (timestamp SQL),
#   ip_address, user_agent, hour_of_day, session_id
#
# ⚠️ La table s'appelle "audit_log" dans iam_db, PAS "access_log" !
# ==============================================================================
def poll_iam_events(producer):
    """Lit les événements IAM depuis audit_log."""
    last_time = get_last_time("iam")

    try:
        conn = get_connection(IAM_DB)

        # ⚠️ La table s'appelle audit_log, PAS access_log !
        if not table_exists(conn, "audit_log"):
            logger.warning("[IAM] Table audit_log inexistante — ignorée")
            conn.close()
            return

        with conn.cursor() as cur:
            last_dt = datetime.fromtimestamp(last_time)

            cur.execute("""
                SELECT id, timestamp, username, action, ip_address,
                       user_agent, session_id, keycloak_id
                FROM audit_log
                WHERE timestamp > %s
                ORDER BY timestamp ASC
                LIMIT 500
            """, (last_dt,))

            rows = cur.fetchall()
            count = 0
            max_time = last_time

            for row in rows:
                event_id, ts, username, action, ip_address, \
                    user_agent, session_id, keycloak_id = row

                ts_float = ts.timestamp() if hasattr(ts, 'timestamp') else last_time

                event = {
                    "source": "iam",
                    "event_id": str(event_id),
                    "event_time": ts_float * 1000,                   # Convertir en millisecondes
                    "timestamp": str(ts),
                    "user_id": keycloak_id or username,              # keycloak_id en priorité
                    "username": username,
                    "action": action,
                    "ip_address": ip_address or "unknown",
                    "user_agent": user_agent or "",
                    "session_id": session_id,
                    "event_type": action,                             # action comme event_type
                    "is_login": action and action.lower() in ("login", "authenticate"),
                    "is_login_error": action and action.lower() in ("login_error", "login_failed", "access_denied")
                }

                producer.send(KAFKA_TOPIC, key=username or "unknown", value=event)
                count += 1
                if ts_float > max_time:
                    max_time = ts_float

            if rows:
                save_last_time("iam", max_time)
                logger.info(f"[IAM] {count} événements envoyés")

        conn.close()

    except Exception as e:
        logger.error(f"[IAM] Erreur lecture audit_log: {e}")


# ==============================================================================
# PARTIE 3 : Ticketing ticket_history
# ==============================================================================
# Colonnes réelles :
#   id (integer), ticket_id, status, changed_by (varchar),
#   changed_at (timestamp), ip_address, user_agent, hour_of_day, session_id
#
# ⚠️ PAS de colonne "created_at" → c'est "changed_at" !
# ⚠️ PAS de colonne "user_id" → c'est "changed_by" !
# ⚠️ PAS de colonne "action" → on utilise "status" comme action !
# ==============================================================================
def poll_ticketing_events(producer):
    """Lit les événements Ticketing depuis ticket_history."""
    last_time = get_last_time("ticketing")

    try:
        conn = get_connection(TICK_DB)

        if not table_exists(conn, "ticket_history"):
            logger.warning("[Ticketing] Table ticket_history inexistante — ignorée")
            conn.close()
            return

        with conn.cursor() as cur:
            last_dt = datetime.fromtimestamp(last_time)

            # ⚠️ Colonnes réelles : changed_by, changed_at, status
            cur.execute("""
                SELECT id, changed_at, changed_by, status, ip_address,
                       user_agent, session_id, ticket_id
                FROM ticket_history
                WHERE changed_at > %s
                ORDER BY changed_at ASC
                LIMIT 500
            """, (last_dt,))

            rows = cur.fetchall()
            count = 0
            max_time = last_time

            for row in rows:
                event_id, ts, changed_by, status, ip_address, \
                    user_agent, session_id, ticket_id = row

                ts_float = ts.timestamp() if hasattr(ts, 'timestamp') else last_time

                # Construire un event_type à partir du status
                event_type = f"TICKET_{status.upper()}" if status else "TICKET_ACTION"

                event = {
                    "source": "ticketing",
                    "event_id": str(event_id),
                    "event_time": ts_float * 1000,
                    "timestamp": str(ts),
                    "user_id": changed_by,                           # changed_by = l'utilisateur
                    "username": changed_by,
                    "action": status,                                # status comme action
                    "status": status,
                    "ticket_id": ticket_id,
                    "ip_address": ip_address or "unknown",
                    "user_agent": user_agent or "",
                    "session_id": session_id,
                    "event_type": event_type,
                    "is_login": status and status.lower() in ("login", "opened"),
                    "is_login_error": status and status.lower() in ("login_error", "access_denied", "closed")
                }

                producer.send(KAFKA_TOPIC, key=changed_by or "unknown", value=event)
                count += 1
                if ts_float > max_time:
                    max_time = ts_float

            if rows:
                save_last_time("ticketing", max_time)
                logger.info(f"[Ticketing] {count} événements envoyés")

        conn.close()

    except Exception as e:
        logger.error(f"[Ticketing] Erreur lecture ticket_history: {e}")


# ==============================================================================
# PARTIE 4 : Audit action_logs
# ==============================================================================
# Colonnes réelles :
#   id (integer), keycloak_id, username, action, details (text),
#   timestamp (timestamp), ip_address, user_agent, hour_of_day, session_id
#
# ⚠️ La table s'appelle "action_logs", PAS "audit_events" !
# ==============================================================================
def poll_audit_events(producer):
    """Lit les événements Audit depuis action_logs."""
    last_time = get_last_time("audit")

    try:
        conn = get_connection(AUD_DB)

        # ⚠️ La table s'appelle action_logs, PAS audit_events !
        if not table_exists(conn, "action_logs"):
            logger.warning("[Audit] Table action_logs inexistante — ignorée")
            conn.close()
            return

        with conn.cursor() as cur:
            last_dt = datetime.fromtimestamp(last_time)

            cur.execute("""
                SELECT id, timestamp, username, action, ip_address,
                       user_agent, session_id, keycloak_id, details
                FROM action_logs
                WHERE timestamp > %s
                ORDER BY timestamp ASC
                LIMIT 500
            """, (last_dt,))

            rows = cur.fetchall()
            count = 0
            max_time = last_time

            for row in rows:
                event_id, ts, username, action, ip_address, \
                    user_agent, session_id, keycloak_id, details = row

                ts_float = ts.timestamp() if hasattr(ts, 'timestamp') else last_time

                event = {
                    "source": "audit",
                    "event_id": str(event_id),
                    "event_time": ts_float * 1000,
                    "timestamp": str(ts),
                    "user_id": keycloak_id or username,
                    "username": username,
                    "action": action,
                    "details": details or "",
                    "ip_address": ip_address or "unknown",
                    "user_agent": user_agent or "",
                    "session_id": session_id,
                    "event_type": action,
                    "is_login": action and action.lower() in ("login", "authenticate"),
                    "is_login_error": action and action.lower() in ("login_error", "access_denied", "failure")
                }

                producer.send(KAFKA_TOPIC, key=username or "unknown", value=event)
                count += 1
                if ts_float > max_time:
                    max_time = ts_float

            if rows:
                save_last_time("audit", max_time)
                logger.info(f"[Audit] {count} événements envoyés")

        conn.close()

    except Exception as e:
        logger.error(f"[Audit] Erreur lecture action_logs: {e}")


# ==============================================================================
# BOUCLE PRINCIPALE
# ==============================================================================
if __name__ == "__main__":
    logger.info("=" * 60)
    logger.info("Bridge Keycloak → Kafka : démarrage")
    logger.info(f"  Kafka     : {KAFKA_BOOTSTRAP}")
    logger.info(f"  Topic     : {KAFKA_TOPIC}")
    logger.info(f"  PostgreSQL: {PG_HOST}")
    logger.info(f"  BDD       : {KC_DB}, {IAM_DB}, {TICK_DB}, {AUD_DB}")
    logger.info("=" * 60)

    logger.info("Attente 15s pour le démarrage des services...")
    time.sleep(15)

    producer = create_producer()
    if producer is None:
        logger.error("Impossible de démarrer sans Kafka. Arrêt.")
        exit(1)

    logger.info("Bridge actif — lecture des événements toutes les 5 secondes")
    cycle = 0

    while True:
        try:
            cycle += 1

            poll_keycloak_events(producer)     # event_entity (type, event_time bigint)
            # poll_iam_events(producer)  # DESACTIVE: kafka_logger fait deja          # audit_log (username, action, timestamp)
            # poll_ticketing_events(producer)  # DESACTIVE: kafka_logger fait deja    # ticket_history (changed_by, changed_at, status)
            # poll_audit_events(producer)  # DESACTIVE: kafka_logger fait deja        # action_logs (username, action, timestamp)

            producer.flush()

            if cycle % 12 == 0:
                logger.info(f"Bridge actif — cycle #{cycle}")

            time.sleep(5)

        except KeyboardInterrupt:
            logger.info("Arrêt du bridge (Ctrl+C)")
            break
        except Exception as e:
            logger.error(f"Erreur boucle principale: {e}")
            time.sleep(10)

    if producer:
        producer.close()
        logger.info("Producteur Kafka fermé")
