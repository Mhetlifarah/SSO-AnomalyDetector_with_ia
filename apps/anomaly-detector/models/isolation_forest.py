#!/usr/bin/env python3
"""
Modele Isolation Forest V2 - 17 features
Detection d'anomalies pour SSO/Keycloak
implemente class anomalyDetectorMode qui encapsule algo iF de scikit-learn +normalisation des featrures vis StandarScaler + modele dentain +prediction +savegarde et le chargement de model


capable de detecter les anomalie que les regles ne peuvent pas identifier
"""
#----------------- 17 features pour analyser les events keycloak-----------
import numpy as np
import os
import json
import math
import joblib #pour savegarder / charger le modele
from sklearn.ensemble import IsolationForest #algo
from sklearn.preprocessing import StandardScaler #normalise data
#-----------------Listes des features 17-------------------
FEATURE_NAMES = [
# features de temps + features d'actions +ips + comportements
    'hour', 'weekday', 'is_weekend', 'is_login', 'is_login_error',
    'hour_sin', 'hour_cos', 'is_token_event', 'is_admin_action',
    'ip_risk_score', 'is_forbidden_action' , 'avg_interval_sec', #temp/requetes
    'n_distinct_clients',
    # === 4 NOUVELLES FEATURES V2 ===
    'error_count_60s', #errors/dernier 60s
    'distinct_users_ip', #users/ip
    'error_rate_ip', #taux error /ip
    'is_rapid_requests',
]
#--chemins de files----
MODEL_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(MODEL_DIR, 'isolation_forest_model.pkl') #modele suvegarder
SCALER_PATH = os.path.join(MODEL_DIR, 'scaler.pkl') #normalise

#---transformer event json en liste de 17 features
def extract_features(event, attack_features=None):
    """Extrait 17 features d'un evenement Keycloak"""
    event_type = str(event.get('event_type', event.get('type', ''))).upper()
    details = event.get('details', {}) #recuperer les details ( si existe / present)
    if isinstance(details, str):
        try:
            details = json.loads(details)
        except:
            details = {}

    timestamp_str = event.get('timestamp', event.get('@timestamp', '')) #recupurer heure/date
    try:
        if 'T' in str(timestamp_str):
            from datetime import datetime
            dt = datetime.fromisoformat(str(timestamp_str).replace('Z', '+00:00'))
        else:
            from datetime import datetime
            dt = datetime.utcfromtimestamp(int(timestamp_str) / 1000)
    except:
        from datetime import datetime
        dt = datetime.utcnow()

    hour = dt.hour
    weekday = dt.weekday()

    features = [ #construire liste de 17 features
        hour,                                      # 0: hour
        weekday,                                   # 1: weekday
        1 if weekday >= 5 else 0,                  # 2: is_weekend
        1 if event_type == 'LOGIN' else 0,         # 3: is_login
        1 if event_type == 'LOGIN_ERROR' else 0,   # 4: is_login_error
        math.sin(2 * math.pi * hour / 24),         # 5: hour_sin
        math.cos(2 * math.pi * hour / 24),         # 6: hour_cos
        1 if event_type in ('CODE_TO_TOKEN', 'REFRESH_TOKEN', 'TOKEN_EXCHANGE') else 0,  # 7: is_token_event
        1 if any(x in str(details) for x in ['admin', 'ADMIN', 'realm_management']) else 0,  # 8: is_admin_action
        float(details.get('ip_risk_score', 0.5)) if isinstance(details, dict) else 0.5,  # 9: ip_risk_score
        1 if event_type in ('LOGIN_ERROR', 'PERMISSION_DENIED') else 0,  # 10: is_forbidden_action
        float(details.get('avg_interval_sec', 60.0)) if isinstance(details, dict) else 60.0,  # 11: avg_interval_sec
        int(details.get('n_distinct_clients', 1)) if isinstance(details, dict) else 1,  # 12: n_distinct_clients
    ]

    # === 4 NOUVELLES FEATURES suplementaires v2  ===
    af = attack_features or {}
    features.append(int(af.get('error_count_60s', 0)))       # 13 errors/60s
    features.append(int(af.get('distinct_users_ip', 1)))      # 14 users distincts
    features.append(float(af.get('error_rate_ip', 0.0)))      # 15 %errors
    features.append(int(af.get('is_rapid_requests', 0)))      # 16 requetes rapides

    return features

########------ la class principale de detecter ML ( charger le modele + fait des predictions )
class AnomalyDetectorModel:
    def __init__(self): #2instances
        self.model = None #modele iF ( instance IF )
        self.scaler = None #Normilation ( met les d° a la meme echelle )
        self.load()

    def load(self): #------1: charger le modele + normaliser depuis fichier pkl----
        if os.path.exists(MODEL_PATH):
            self.model = joblib.load(MODEL_PATH)
            self.scaler = joblib.load(SCALER_PATH) if os.path.exists(SCALER_PATH) else None
            print(f"[IForest V2] Modele charge ({len(FEATURE_NAMES)} features)")
        else:
            print("[IForest V2] Aucun modele trouve, en attente d'entrainement")

    def predict(self, event, attack_features=None): #------- 2: prediction si event normal ou anormal
        if self.model is None:
            return False, 0.0 #retourne : anormal (-) , normal (+)

        features = extract_features(event, attack_features) #extraire 17 features
        X = np.array([features])

        if self.scaler: #normaliser les d° tous a la meme echelle
            X = self.scaler.transform(X)

        prediction = self.model.predict(X)[0] #predire ( -1:anormal , 1:normal)
        score = float(self.model.decision_function(X)[0])
        is_anomaly = prediction == -1

        return is_anomaly, score

    def train(self, X, contamination=0.10): #entrain le modele ( x events * 17features ) + contamination 10%
        self.scaler = StandardScaler()
        X_scaled = self.scaler.fit_transform(X) #normaliser data ( martix : x ; event ; 17features)
        self.model = IsolationForest( #creer et train model
            n_estimators=200,    #200 arbres
            max_samples='auto',  #taille des echantillons
            contamination=contamination,
            random_state=42, #rst reprodictible
            n_jobs=-1, #tous le cpu
        )
        self.model.fit(X_scaled)
	#--- sauvegarder le modele + normaliseur
        joblib.dump(self.model, MODEL_PATH)
        joblib.dump(self.scaler, SCALER_PATH)
        print(f"[IForest V2] Modele entraine et sauvegarde ({X.shape[1]} features)")
        return self.model, self.scaler

######-------- test rapide -----------------
if __name__ == '__main__':
    m = IsolationForestModel()
    if m.model:
        print(f"Features: {FEATURE_NAMES}")
        print(f"N features: {len(FEATURE_NAMES)}")
