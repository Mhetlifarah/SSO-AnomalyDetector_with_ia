#!/usr/bin/env python3
"""
responder.py - Actions reactives automatiques (Ban IP, Kill Session, Lock User)
PFE DevSecOps - Module de reponse aux alertes confirmees
"""

import os
import json
import http.client
import socket as _socket
import requests
import logging
import time
from datetime import datetime

from config import (
    RESPONDER_ENABLED, KC_ADMIN_URL, KC_ADMIN_USER, KC_ADMIN_PASS,
    KC_REALM, KC_TARGET_REALM, NGINX_BAN_DIR, BAN_DURATION,
)

logger = logging.getLogger("responder")

# === Mapping: type d'attaque -> actions ===
REACTION_MAP = {
    "BRUTE_FORCE":         ["ban_ip"],
    "DOS_DDOS":            ["ban_ip"],
    "DDOS_AUTH":           ["ban_ip"],
    "TOKEN_THEFT":         ["kill_session"],
    "SESSION_HIJACKING":   ["kill_session"],
    "CREDENTIAL_STUFFING": ["ban_ip", "lock_user"],
    "PRIVILEGE_ESCALATION":["lock_user"],
    "IMPOSSIBLE_TRAVEL":   ["ban_ip", "kill_session"],
}

# === Token Keycloak Admin (cache) ===
_kc_token = None
_kc_token_expiry = 0


def _get_keycloak_token():
    """Obtient un token admin Keycloak (cache jusqu'a expiration)."""
    global _kc_token, _kc_token_expiry

    now = time.time()
    if _kc_token and now < _kc_token_expiry - 30:
        return _kc_token

    url = f"{KC_ADMIN_URL}/auth/realms/{KC_REALM}/protocol/openid-connect/token"
    data = {
        "grant_type": "password",
        "client_id": "admin-cli",
        "username": KC_ADMIN_USER,
        "password": KC_ADMIN_PASS,
    }

    try:
        resp = requests.post(url, data=data, timeout=10)
        resp.raise_for_status()
        token_data = resp.json()
        _kc_token = token_data["access_token"]
        _kc_token_expiry = now + token_data.get("expires_in", 300)
        logger.info("Token Keycloak admin obtenu")
        return _kc_token
    except Exception as e:
        logger.error(f"Token Keycloak echoue: {e}")
        return None


def _kc_headers():
    """Headers avec token Keycloak."""
    token = _get_keycloak_token()
    if not token:
        return None
    return {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}


# === Connexion Docker via Unix socket ===

class _UnixSocketConn(http.client.HTTPConnection):
    """Connexion HTTP via Unix socket Docker"""
    def __init__(self, socket_path):
        super().__init__('localhost')
        self.socket_path = socket_path
    def connect(self):
        self.sock = _socket.socket(_socket.AF_UNIX, _socket.SOCK_STREAM)
        self.sock.connect(self.socket_path)


def _reload_nginx():
    """Recharge Nginx via Docker Engine API (Unix socket)"""
    try:
        conn = _UnixSocketConn('/var/run/docker.sock')
        body = json.dumps({
            "AttachStdout": True,
            "AttachStderr": True,
            "Cmd": ["nginx", "-s", "reload"]
        })
        conn.request('POST', '/containers/pfe-nginx/exec',
                     body=body, headers={'Content-Type': 'application/json'})
        resp = conn.getresponse()
        exec_data = json.loads(resp.read())
        exec_id = exec_data['Id']
        conn.close()

        conn2 = _UnixSocketConn('/var/run/docker.sock')
        body2 = json.dumps({"Detach": False, "Tty": False})
        conn2.request('POST', f'/exec/{exec_id}/start',
                      body=body2, headers={'Content-Type': 'application/json'})
        conn2.getresponse().read()
        conn2.close()
        logger.info("Nginx reloaded via Docker API")
        return True
    except Exception as e:
        logger.error(f"Reload Nginx echoue: {e}")
        return False


# === ACTION 1: Ban IP via Nginx ===

def ban_ip_nginx(ip):
    """Ajoute 'deny IP;' dans le fichier partage Nginx + reload."""
    if not ip or ip == "unknown":
        logger.warning("Ban IP ignore: IP inconnue")
        return False

    try:
        os.makedirs(NGINX_BAN_DIR, exist_ok=True)
        ban_file = os.path.join(NGINX_BAN_DIR, "denied_ips.conf")

        # Verifier si IP deja bannie
        if os.path.exists(ban_file):
            with open(ban_file, "r") as f:
                if f"deny {ip};" in f.read():
                    logger.info(f"IP {ip} deja bannie, skip")
                    return True

        # Ajouter la regle deny
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(ban_file, "a") as f:
            f.write(f"# Banned {timestamp}\ndeny {ip};\n")

        logger.warning(f"IP BANNIE via Nginx: {ip}")

        # Reload Nginx automatiquement
        _reload_nginx()

        return True

    except Exception as e:
        logger.error(f"Ban IP echoue pour {ip}: {e}")
        return False


