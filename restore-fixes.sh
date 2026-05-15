#!/bin/bash
# Restore les corrections après recréation des conteneurs
cd ~/PFE-Phase2/pfe-sso

echo "🔄 Restauration des corrections dans les conteneurs..."

# Attendre que les conteneurs soient prêts
sleep 5

# Copier les app.py
docker cp apps/iam/app.py pfe-app-iam:/app/app.py
docker cp apps/ticketing/app.py pfe-app-ticketing:/app/app.py
docker cp apps/audit/app.py pfe-app-audit:/app/app.py

# Copier les templates
docker cp apps/iam/templates/ pfe-app-iam:/app/templates/
docker cp apps/ticketing/templates/ pfe-app-ticketing:/app/templates/
docker cp apps/audit/templates/ pfe-app-audit:/app/templates/

# Redémarrer pour charger le nouveau code
docker restart pfe-app-iam pfe-app-ticketing pfe-app-audit

echo "✅ Corrections restaurées !"
