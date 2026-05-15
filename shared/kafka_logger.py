import json, socket, os, time, uuid
from datetime import datetime, timezone
try:
    from kafka import KafkaProducer
    KAFKA_AVAILABLE = True
except ImportError:
    KAFKA_AVAILABLE = False
_producer = None
def get_producer():
    global _producer
    if _producer is None and KAFKA_AVAILABLE:
        try:
            bootstrap = os.environ.get('KAFKA_BOOTSTRAP_SERVERS', 'kafka:9092')
            _producer = KafkaProducer(bootstrap_servers=bootstrap, value_serializer=lambda v: json.dumps(v, default=str).encode('utf-8'), retries=3, request_timeout_ms=5000)
        except Exception as e:
            print(f"[kafka_logger] Cannot connect: {e}")
            _producer = None
    return _producer
def log_action(app_name, action, details=None, user=None, severity="INFO", request=None, session_id=None):
    username = "unknown"
    user_id = ""
    sid = ""
    if user:
        if isinstance(user, dict):
            user_id = user.get('sub', user.get('keycloak_id', user.get('user_id', user.get('id', ''))))
            username = user.get('preferred_username', user.get('username', user.get('name', user.get('email', 'unknown'))))
            sid = user.get('session_state', user.get('session_id', ''))
        elif isinstance(user, str):
            username = user

    if session_id:
        sid = session_id

    ip_address = ""
    user_agent = ""
    if request:
        try:
            ip_address = request.headers.get('X-Forwarded-For', request.remote_addr or '')
            if ip_address and ',' in ip_address:
                ip_address = ip_address.split(',')[0].strip()
            user_agent = request.headers.get('User-Agent', '')
        except:
            pass

    is_login = action in ('login', 'login_success', 'LOGIN')
    is_login_error = action in ('login_error', 'LOGIN_ERROR', 'login_failed')

    event = {
        "source": app_name,
        "event_id": str(uuid.uuid4()),
        "event_time": time.time() * 1000,
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S.%f"),
        "user_id": user_id,
        "username": username,
        "action": action,
        "event_type": action,
        "ip_address": ip_address,
        "user_agent": user_agent,
        "session_id": sid,
        "is_login": is_login,
        "is_login_error": is_login_error,
        "severity": severity,
        "hostname": socket.gethostname(),
        "details": details or {}
    }

    producer = get_producer()
    topic = os.environ.get('KAFKA_TOPIC', 'keycloak-events')
    # Utiliser user_id comme clé Kafka (comme Keycloak le fait)
    key = user_id.encode('utf-8') if user_id else username.encode('utf-8')
    if producer:
        try:
            producer.send(topic, key=key, value=event)
            producer.flush(timeout=3)
            print(f"[kafka_logger] Sent: {app_name}/{action} by {username} -> {topic}")
        except Exception as e:
            print(f"[kafka_logger] Failed: {e}")
    else:
        print(f"[kafka_logger] (no Kafka) {app_name}/{action} by {username}")
