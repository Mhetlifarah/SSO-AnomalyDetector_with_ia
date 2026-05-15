"""
notifier.py - Slack + Elasticsearch alerting
PFE DevSecOps Anomaly Detector v7
"""

import json
import requests
import urllib3
import logging
from datetime import datetime, timezone

from config import (
    ES_HOST, ES_INDEX, ES_USER, ES_PASS, ES_VERIFY,
    SLACK_ENABLED, SLACK_WEBHOOK_URL, SLACK_MIN_SEVERITY,
    KIBANA_URL,
)

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
logger = logging.getLogger("notifier")

# Ordre de severite
SEVERITY_ORDER = {"LOW": 0, "WARNING": 1, "HIGH": 2, "CRITICAL": 3}

EMOJI_MAP = {
    "CRITICAL": ":rotating_light:",
    "HIGH":     ":large_orange_diamond:",
    "WARNING":  ":warning:",
    "LOW":      ":information_source:",
}

COLOR_MAP = {
    "CRITICAL": "#FF0000",
    "HIGH":     "#FF8C00",
    "WARNING":  "#FFD700",
    "LOW":      "#36A64F",
}



def _build_kibana_link(alert: dict) -> str:
    """Construit un deep link Kibana Discover filtre sur l'alerte."""
    alert_type = alert.get('alert_type', '')
    source_ip = alert.get('source_ip', '')
    filters = []
    if alert_type:
        filters.append(f'(field:alert_type,query:(match_phrase:{alert_type}))')
    if source_ip:
        filters.append(f'(field:source_ip,query:(match_phrase:{source_ip}))')
    filters_str = ','.join(filters)
    return f"{KIBANA_URL}/app/discover#/?_a=(filters:!({filters_str}))"


# === Elasticsearch ===


def _sanitize_alert_for_es(alert: dict) -> dict:
    """Nettoie l'alerte pour ES: garde les types compatibles avec le mapping ES."""
    import copy
    clean = copy.deepcopy(alert)
    event = clean.get("event", {})
    if isinstance(event, dict):
        for key in list(event.keys()):
            val = event[key]
            if val is None:
                continue
            # event_time est mappé comme 'long' dans ES -> garder comme nombre
            if key == "event_time":
                if isinstance(val, (int, float)):
                    pass  # déjà un nombre, OK
                elif isinstance(val, str):
                    try:
                        event[key] = int(float(val))
                    except (ValueError, TypeError):
                        del event[key]  # supprimer si non-convertible
            # timestamp est mappé comme 'date' dans ES -> garder ISO string
            elif key in ("timestamp", "@timestamp"):
                if isinstance(val, (int, float)):
                    from datetime import datetime, timezone
                    if val > 1e12:
                        val = val / 1000
                    event[key] = datetime.fromtimestamp(val, tz=timezone.utc).isoformat()
                elif isinstance(val, str) and not any(c in val for c in ('T', '-', ':')):
                    try:
                        from datetime import datetime, timezone
                        ts = float(val)
                        if ts > 1e12:
                            ts = ts / 1000
                        event[key] = datetime.fromtimestamp(ts, tz=timezone.utc).isoformat()
                    except (ValueError, TypeError):
                        pass  # garder tel quel
    return clean

def send_to_elasticsearch(alert: dict):
    """Index une alerte dans Elasticsearch."""
    try:
        index_name = f"{ES_INDEX}-{datetime.now(timezone.utc).strftime('%Y.%m.%d')}"
        alert = _sanitize_alert_for_es(alert)
        url = f"{ES_HOST}/{index_name}/_doc"

        resp = requests.post(
            url,
            json=alert,
            auth=(ES_USER, ES_PASS),
            verify=ES_VERIFY,
            timeout=10,
        )
        if resp.status_code in (200, 201):
            logger.info("Alerte ES OK: %s [%s]", alert.get("alert_type"), alert.get("severity"))
        else:
            logger.warning("ES erreur %s: %s", resp.status_code, resp.text[:200])
    except Exception as e:
        logger.error("ES connexion echouee: %s", e)


# === Slack ===

