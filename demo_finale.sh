#!/bin/bash
echo "=========================================================="
echo "🎓 PFE DEVSECOPS - DÉMONSTRATION DES LOGS COMPLETS"
echo "=========================================================="
echo ""

# 1. Compter tous les logs
TOTAL=$(docker exec pfe-postgres psql -U pfe -d keycloak -t -c "SELECT COUNT(*) FROM event_entity;" 2>/dev/null | xargs)
echo "📊 TOTAL DES LOGS STOCKÉS: $TOTAL événements"

# 2. Premier log
echo ""
echo "📅 PREMIER LOG (historique complet):"
docker exec pfe-postgres psql -U pfe -d keycloak -t -c "
SELECT 
    to_timestamp(event_time/1000) as date,
    type,
    user_id
FROM event_entity 
ORDER BY event_time ASC 
LIMIT 1;" 2>/dev/null

# 3. Dernier log
echo ""
echo "📅 DERNIER LOG (temps réel):"
docker exec pfe-postgres psql -U pfe -d keycloak -t -c "
SELECT 
    to_timestamp(event_time/1000) as date,
    type,
    user_id
FROM event_entity 
ORDER BY event_time DESC 
LIMIT 1;" 2>/dev/null

# 4. Synchronisation
echo ""
echo "🔄 SYNCHRONISATION:"
KAFKA=$(docker exec pfe-kafka kafka-run-class kafka.tools.GetOffsetShell --bootstrap-server localhost:9092 --topic keycloak-events 2>/dev/null | cut -d':' -f3 | awk '{sum+=$1} END {print sum}')
ES=$(curl -s "http://localhost:9200/keycloak-events/_count" 2>/dev/null | python3 -c "import sys,json; print(json.load(sys.stdin).get('count',0))")
echo "   PostgreSQL: $TOTAL logs"
echo "   Kafka:      $KAFKA messages" 
echo "   Elasticsearch: $ES documents"

# 5. Liens
echo ""
echo "🔗 ACCÈS DIRECTS:"
echo "   📊 Redpanda (tous les messages): http://localhost:8080/topics/keycloak-events/messages"
echo "   📈 Kibana (visualisation):      http://localhost:5601"
echo "   🗄️  Keycloak (admin console):    http://localhost:8080"

echo ""
echo "✅ DÉMONSTRATION PRÊTE - DU PREMIER AU DERNIER LOG !"
echo "=========================================================="
