#!/usr/bin/env python3
"""
isolation_forest.py - Modele ML Isolation Forest v9
PFE DevSecOps - FIX: 13 features avec fallback event dict pour training
"""
import numpy as np, pickle, os, sys
from datetime import datetime
from sklearn.ensemble import IsolationForest
from sklearn.preprocessing import StandardScaler
import logging

sys.path.insert(0, '/app')

try:
    from config import (
        ML_CONTAMINATION, is_docker_ip, is_trusted_ip,
        is_normal_action, is_normal_hour, parse_event_time
    )
except ImportError:
    ML_CONTAMINATION = 0.15
    def is_docker_ip(ip):
        if not ip or ip in ('unknown', 'none', ''):
            return True
        for p in ["172.17.", "172.18.", "172.19.", "10.0.0.", "127.", "0.0."]:
            if ip.startswith(p):
                return True
        return False
    def is_trusted_ip(ip):
        return True
    def is_normal_action(event_type):
        return True
    def is_normal_hour(dt):
        return 7 <= dt.hour < 19
    def parse_event_time(time_str):
        if not time_str:
            return 0
        try:
            from datetime import datetime as dt_cls, timezone as tz
            clean = time_str.replace('Z', '+00:00')
            d = dt_cls.fromisoformat(clean)
            return d.timestamp()
        except Exception:
            return 0

ML_RANDOM_STATE = 42
logger = logging.getLogger("ml-model")


class AnomalyDetectorModel:
    FEATURE_NAMES = [
        'hour', 'weekday', 'is_weekend', 'is_login', 'is_login_error',
        'hour_sin', 'hour_cos', 'is_token_event', 'is_admin_action',
        'ip_risk_score', 'is_forbidden_action', 'avg_interval_sec',
        'n_distinct_clients'
    ]

    def __init__(self):
        self.model = None
        self.n_features = 0
        self.scaler = None
        self.n_features = len(self.FEATURE_NAMES)

    def extract_features(self, event, ml_context=None):
        """Extrait 13 features d'un evenement.
        
        Args:
            event: dictionnaire evenement (peut contenir avg_interval_sec, n_distinct_clients)
            ml_context: dict optionnel avec {'avg_interval_sec', 'n_distinct_clients'}
                        fourni par le detector pour les features fenetrees en temps reel
        """
        ts = event.get('event_time', event.get('timestamp', None))
        if ts is None:
            dt = datetime.now()
        elif isinstance(ts, (int, float)):
            val = float(ts)
            if val > 1e12:
                val = val / 1000.0
            dt = datetime.fromtimestamp(val)
        elif isinstance(ts, str):
            try:
                dt = datetime.fromisoformat(ts.replace('Z', '+00:00'))
            except (ValueError, AttributeError):
                dt = datetime.now()
        else:
            dt = datetime.now()

        hour = dt.hour
        weekday = dt.weekday()
        is_weekend = 1 if weekday >= 5 else 0

        event_type = event.get('event_type', event.get('type', ''))
        et_lower = event_type.lower() if event_type else ''
        is_login = 1 if et_lower in ('login', 'login_attempt') else 0
        is_login_error = 1 if et_lower in ('login_error', 'login error') else 0
        hour_sin = np.sin(2 * np.pi * hour / 24)
        hour_cos = np.cos(2 * np.pi * hour / 24)
        is_token_event = 1 if et_lower in ('code_to_token', 'refresh_token', 'token_exchange') else 0

        admin_actions = ['admin_access', 'delete_user', 'manage_roles', 'impersonate',
                         'manage_realm', 'view_realm', 'manage_users', 'view_clients']
        is_admin_action = 1 if et_lower in admin_actions else 0

        ip = event.get('ip_address', 'unknown')
        ip_risk_score = 0.0
        if ip and ip != 'unknown':
            if is_docker_ip(ip):
                ip_risk_score = 0.0
            elif any(ip.startswith(p) for p in ['192.168.', '10.', '172.16.', '172.17.', '172.18.', '172.19.']):
                ip_risk_score = 0.1
            else:
                ip_risk_score = 1.0

        # Feature 11: is_forbidden_action
        forbidden_actions = ['delete_user', 'manage_roles', 'impersonate',
                             'manage_realm', 'manage_users', 'delete_account']
        is_forbidden_action = 1 if et_lower in forbidden_actions else 0

        # Features 12-13: avg_interval_sec, n_distinct_clients
        # Priorité: ml_context (temps réel) > event dict (training) > défaut
        if ml_context and ml_context.get('avg_interval_sec') is not None:
            avg_interval_sec = float(ml_context.get('avg_interval_sec', 60.0))
        elif event.get('avg_interval_sec') is not None:
            avg_interval_sec = float(event.get('avg_interval_sec', 60.0))
        else:
            avg_interval_sec = 60.0

        if ml_context and ml_context.get('n_distinct_clients') is not None:
            n_distinct_clients = float(ml_context.get('n_distinct_clients', 1))
        elif event.get('n_distinct_clients') is not None:
            n_distinct_clients = float(event.get('n_distinct_clients', 1))
        else:
            n_distinct_clients = 1.0

        return [hour, weekday, is_weekend, is_login, is_login_error,
                hour_sin, hour_cos, is_token_event, is_admin_action, ip_risk_score,
                is_forbidden_action, avg_interval_sec, n_distinct_clients]

    def train(self, events):
        logger.info(f"Extraction features pour {len(events)} evenements...")
        X = np.array([self.extract_features(e) for e in events])
        self.scaler = StandardScaler()
        X_scaled = self.scaler.fit_transform(X)
        
        # Afficher les stats du scaler pour vérification
        logger.info(f"Scaler mean: {self.scaler.mean_}")
        logger.info(f"Scaler std:  {self.scaler.scale_}")
        
        self.model = IsolationForest(
            contamination=ML_CONTAMINATION,
            random_state=ML_RANDOM_STATE,
            n_estimators=200,
            max_samples='auto'
        )
        self.model.fit(X_scaled)
        self.n_features = X.shape[1]
        logger.info(f"Isolation Forest entraine ({self.n_features} features, contamination={ML_CONTAMINATION})")

    def predict(self, event, ml_context=None):
        if self.model is None or self.scaler is None:
            return False, 0.0
        features = self.extract_features(event, ml_context)
        X = np.array([features], dtype=np.float64)
        X = np.nan_to_num(X, nan=0.0, posinf=0.0, neginf=0.0)
        X_scaled = self.scaler.transform(X)
        score = self.model.decision_function(X_scaled)[0]
        is_anomaly = self.model.predict(X_scaled)[0] == -1
        return is_anomaly, float(score)

    def save(self, model_path=None, scaler_path=None):
        model_path = model_path or "/app/models/isolation_forest.pkl"
        scaler_path = scaler_path or "/app/models/scaler.pkl"
        os.makedirs(os.path.dirname(model_path), exist_ok=True)
        with open(model_path, 'wb') as f:
            pickle.dump(self.model, f)
        with open(scaler_path, 'wb') as f:
            pickle.dump(self.scaler, f)
        logger.info(f"Modele sauvegarde: {model_path}")

    def load(self, model_path=None, scaler_path=None):
        model_path = model_path or "/app/models/isolation_forest.pkl"
        scaler_path = scaler_path or "/app/models/scaler.pkl"
        with open(model_path, 'rb') as f:
            self.model = pickle.load(f)
        with open(scaler_path, 'rb') as f:
            self.scaler = pickle.load(f)
        if self.scaler:
            self.n_features = self.scaler.n_features_in_
        logger.info(f"Modele charge: {model_path} ({self.n_features} features)")