def _should_send_slack(severity: str) -> bool:
    """Verifie si la severite justifie un envoi Slack."""
    if not SLACK_ENABLED or not SLACK_WEBHOOK_URL:
        return False
    if SLACK_WEBHOOK_URL == "REPLACE_WITH_YOUR_SLACK_WEBHOOK_URL":
        return False
    min_level = SEVERITY_ORDER.get(SLACK_MIN_SEVERITY, 1)
    return SEVERITY_ORDER.get(severity, 0) >= min_level


def _build_slack_blocks(alert: dict) -> list:
    """Construit les Slack Block Kit blocks pour une alerte."""

    severity = alert.get("severity", "WARNING")
    alert_type = alert.get("alert_type", "UNKNOWN")
    emoji = EMOJI_MAP.get(severity, ":bell:")
    color = COLOR_MAP.get(severity, "#CCCCCC")

    # En-tete
    blocks = [
        {
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": f"{emoji} ALERTE SECURITE - {severity}",
                "emoji": True,
            },
        },
        {
            "type": "section",
            "fields": [
                {"type": "mrkdwn", "text": f"*Type:* {alert_type}"},
                {"type": "mrkdwn", "text": f"*Severite:* {severity}"},
            ],
        },
    ]

    # Detail evenement
    event = alert.get("event", {})
    detail_fields = []

    if alert.get("username"):
        detail_fields.append({"type": "mrkdwn", "text": f"*Utilisateur:* `{alert['username']}`"})
    if alert.get("source_ip"):
        detail_fields.append({"type": "mrkdwn", "text": f"*IP source:* `{alert['source_ip']}`"})
    if event.get("clientId"):
        detail_fields.append({"type": "mrkdwn", "text": f"*Client ID:* `{event['clientId']}`"})
    if alert.get("reason"):
        detail_fields.append({"type": "mrkdwn", "text": f"*Raison:* {alert['reason']}"})

    # ML score
    if alert.get("ml_score") is not None:
        detail_fields.append({"type": "mrkdwn", "text": f"*ML score:* `{alert['ml_score']:.3f}`"})

    # Compteurs pour alertes volume
    for counter_key in ("login_errors", "login_attempts", "total_events", "distinct_users"):
        val = alert.get(counter_key)
        if val is not None:
            label = counter_key.replace("_", " ").title()
            detail_fields.append({"type": "mrkdwn", "text": f"*{label}:* {val}"})

    if detail_fields:
        blocks.append({
            "type": "section",
            "fields": detail_fields,
        })

    # Deep link Kibana
    kibana_link = _build_kibana_link(alert)
    blocks.append({
        "type": "actions",
        "elements": [
            {
                "type": "button",
                "text": {"type": "plain_text", "text": ":mag: Voir dans Kibana", "emoji": True},
                "url": kibana_link,
                "style": "primary",
            }
        ],
    })

    # Contexte (timestamp + detection engine)
    ts = alert.get("timestamp", datetime.now(timezone.utc).isoformat())
    blocks.append({
        "type": "context",
        "elements": [
            {"type": "mrkdwn", "text": f":clock3: {ts}  |  PFE DevSecOps Detector v7"},
        ],
    })

    # Divider
    blocks.append({"type": "divider"})

    return blocks


def send_to_slack(alert: dict):
    """Envoie une alerte sur Slack via Incoming Webhook."""
    if not _should_send_slack(alert.get("severity", "WARNING")):
        return

    severity = alert.get("severity", "WARNING")
    emoji = EMOJI_MAP.get(severity, ":bell:")

    payload = {
        "text": f"{emoji} Alerte {severity}: {alert.get('alert_type', 'UNKNOWN')}",
        "blocks": _build_slack_blocks(alert),
    }

    try:
        resp = requests.post(
            SLACK_WEBHOOK_URL,
            json=payload,
            timeout=10,
        )
        if resp.status_code == 200:
            logger.info("Slack OK: %s [%s]", alert.get("alert_type"), severity)
        else:
            logger.warning("Slack erreur %s: %s", resp.status_code, resp.text[:200])
    except Exception as e:
        logger.error("Slack envoi echoue: %s", e)


# === Notification unifiee ===

def notify(alert: dict):
    """Envoie l'alerte vers ES + Slack."""
    send_to_elasticsearch(alert)
    send_to_slack(alert)
