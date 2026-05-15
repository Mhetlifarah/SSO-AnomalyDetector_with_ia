#!/usr/bin/env python3
# ==============================================================================
# TRAIN_MODEL.PY v7 — Dataset élargi (10 000+ events) + contamination 0.15
# ==============================================================================
# AMÉLIORATIONS v7:
#   1. 8500 événements normaux (au lieu de 2700)
#   2. 1500 événements d'attaque (au lieu de 230) — 7 types
#   3. avg_interval_sec VARIABLE (0.5-600s selon le type)
#   4. n_distinct_clients VARIABLE (1-5 selon le type)
#   5. contamination=0.15 (via config.py)
#   6. n_estimators=200 (au lieu de 100)
#script genere dataset ( normal+attaques)===> pour apprendre modele a distinhuer normal/anormal
# ==============================================================================

import json
import numpy as np
import sys
import time
import random
import logging
from datetime import datetime, timedelta
from collections import Counter
#lister les events en temp reels
from confluent_kafka import Consumer

sys.path.append('/app')
from config import * #lire tous les seuils , ips, actions, depuis conf.py
from models.isolation_forest import AnomalyDetectorModel

logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger("train-v7")

# --- Constantes ---
BROWSER_IP = "192.168.222.1"
KALI_IP = "192.168.222.143"
#ip extern
UNKNOWN_IPS = ["45.33.32.156", "91.240.118.172", "185.220.101.34", "104.248.12.37", "198.51.100.22"]
#users ligitimes /roles/actions
USERS = {
    "alice": {
        "role": "admin",
        "actions": ["view_dashboard", "view_profile", "view_users_list", "view_user_detail",
                     "view_audit_logs", "change_user_role", "view_tickets", "view_ticket_detail",
                     "view_new_ticket_form", "create_ticket", "change_ticket_status",
                     "view_audit_dashboard", "view_all_logs", "login_attempt", "logout"],
    },
    "bob": {
        "role": "manager+support",
        "actions": ["view_dashboard", "view_profile", "view_users_list", "view_user_detail",
                     "view_audit_logs", "view_tickets", "view_ticket_detail", "view_new_ticket_form",
                     "create_ticket", "change_ticket_status", "view_audit_dashboard",
                     "login_attempt", "logout"],
    },
    "charlie": {
        "role": "user",
        "actions": ["view_dashboard", "view_profile", "view_users_list", "view_user_detail",
                     "view_tickets", "view_ticket_detail", "view_new_ticket_form", "create_ticket",
                     "view_audit_dashboard", "login_attempt", "logout"],
    },
}
#actions/apps source
ACTION_SOURCE_MAP = {
    "view_dashboard": "iam", "view_profile": "iam", "view_users_list": "iam",
    "view_user_detail": "iam", "view_audit_logs": "iam", "change_user_role": "iam",
    "view_tickets": "ticketing", "view_ticket_detail": "ticketing",
    "view_new_ticket_form": "ticketing", "create_ticket": "ticketing",
    "change_ticket_status": "ticketing", "view_audit_dashboard": "audit",
    "view_all_logs": "audit", "login_attempt": "keycloak", "logout": "keycloak",
}

#------- construit des events format kafka-------
def make_event(username, event_type, ip, dt, source=None, is_login=0, is_login_error=0,
               error=None, client_id=None, session_id=None,
               avg_interval_sec=None, n_distinct_clients=None):
    """Construit un evenement Kafka avec les DEUX champs event_type + action."""
    event_time_ms = int(dt.timestamp() * 1000)
    event = {
        "event_type": event_type,
        "action": event_type,
        "ip_address": ip,
        "username": username,
        "event_time": event_time_ms,
        "source": source or ACTION_SOURCE_MAP.get(event_type, "unknown"),
        "is_login": is_login,
        "is_login_error": is_login_error,
    }
    if error:
        event["error"] = error
    if client_id:
        event["client"] = client_id
        event["realm"] = "pfe"
    if session_id:
        event["session_id"] = session_id
    # Features du binôme — TOUJOURS variables
    if avg_interval_sec is not None:
        event["avg_interval_sec"] = avg_interval_sec
    else:
        event["avg_interval_sec"] = random.uniform(30, 600)
    if n_distinct_clients is not None:
        event["n_distinct_clients"] = n_distinct_clients
    else:
        event["n_distinct_clients"] = random.randint(1, 3)
    return event

