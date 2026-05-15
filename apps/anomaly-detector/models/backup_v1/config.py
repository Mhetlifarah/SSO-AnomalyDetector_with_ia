#!/usr/bin/env python3
# ==============================================================================
# CONFIG.PY - Configuration du detecteur d'anomalies (VERSION FINALE v3)
# ==============================================================================

import os
from datetime import datetime

KAFKA_BOOTSTRAP = os.getenv('KAFKA_BOOTSTRAP', 'kafka:9092')
KAFKA_TOPIC = os.getenv('KAFKA_TOPIC', 'keycloak-events')
KAFKA_GROUP_ID = os.getenv('KAFKA_GROUP_ID', 'anomaly-detector-group')

MODEL_PATH = "/app/models/isolation_forest.pkl"
SCALER_PATH = "/app/models/scaler.pkl"
NORMAL_EVENTS_FILE = "/app/data/normal_events.json"

BRUTE_FORCE_ATTEMPTS = 5
BRUTE_FORCE_WINDOW_SECONDS = 60

SUSPICIOUS_HOURS = [20, 21, 22, 23, 0, 1, 2, 3, 4, 5, 6]

MAX_IPS_PER_USER = 3
MULTI_IP_WINDOW_SECONDS = 600

DOS_REQUEST_THRESHOLD = 100
DOS_WINDOW_SECONDS = 60

PORT_SCAN_THRESHOLD = 5
PORT_SCAN_WINDOW_SECONDS = 120

WARNING_THRESHOLD = 3
CRITICAL_THRESHOLD = 5
URGENT_THRESHOLD = 10

TOKEN_THEFT_MIN_IPS = 2
TOKEN_THEFT_WINDOW_SECONDS = 300

SESSION_HIJACK_DIFFERENT_UA = 2
SESSION_HIJACK_WINDOW_SECONDS = 300

CREDENTIAL_STUFFING_MIN_USERS = 3
CREDENTIAL_STUFFING_WINDOW_SECONDS = 300

CODE_INTERCEPTION_WINDOW_SECONDS = 120

REFRESH_ABUSE_THRESHOLD = 10
REFRESH_ABUSE_WINDOW_SECONDS = 300

PRIVILEGE_ESCALATION_ACTIONS = [
    'admin_access', 'delete_user', 'manage_roles', 'impersonate',
    'manage_realm', 'view_realm', 'manage_users', 'view_clients',
    'manage_clients', 'manage_events', 'view_events'
]
PRIVILEGE_ESCALATION_ATTEMPTS = 3
PRIVILEGE_ESCALATION_WINDOW_SECONDS = 300

ACCOUNT_ENUM_MIN_ATTEMPTS = 3
ACCOUNT_ENUM_WINDOW_SECONDS = 300
ACCOUNT_ENUM_ERROR_PATTERNS = [
    'user_not_found', 'user not found', 'invalid_user',
    'user disabled', 'account disabled', 'user_temporarily_disabled',
    'invalid username', 'invalid credentials', 'credential_error',
    'username or password', 'auth_fail', 'invalid_user_credentials'
]
DDOS_AUTH_THRESHOLD = 400
DDOS_AUTH_WINDOW_SECONDS = 60

IMPOSSIBLE_TRAVEL_SPEED_KMH = 1000
IMPOSSIBLE_TRAVEL_WINDOW_SECONDS = 3600

SESSION_FIXATION_WINDOW_SECONDS = 1800

NORMAL_TRAINING_SAMPLES = 200
ML_CONTAMINATION = float(os.getenv("ML_CONTAMINATION", "0.10"))
ML_RANDOM_STATE = 42
ML_N_ESTIMATORS = 200
ML_ANOMALY_THRESHOLD = float(os.getenv("ML_ANOMALY_THRESHOLD", "0.08"))
ML_CONSENSUS_ONLY = True
ML_CONSENSUS_THRESHOLD = 0.10

NORMAL_ACTIONS = [
    "view_dashboard", "view_tickets", "view_ticket", "create_ticket",
    "change_status", "view_audit_dashboard", "view_logs", "view_users_list",
    "view_profile", "update_profile", "update_password", "login_attempt",
    "LOGIN", "LOGIN_ERROR", "CODE_TO_TOKEN", "REFRESH_TOKEN",
    "LOGOUT", "TOKEN_EXCHANGE", "INTROSPECT_TOKEN",
]

NORMAL_HOURS_START = 7
NORMAL_HOURS_END = 19

TRUSTED_IP_PREFIXES = ['172.18.', '192.168.', '10.', '172.16.', '172.17.']
KNOWN_SAFE_IPS = ['192.168.222.1', '192.168.222.146', '192.168.222.50']
ATTACKER_IPS = ['192.168.222.143']

ES_HOST = os.getenv("ES_HOST", "http://elasticsearch:9200")
ES_INDEX = os.getenv("ES_INDEX", "security-events")

SLACK_ENABLED = os.getenv("SLACK_ENABLED", "true").lower() == "true"
SLACK_WEBHOOK_URL = os.environ.get("SLACK_WEBHOOK_URL", "")

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_PORT = int(os.getenv("DB_PORT", "5432"))
DB_USER = os.getenv("DB_USER", "pfe")
DB_PASSWORD = os.getenv("DB_PASSWORD", "pfe_secret")

def is_trusted_ip(ip):
    if not ip or ip == "unknown":
        return False
    return any(ip.startswith(prefix) for prefix in TRUSTED_IP_PREFIXES)

def is_internal_ip(ip):
    if not ip or ip == "unknown":
        return False
    if ip in ATTACKER_IPS:
        return False
    if ip in KNOWN_SAFE_IPS:
        return True
    return any(ip.startswith(prefix) for prefix in TRUSTED_IP_PREFIXES)

def is_normal_hour(dt):
    return NORMAL_HOURS_START <= dt.hour < NORMAL_HOURS_END

def is_normal_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in [a.lower() for a in NORMAL_ACTIONS]

def is_login_error_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in ('login_error', 'login error')

def is_login_success_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in ('login', 'login_attempt')

def is_privilege_escalation_action(event_type):
    if not event_type:
        return False
    return event_type.lower() in [a.lower() for a in PRIVILEGE_ESCALATION_ACTIONS]

def is_account_enum_error(details):
    if not details:
        return False
    details_lower = str(details).lower()
    return any(pattern.lower() in details_lower for pattern in ACCOUNT_ENUM_ERROR_PATTERNS)

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
