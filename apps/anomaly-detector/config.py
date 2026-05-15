#!/usr/bin/env python3
# ==============================================================================
# CONFIG.PY - Configuration du detecteur d'anomalies (VERSION FINALE v3)
# ==============================================================================

import os
from datetime import datetime
# ---------------- definisse les parametres kafka kifeh le detecteur se connecte au brocker ---------
KAFKA_BOOTSTRAP = os.getenv('KAFKA_BOOTSTRAP', 'kafka:9092') #specifie @ srv kafka
KAFKA_TOPIC = os.getenv('KAFKA_TOPIC', 'keycloak-events')
KAFKA_GROUP_ID = os.getenv('KAFKA_GROUP_ID', 'anomaly-detector-group') #identifier le grp de C°
# ==================== CHEMINS FICHIERS ====================
MODEL_PATH = "/app/models/isolation_forest.pkl" #Emplacement du modèle ML
SCALER_PATH = "/app/models/scaler.pkl" #Emplacement du normaliseur
NORMAL_EVENTS_FILE = "/app/data/normal_events.json" #Emplacement de Fichier des événements normaux
#--------------- definisse les SEUILS  de detections pour les 14 attaques ---------------------------
#BF
BRUTE_FORCE_ATTEMPTS = 5
BRUTE_FORCE_WINDOW_SECONDS = 60
#heure suspects
SUSPICIOUS_HOURS = [20, 21, 22, 23, 0, 1, 2, 3, 4, 5, 6]
#multi ips 3/10min
MAX_IPS_PER_USER = 3
MULTI_IP_WINDOW_SECONDS = 600
#dos/ddos
DOS_REQUEST_THRESHOLD = 100
DOS_WINDOW_SECONDS = 60
#scan de port
PORT_SCAN_THRESHOLD = 5
PORT_SCAN_WINDOW_SECONDS = 120
#nv alertes -- x errors
WARNING_THRESHOLD = 3
CRITICAL_THRESHOLD = 5
URGENT_THRESHOLD = 10
#vol token 2ip diff  => 5min
TOKEN_THEFT_MIN_IPS = 2
TOKEN_THEFT_WINDOW_SECONDS = 300
#hijacking 2navigators =>5min
SESSION_HIJACK_DIFFERENT_UA = 2
SESSION_HIJACK_WINDOW_SECONDS = 300
# credential stuff 3users => 5min
CREDENTIAL_STUFFING_MIN_USERS = 3
CREDENTIAL_STUFFING_WINDOW_SECONDS = 300
#fenetres dinterception 2min
CODE_INTERCEPTION_WINDOW_SECONDS = 120 #MITM attaquant intercept communication +vol code contre token
#refresh token abuse ===> attaquant utilise refresh token en boucle pour recoit le token
REFRESH_ABUSE_THRESHOLD = 10
REFRESH_ABUSE_WINDOW_SECONDS = 300
# previlege escalation
PRIVILEGE_ESCALATION_ACTIONS = [
    'admin_access', 'delete_user', 'manage_roles', 'impersonate',
    'manage_realm', 'view_realm', 'manage_users', 'view_clients',
    'manage_clients', 'manage_events', 'view_events'
]
PRIVILEGE_ESCALATION_ATTEMPTS = 3
PRIVILEGE_ESCALATION_WINDOW_SECONDS = 300
#account  ennum ====> users inconnue par le keycloak
ACCOUNT_ENUM_MIN_ATTEMPTS = 3
ACCOUNT_ENUM_WINDOW_SECONDS = 300
ACCOUNT_ENUM_ERROR_PATTERNS = [
    'user_not_found', 'user not found', 'invalid_user',
    'user disabled', 'account disabled', 'user_temporarily_disabled',
    'invalid username', 'invalid credentials', 'credential_error',
    'username or password', 'auth_fail', 'invalid_user_credentials' # msgs standard de keycloak
]
#dos auth
DDOS_AUTH_THRESHOLD = 400
DDOS_AUTH_WINDOW_SECONDS = 60
#vitessse de changement de ip impossible
IMPOSSIBLE_TRAVEL_SPEED_KMH = 1000
IMPOSSIBLE_TRAVEL_WINDOW_SECONDS = 3600
# session fixation 30min
SESSION_FIXATION_WINDOW_SECONDS = 1800
#----------------  Parametres ML iF -------------
NORMAL_TRAINING_SAMPLES = 200 #200 echantillons pour train
ML_CONTAMINATION = float(os.getenv("ML_CONTAMINATION", "0.10")) #10% anormal mil dataset
ML_RANDOM_STATE = 42 #pour reproduire les rst
ML_N_ESTIMATORS = 200 #200 arbres de la forest
ML_ANOMALY_THRESHOLD = float(os.getenv("ML_ANOMALY_THRESHOLD", "0.08")) #seuil < 0.08 = anomalie critical
ML_CONSENSUS_ONLY = True #confirme les regles
ML_CONSENSUS_THRESHOLD = 0.10 #seuil < 0.010 = ml confirme la regle
#---- actions normal -
NORMAL_ACTIONS = [
    "view_dashboard", "view_tickets", "view_ticket", "create_ticket",
    "change_status", "view_audit_dashboard", "view_logs", "view_users_list",
    "view_profile", "update_profile", "update_password", "login_attempt",
    "LOGIN", "LOGIN_ERROR", "CODE_TO_TOKEN", "REFRESH_TOKEN",
    "LOGOUT", "TOKEN_EXCHANGE", "INTROSPECT_TOKEN",
]
#---- heures bureau -
NORMAL_HOURS_START = 7
NORMAL_HOURS_END = 19
#----- ips internes de sté
TRUSTED_IP_PREFIXES = ['172.18.', '192.168.', '10.', '172.16.', '172.17.']
KNOWN_SAFE_IPS = ['192.168.222.1', '192.168.222.146', '192.168.222.50']
ATTACKER_IPS = ['192.168.222.143']
# ES
ES_HOST = os.getenv("ES_HOST", "http://elasticsearch:9200")
ES_INDEX = os.getenv("ES_INDEX", "security-events")
# slack
# cnx a db (postgresql)
DB_HOST = os.getenv("DB_HOST", "postgres") #ou se trouve le postgres ( nom container)
DB_PORT = int(os.getenv("DB_PORT", "5432")) #port par defaut de postgres
DB_USER = os.getenv("DB_USER", "pfe") #nom de user pour se connecter
DB_PASSWORD = os.getenv("DB_PASSWORD", "pfe_secret") #mot de passe pour ce connecter
#--------------- les fcts appelleeeé par des autres files de detecteur ---------------
# definisse les @appartient R  interne de la sté
def is_trusted_ip(ip):
    if not ip or ip == "unknown":
        return False
    return any(ip.startswith(prefix) for prefix in TRUSTED_IP_PREFIXES)
