#!/bin/bash
set -e
KEYCLOAK_URL="http://localhost:8080/auth"
TOKEN=$(curl -sk -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" -d "username=admin" -d "password=admin" -d "grant_type=password" -d "client_id=admin-cli" | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token',''))" 2>/dev/null)
if [ -z "$TOKEN" ]; then echo "Failed to get token"; exit 1; fi
echo "Token OK"
curl -sk -o /dev/null -w "%{http_code}" -X POST "$KEYCLOAK_URL/admin/realms" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"realm":"pfe","enabled":true,"sslRequired":"none"}' | grep -q "201\|409" && echo "Realm OK"
curl -sk -o /dev/null -X POST "$KEYCLOAK_URL/admin/realms/pfe/clients" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"clientId":"app-iam","enabled":true,"publicClient":false,"secret":"iam-secret","redirectUris":["https://192.168.222.146/iam/callback"],"webOrigins":["+"],"standardFlowEnabled":true,"directAccessGrantsEnabled":true,"protocol":"openid-connect"}' && echo "Client IAM OK"
curl -sk -o /dev/null -X POST "$KEYCLOAK_URL/admin/realms/pfe/clients" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"clientId":"app-ticketing","enabled":true,"publicClient":false,"secret":"ticketing-secret","redirectUris":["https://192.168.222.146/ticketing/callback"],"webOrigins":["+"],"standardFlowEnabled":true,"directAccessGrantsEnabled":true,"protocol":"openid-connect"}' && echo "Client Ticketing OK"
curl -sk -o /dev/null -X POST "$KEYCLOAK_URL/admin/realms/pfe/clients" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"clientId":"app-audit","enabled":true,"publicClient":false,"secret":"audit-secret","redirectUris":["https://192.168.222.146/audit/callback"],"webOrigins":["+"],"standardFlowEnabled":true,"directAccessGrantsEnabled":true,"protocol":"openid-connect"}' && echo "Client Audit OK"
ALICE=$(curl -sk "$KEYCLOAK_URL/admin/realms/pfe/users?username=alice" -H "Authorization: Bearer $TOKEN" | python3 -c "import sys,json; d=json.load(sys.stdin); print('yes' if d else 'no')" 2>/dev/null)
if [ "$ALICE" != "yes" ]; then
  curl -sk -o /dev/null -X POST "$KEYCLOAK_URL/admin/realms/pfe/users" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"username":"alice","email":"alice@pfe.local","firstName":"Alice","lastName":"Admin","enabled":true,"emailVerified":true,"credentials":[{"type":"password","value":"alice123","temporary":false}]}'
  echo "User alice created"
else
  echo "User alice exists"
fi
BOB=$(curl -sk "$KEYCLOAK_URL/admin/realms/pfe/users?username=bob" -H "Authorization: Bearer $TOKEN" | python3 -c "import sys,json; d=json.load(sys.stdin); print('yes' if d else 'no')" 2>/dev/null)
if [ "$BOB" != "yes" ]; then
  curl -sk -o /dev/null -X POST "$KEYCLOAK_URL/admin/realms/pfe/users" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '{"username":"bob","email":"bob@pfe.local","firstName":"Bob","lastName":"User","enabled":true,"emailVerified":true,"credentials":[{"type":"password","value":"bob123","temporary":false}]}'
  echo "User bob created"
else
  echo "User bob exists"
fi
echo "=== Setup complete ==="
