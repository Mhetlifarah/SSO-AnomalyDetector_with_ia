#!/bin/bash
# PFE Anomaly Detector v8 - entrypoint (13 features + macro)
echo "[entrypoint] Purge __pycache__..."
find /app -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
find /app -name "*.pyc" -delete 2>/dev/null
echo "[entrypoint] Cache purge OK"

echo "[entrypoint] Installation dépendances..."
pip install elasticsearch==7.17.9 psycopg2-binary==2.9.9 2>/dev/null || true

if [ "$ML_ENABLED" = "true" ]; then
    echo "[entrypoint] Entrainement du modele ML (13 features)..."
    python3 -u /app/train_model.py
    TRAIN_EXIT=$?
    if [ $TRAIN_EXIT -ne 0 ]; then
        echo "[entrypoint] WARNING: train_model.py echoue, demarrage quand meme..."
    else
        echo "[entrypoint] Modele entraine avec succes (13 features)"
    fi
else
    echo "[entrypoint] ML desactive (ML_ENABLED=false), skip entrainement"
fi

echo "[entrypoint] Demarrage du detecteur d'anomalies (14 regles + ML 13 features)..."
python3 -u /app/detector_slack.py &
DETECTOR_PID=$!

# Lancer le macro détecteur en parallèle si activé
if [ "$MACRO_DETECTOR_ENABLED" = "true" ]; then
    echo "[entrypoint] Demarrage du macro detecteur (2ème couche batch)..."
    sleep 30  # Attendre que le détecteur principal démarre
    python3 -u /app/macro_detector.py --loop --interval 120 &
    MACRO_PID=$!
fi

# Attendre le process principal
wait $DETECTOR_PID