# === ACTION 2: Kill Session via Keycloak ===

def kill_session(username):
    """Supprime toutes les sessions Keycloak d'un utilisateur."""
    if not username or username == "unknown":
        logger.warning("Kill session ignore: utilisateur inconnu")
        return False

    headers = _kc_headers()
    if not headers:
        return False

    try:
        search_url = (
            f"{KC_ADMIN_URL}/auth/admin/realms/{KC_TARGET_REALM}/users"
            f"?username={username}&exact=true"
        )
        resp = requests.get(search_url, headers=headers, timeout=10)
        resp.raise_for_status()
        users = resp.json()

        if not users:
            logger.warning(f"Utilisateur {username} non trouve dans Keycloak")
            return False

        user_id = users[0]["id"]

        sessions_url = (
            f"{KC_ADMIN_URL}/auth/admin/realms/{KC_TARGET_REALM}/users/{user_id}/sessions"
        )
        resp = requests.get(sessions_url, headers=headers, timeout=10)
        sessions = resp.json() if resp.status_code == 200 else []

        for session in sessions:
            session_id = session.get("id")
            if session_id:
                del_url = (
                    f"{KC_ADMIN_URL}/auth/admin/realms/{KC_TARGET_REALM}/sessions/{session_id}"
                )
                requests.delete(del_url, headers=headers, timeout=10)

        logger.warning(f"SESSION KILLED: {username} ({len(sessions)} sessions supprimees)")
        return True

    except Exception as e:
        logger.error(f"Kill session echoue pour {username}: {e}")
        return False


# === ACTION 3: Lock User via Keycloak ===

def lock_user(username):
    """Desactive le compte utilisateur via Keycloak Admin API."""
    if not username or username == "unknown":
        logger.warning("Lock user ignore: utilisateur inconnu")
        return False

    headers = _kc_headers()
    if not headers:
        return False

    try:
        search_url = (
            f"{KC_ADMIN_URL}/auth/admin/realms/{KC_TARGET_REALM}/users"
            f"?username={username}&exact=true"
        )
        resp = requests.get(search_url, headers=headers, timeout=10)
        resp.raise_for_status()
        users = resp.json()

        if not users:
            logger.warning(f"Utilisateur {username} non trouve dans Keycloak")
            return False

        user_id = users[0]["id"]

        update_url = (
            f"{KC_ADMIN_URL}/auth/admin/realms/{KC_TARGET_REALM}/users/{user_id}"
        )
        resp = requests.put(
            update_url,
            headers=headers,
            json={"enabled": False},
            timeout=10,
        )

        if resp.status_code in (200, 204):
            logger.warning(f"USER LOCKED: {username} (compte desactive)")
            return True
        else:
            logger.error(f"Lock user erreur: {resp.status_code} {resp.text[:200]}")
            return False

    except Exception as e:
        logger.error(f"Lock user echoue pour {username}: {e}")
        return False


# === FONCTION PRINCIPALE ===

def respond(anomaly_doc):
    """
    Fonction principale: execute les actions reactives selon le type d'alerte.
    Appelable depuis detector_slack.py avec le meme format anomaly_doc.
    """
    if not RESPONDER_ENABLED:
        logger.debug("Responder desactive (RESPONDER_ENABLED=false)")
        return

    alert_type = anomaly_doc.get("type", "")
    username = anomaly_doc.get("username", "unknown")
    ip = anomaly_doc.get("ip_address", "unknown")
    level = anomaly_doc.get("level", "")

    if level not in ("CRITICAL", "URGENT"):
        logger.debug(f"Responder skip: niveau {level} trop bas")
        return

    actions = REACTION_MAP.get(alert_type, [])
    if not actions:
        logger.debug(f"Responder: aucune action pour {alert_type}")
        return

    logger.warning(f"REPONSE AUTO pour {alert_type}: actions={actions} user={username} ip={ip}")

    results = {}
    for action in actions:
        try:
            if action == "ban_ip":
                results["ban_ip"] = ban_ip_nginx(ip)
            elif action == "kill_session":
                results["kill_session"] = kill_session(username)
            elif action == "lock_user":
                results["lock_user"] = lock_user(username)
        except Exception as e:
            logger.error(f"Action {action} echouee: {e}")
            results[action] = False

    logger.info(f"Resultats reponse: {results}")
    return results