# verifie ips interne + securise
def is_internal_ip(ip):
    if not ip or ip == "unknown":
        return False
    if ip in ATTACKER_IPS:
        return False
    if ip in KNOWN_SAFE_IPS:
        return True
    return any(ip.startswith(prefix) for prefix in TRUSTED_IP_PREFIXES)
# definisse les heures de bureau de la sté
def is_normal_hour(dt):
    return NORMAL_HOURS_START <= dt.hour < NORMAL_HOURS_END
# definisse les events dans le whitelist
def is_normal_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in [a.lower() for a in NORMAL_ACTIONS]
#verifie si laction est une error de cnx
def is_login_error_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in ('login_error', 'login error')
#verifie si action est une cnx reussie
def is_login_success_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in ('login', 'login_attempt')
#verifier action est une tentative delevation de privilege
def is_privilege_escalation_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in [a.lower() for a in PRIVILEGE_ESCALATION_ACTIONS]
#verifie si error est une tentative dennumeration users
def is_account_enum_error(details):
    if not details:
        return False
    details_lower = str(details).lower()
    return any(pattern.lower() in details_lower for pattern in ACCOUNT_ENUM_ERROR_PATTERNS)
#convert timestamp
def parse_event_time(event_time):
    if event_time is None:
        return datetime.now().timestamp()
    if isinstance(event_time, (int, float)):
        if event_time > 1e12:
            return event_time / 1000.0
        return event_time
    if isinstance(event_time, str):
        for fmt in ['%Y-%m-%d %H:%M:%S.%f', '%Y-%m-%d %H:%M:%S']:
            try:
                return datetime.strptime(event_time, fmt).timestamp()
            except ValueError:
                continue
        try:
            return datetime.fromisoformat(event_time.replace(' ', 'T')).timestamp()
        except (ValueError, AttributeError):
            pass
    return datetime.now().timestamp()
#estime distance geo entre 2 ips diff (voyage impossible)
def estimate_ip_distance(ip1, ip2):
    if ip1 == ip2:
        return 0
    if ip1 and ip2 and '.' in ip1 and '.' in ip2:
        prefix1 = '.'.join(ip1.split('.')[:3])
        prefix2 = '.'.join(ip2.split('.')[:3])
        if prefix1 == prefix2:
            return 1
    if is_trusted_ip(ip1) and is_trusted_ip(ip2):
        return 5
    return 1000

# --- Elasticsearch Auth ---
ES_USER = os.getenv("ES_USER", "elastic")
ES_PASS = os.getenv("ES_PASS", "changeme")
ES_VERIFY = os.getenv("ES_VERIFY", "false").lower() == "true"

# --- Slack ---
SLACK_ENABLED = os.getenv("SLACK_ENABLED", "false").lower() == "true"
SLACK_WEBHOOK_URL = os.getenv("SLACK_WEBHOOK_URL", "")
SLACK_MIN_SEVERITY = os.getenv("SLACK_MIN_SEVERITY", "HIGH")

# --- Kibana ---
KIBANA_URL = os.getenv("KIBANA_URL", "http://kibana:5601") #url pour cncte au kibana (Tb)

# --- Responder (actions reactives) ---
RESPONDER_ENABLED = os.getenv("RESPONDER_ENABLED", "true").lower() == "true" #activer/desactiver les act reactiv
KC_ADMIN_URL = os.getenv("KC_ADMIN_URL", "http://keycloak:8080") #@ keycloka pour les actions admin
KC_ADMIN_USER = os.getenv("KC_ADMIN_USER", "admin") #compte
KC_ADMIN_PASS = os.getenv("KC_ADMIN_PASS", "Admin-Admin-pfe-99")
KC_REALM = os.getenv("KC_REALM", "master") #master (admin)
NGINX_BAN_DIR = os.getenv("NGINX_BAN_DIR", "/shared/nginx") #dossier nginx ou stock les ip bannies
BAN_DURATION = int(os.getenv("BAN_DURATION", "3600")) #duree de bannissent en s (3600 = 1h )
KC_TARGET_REALM = os.getenv("KC_TARGET_REALM", "pfe")