#generes des id UUID random
def random_session_id():
    return f"{random.randint(0,0xffffffff):08x}-{random.randint(0,0xffff):04x}-{random.randint(0,0xffff):04x}-{random.randint(0,0xffff):04x}-{random.randint(0,0xffffffffffff):012x}"

#genere timestamp random hrure de bureau
def random_working_datetime(base_date, days_back=30):
    day_offset = random.randint(0, days_back)
    candidate = base_date - timedelta(days=day_offset)
    while candidate.weekday() >= 5:
        candidate -= timedelta(days=1)
    return candidate.replace(hour=random.randint(8, 17), minute=random.randint(0, 59),
                             second=random.randint(0, 59), microsecond=random.randint(0, 999999))

#collecte vrais events mn kafka ****   pour enrechit dattaset
def collect_real_events(max_events=200, timeout_seconds=30):
    logger.info(f"Collecte evenements reels depuis Kafka...")
    conf = {
        'bootstrap.servers': KAFKA_BOOTSTRAP,
        'group.id': 'model-trainer-v7',
        'auto.offset.reset': 'earliest',
        'enable.auto.commit': True
    }
    consumer = Consumer(conf)
    consumer.subscribe([KAFKA_TOPIC])
    events = []
    start = time.time()
    try:
        while len(events) < max_events:
            if time.time() - start > timeout_seconds:
                break
            msg = consumer.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                continue
            try:
                events.append(json.loads(msg.value().decode('utf-8')))
            except:
                continue
    except Exception as e:
        logger.warning(f"Erreur Kafka: {e}")
    finally:
        consumer.close()
    logger.info(f"Collecte {len(events)} evenements reels")
    return events

#genere normal events
def generate_normal_events(n=8500):
    logger.info(f"Generation evenements normaux ({n})...")
    events = []
    base_date = datetime.now()
    user_names = list(USERS.keys())
    user_weights = [0.45, 0.35, 0.20]

    # Actions Flask (70%)
    flask_count = int(n * 0.70)
    for _ in range(flask_count):
        username = random.choices(user_names, weights=user_weights, k=1)[0]
        action = random.choice(USERS[username]["actions"])
        dt = random_working_datetime(base_date, 30)
        is_login = 1 if action == "login_attempt" else 0
        events.append(make_event(username, action, BROWSER_IP, dt,
                                 is_login=is_login, is_login_error=0,
                                 session_id=random_session_id() if is_login or random.random() > 0.3 else None,
                                 avg_interval_sec=random.uniform(30, 600),
                                 n_distinct_clients=random.randint(1, 3)))

    # Actions Keycloak (20%)
    kc_count = int(n * 0.20)
    kc_actions = [("LOGIN", 1, 0), ("CODE_TO_TOKEN", 0, 0), ("REFRESH_TOKEN", 0, 0), ("LOGOUT", 0, 0)]
    for _ in range(kc_count):
        username = random.choices(user_names, weights=user_weights, k=1)[0]
        action, is_login, is_login_error = random.choice(kc_actions)
        dt = random_working_datetime(base_date, 30)
        events.append(make_event(username, action, BROWSER_IP, dt, source="keycloak",
                                 is_login=is_login, is_login_error=is_login_error,
                                 client_id=random.choice(["app-iam", "app-ticketing", "app-audit"]),
                                 session_id=random_session_id(),
                                 avg_interval_sec=random.uniform(60, 600),
                                 n_distinct_clients=random.randint(1, 3)))

    # Rares erreurs de login légitimes (5%)
    error_count = int(n * 0.05)
    for _ in range(error_count):
        username = random.choices(user_names, weights=user_weights, k=1)[0]
        dt = random_working_datetime(base_date, 30)
        events.append(make_event(username, "LOGIN_ERROR", BROWSER_IP, dt, source="keycloak",
                                 is_login_error=1, error="invalid_credentials",
                                 client_id=random.choice(["app-iam", "app-ticketing"]),
                                 avg_interval_sec=random.uniform(60, 600),
                                 n_distinct_clients=random.randint(1, 3)))

    # Actions weekend/soir rares mais légitimes (5%)
    rare_count = int(n * 0.05)
    for _ in range(rare_count):
        username = random.choices(user_names, weights=user_weights, k=1)[0]
        action = random.choice(["login_attempt", "view_dashboard", "view_tickets"])
        rare_hour = random.choice([6, 7, 19, 20, 21])
        dt = (base_date - timedelta(days=random.randint(0, 30))).replace(
            hour=rare_hour, minute=random.randint(0, 59), second=random.randint(0, 59))
        events.append(make_event(username, action, BROWSER_IP, dt,
                                 is_login=1 if action == "login_attempt" else 0,
                                 avg_interval_sec=random.uniform(120, 900),
                                 n_distinct_clients=random.randint(1, 2)))

    logger.info(f"  {len(events)} evenements normaux generes")
    return events

#generer des attques 7 types diff
def generate_attack_events(n=1500):
    logger.info(f"Generation evenements d'attaque ({n})...")
    events = []
    base_date = datetime.now()
    per_type = n // 7

    # 1. BRUTE FORCE: erreurs rapides depuis Kali
    for _ in range(per_type):
        dt = (base_date - timedelta(days=random.randint(0, 10))).replace(
            hour=random.randint(0, 23), minute=random.randint(0, 59), second=random.randint(0, 59))
        events.append(make_event(random.choice(["alice", "bob", "charlie"]), "LOGIN_ERROR", KALI_IP, dt,
                                 source="keycloak", is_login_error=1, error="invalid_credentials",
                                 client_id="app-iam",
                                 avg_interval_sec=random.uniform(0.5, 3.0),
                                 n_distinct_clients=1))

    # 2. CREDENTIAL_STUFFING: erreurs login multi-users même IP
    for _ in range(per_type):
        username = random.choice(["alice", "bob", "charlie", "admin"])
        dt = (base_date - timedelta(days=random.randint(0, 10))).replace(
            hour=random.randint(0, 23), minute=random.randint(0, 59), second=random.randint(0, 59))
        events.append(make_event(username, "LOGIN_ERROR", KALI_IP if random.random() < 0.7 else random.choice(UNKNOWN_IPS),
                                 dt, source="keycloak", is_login_error=1, error="invalid_credentials",
                                 client_id="app-iam",
                                 avg_interval_sec=random.uniform(1.0, 10.0),
                                 n_distinct_clients=1))

    # 3. NIGHT LOGIN: connexion heures suspectes
    for _ in range(per_type):
        night_hour = random.choice(list(range(0, 6)) + list(range(22, 24)))
        dt = (base_date - timedelta(days=random.randint(0, 15))).replace(
            hour=night_hour, minute=random.randint(0, 59), second=random.randint(0, 59))
        username = random.choice(["alice", "bob", "charlie"])
        events.append(make_event(username, "LOGIN", KALI_IP if random.random() < 0.5 else random.choice(UNKNOWN_IPS),
                                 dt, source="keycloak", is_login=1,
                                 client_id=random.choice(["app-iam", "app-ticketing"]),
                                 session_id=random_session_id(),
                                 avg_interval_sec=random.uniform(5, 60),
                                 n_distinct_clients=random.randint(1, 2)))

    # 4. EXTERNAL IP: connexion depuis IP inconnue
    for _ in range(per_type):
        dt = random_working_datetime(base_date, 15)
        events.append(make_event(random.choice(["alice", "bob"]), "LOGIN",
                                 random.choice(UNKNOWN_IPS), dt, source="keycloak",
                                 is_login=1,
                                 client_id=random.choice(["app-iam", "app-ticketing"]),
                                 session_id=random_session_id(),
                                 avg_interval_sec=random.uniform(5, 60),
                                 n_distinct_clients=random.randint(1, 2)))

    # 5. PRIVILEGE ESCALATION: user fait action admin
    for _ in range(per_type):
        action = random.choice(["change_user_role", "view_all_logs", "change_ticket_status"])
        dt = random_working_datetime(base_date, 15)
        events.append(make_event("charlie", action,
                                 random.choice(UNKNOWN_IPS) if random.random() < 0.4 else BROWSER_IP,
                                 dt, session_id=random_session_id(),
                                 avg_interval_sec=random.uniform(10, 120),
                                 n_distinct_clients=random.randint(1, 2)))

    # 6. TOKEN_THEFT: session depuis 2 IPs rapidement
    for _ in range(per_type):
        dt = random_working_datetime(base_date, 15)
        events.append(make_event(random.choice(["alice", "bob"]), "REFRESH_TOKEN",
                                 random.choice(UNKNOWN_IPS), dt, source="keycloak",
                                 is_login=0, is_login_error=0,
                                 client_id=random.choice(["app-iam", "app-ticketing"]),
                                 session_id=random_session_id(),
                                 avg_interval_sec=random.uniform(0.1, 2.0),
                                 n_distinct_clients=random.randint(2, 5)))

    # 7. DOS/DDOS: événements massifs ultra-rapides
    for _ in range(per_type):
        dt = (base_date - timedelta(days=random.randint(0, 10))).replace(
            hour=random.randint(0, 23), minute=random.randint(0, 59), second=random.randint(0, 59))
        events.append(make_event(random.choice(["alice", "bob", "charlie"]),
                                 random.choice(["LOGIN", "LOGIN_ERROR", "CODE_TO_TOKEN"]),
                                 random.choice([KALI_IP] + UNKNOWN_IPS), dt,
                                 source="keycloak",
                                 is_login=random.choice([0, 1]),
                                 is_login_error=random.choice([0, 1]),
                                 client_id="app-iam",
                                 avg_interval_sec=random.uniform(0.01, 0.5),
                                 n_distinct_clients=random.randint(1, 2)))

    logger.info(f"  {len(events)} attaques generees ({len(events)/7:.0f} par type)")
    return events

#------ script principal ---------
if __name__ == "__main__":
    logger.info("=" * 60)
    logger.info("ENTRAINEMENT ISOLATION FOREST v7 — 13 FEATURES (10 000+ events)")
    logger.info("=" * 60)
#1: collect events (200max)
    real_events = collect_real_events(max_events=200, timeout_seconds=30)
#2: genere des events (8500 normal+ 1500 attaques )
    normal_events = generate_normal_events(n=8500)
    attack_events = generate_attack_events(n=1500)
#3: melange tous

    all_events = real_events + normal_events + attack_events
    random.shuffle(all_events)

    logger.info(f"Total : {len(all_events)} evenements")
    logger.info(f"  Reels : {len(real_events)}")
    logger.info(f"  Normaux synth : {len(normal_events)}")
    logger.info(f"  Attaques synth : {len(attack_events)} ({len(attack_events)/len(all_events)*100:.1f}%)")

    if len(all_events) < 50:
        logger.error("Pas assez d'evenements ! Le bridge doit tourner.")
        sys.exit(1)
#4: train model
    model = AnomalyDetectorModel()
    model.train(all_events)

    # Vérification  si distingue bien normal vs attaque
    X_normal = np.array([model.extract_features(e) for e in normal_events[:500]])
    X_attack = np.array([model.extract_features(e) for e in attack_events[:500]]) #extraire features
    X_normal_s = model.scaler.transform(X_normal) # normaliser
    X_attack_s = model.scaler.transform(X_attack)
    scores_n = model.model.decision_function(X_normal_s) #claculer le score 	ML
    scores_a = model.model.decision_function(X_attack_s)
    logger.info(f"Score ML moyen - Normal:  {scores_n.mean():.4f} (std: {scores_n.std():.4f})")
    logger.info(f"Score ML moyen - Attaque: {scores_a.mean():.4f} (std: {scores_a.std():.4f})")
    delta = scores_n.mean() - scores_a.mean() # normal + , anormal -
    logger.info(f"Delta: {delta:.4f} {'✅ BON (positif)' if delta > 0 else '❌ INVERSÉ (négatif)'}")

    model.save()

    logger.info("=" * 60)
    logger.info("MODELE ENTRAINE ET SAUVEGARDE !")
    logger.info(f"  Evenements : {len(all_events)} | Features : 13")
    logger.info(f"  Contamination : {ML_CONTAMINATION}")
    logger.info(f"  Modele : {MODEL_PATH}")
    logger.info(f"  Scaler : {SCALER_PATH}")
    logger.info("=" * 60)
