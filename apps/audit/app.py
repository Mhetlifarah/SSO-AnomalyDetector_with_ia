import os, sys
from flask import Flask, render_template, redirect, url_for, session, request, jsonify
from werkzeug.middleware.proxy_fix import ProxyFix
import psycopg2
sys.path.insert(0, '/app')
from oidc import init_oidc, login_redirect, handle_callback, logout as oidc_logout, is_authenticated, get_current_user
from kafka_logger import log_action

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', os.environ.get('APP_SECRET_KEY', 'audit-key'))
app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1)
app.config['APPLICATION_ROOT'] = '/audit'
app.config["OIDC_CLIENT_ID"] = os.environ.get("OIDC_CLIENT_ID")
app.config["OIDC_CLIENT_SECRET"] = os.environ.get("OIDC_CLIENT_SECRET")
app.config["OIDC_ISSUER"] = os.environ.get("OIDC_ISSUER")
app.config["OIDC_REDIRECT_URI"] = os.environ.get("OIDC_REDIRECT_URI")
init_oidc(app)

APP_NAME = "audit"
AUDIT_HOST = os.environ.get('DB_HOST', 'postgres')
AUDIT_PORT = os.environ.get('DB_PORT', '5432')
AUDIT_NAME = os.environ.get('DB_NAME', 'audit_db')
AUDIT_USER = os.environ.get('DB_USER', 'pfe')
AUDIT_PASS = os.environ.get('DB_PASS', 'pfe_secret')
IAM_HOST = os.environ.get('IAM_DB_HOST', 'postgres')
IAM_PORT = os.environ.get('IAM_DB_PORT', '5432')
IAM_NAME = os.environ.get('IAM_DB_NAME', 'iam_db')
IAM_USER = os.environ.get('IAM_DB_USER', 'pfe')
IAM_PASS = os.environ.get('IAM_DB_PASS', 'pfe_secret')
TICK_HOST = os.environ.get('TICK_DB_HOST', 'postgres')
TICK_PORT = os.environ.get('TICK_DB_PORT', '5432')
TICK_NAME = os.environ.get('TICK_DB_NAME', 'ticketing_db')
TICK_USER = os.environ.get('TICK_DB_USER', 'pfe')
TICK_PASS = os.environ.get('TICK_DB_PASS', 'pfe_secret')

SRC_COLORS = {'App IAM': '#0d6efd', 'App Ticketing': '#6f42c1', 'App Audit': '#198754'}
SRC_ICONS = {'App IAM': 'shield-lock', 'App Ticketing': 'ticket-perforated', 'App Audit': 'journal-check'}
LOG_SOURCES = [
    {'label': 'App IAM', 'color': '#0d6efd'},
    {'label': 'App Ticketing', 'color': '#6f42c1'},
    {'label': 'App Audit', 'color': '#198754'},
]

def get_audit_db():
    return psycopg2.connect(host=AUDIT_HOST, port=AUDIT_PORT, dbname=AUDIT_NAME, user=AUDIT_USER, password=AUDIT_PASS)
def get_iam_db():
    return psycopg2.connect(host=IAM_HOST, port=IAM_PORT, dbname=IAM_NAME, user=IAM_USER, password=IAM_PASS)
def get_ticketing_db():
    return psycopg2.connect(host=TICK_HOST, port=TICK_PORT, dbname=TICK_NAME, user=TICK_USER, password=TICK_PASS)

def current_user():
    u = get_current_user()
    return u if u else {}

def log_app_action(action, details=None, severity="INFO"):
    log_action(APP_NAME, action, details=details, user=current_user(), severity=severity)
    try:
        user = current_user()
        username = user.get('name', 'unknown') if user else 'unknown'
        conn = get_audit_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO action_logs (username, action, details, ip_address, severity) VALUES (%s, %s, %s, %s, %s)", (username, action, str(details) if details else '', request.remote_addr, severity))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"[audit] action_logs error: {e}")

def fetch_logs(conn, sql, params=None):
    try:
        cur = conn.cursor()
        cur.execute(sql, params)
        cols = [d[0] for d in cur.description]
        rows = [dict(zip(cols, r)) for r in cur.fetchall()]
        cur.close()
        return rows
    except:
        return []

def get_all_logs(limit=200, source_filter='', action_filter='', username_filter='', date_from='', date_to=''):
    all_logs = []
    # IAM: audit_log has column "timestamp" (not created_at)
    try:
        c = get_iam_db()
        q = "SELECT id, username, action, details, ip_address, timestamp FROM audit_log WHERE 1=1"
        p = []
        if action_filter: q += " AND action ILIKE %s"; p.append(f'%{action_filter}%')
        if username_filter: q += " AND username ILIKE %s"; p.append(f'%{username_filter}%')
        if date_from: q += " AND timestamp >= %s"; p.append(date_from)
        if date_to: q += " AND timestamp <= %s"; p.append(date_to + ' 23:59:59')
        q += " ORDER BY timestamp DESC LIMIT %s"; p.append(limit)
        for l in fetch_logs(c, q, p): l['source'] = 'App IAM'; all_logs.append(l)
        c.close()
    except Exception as e:
        print(f"[audit] IAM logs error: {e}")
    # Ticketing: audit_log has column "created_at"
    try:
        c = get_ticketing_db()
        q = "SELECT id, username, action, details, ip_address, created_at as timestamp FROM audit_log WHERE 1=1"
        p = []
        if action_filter: q += " AND action ILIKE %s"; p.append(f'%{action_filter}%')
        if username_filter: q += " AND username ILIKE %s"; p.append(f'%{username_filter}%')
        if date_from: q += " AND created_at >= %s"; p.append(date_from)
        if date_to: q += " AND created_at <= %s"; p.append(date_to + ' 23:59:59')
        q += " ORDER BY created_at DESC LIMIT %s"; p.append(limit)
        for l in fetch_logs(c, q, p): l['source'] = 'App Ticketing'; all_logs.append(l)
        c.close()
    except Exception as e:
        print(f"[audit] Ticketing logs error: {e}")
    # Audit: action_logs has column "timestamp"
    try:
        c = get_audit_db()
        q = "SELECT id, username, action, details, ip_address, timestamp FROM action_logs WHERE 1=1"
        p = []
        if action_filter: q += " AND action ILIKE %s"; p.append(f'%{action_filter}%')
        if username_filter: q += " AND username ILIKE %s"; p.append(f'%{username_filter}%')
        if date_from: q += " AND timestamp >= %s"; p.append(date_from)
        if date_to: q += " AND timestamp <= %s"; p.append(date_to + ' 23:59:59')
        q += " ORDER BY timestamp DESC LIMIT %s"; p.append(limit)
        for l in fetch_logs(c, q, p): l['source'] = 'App Audit'; all_logs.append(l)
        c.close()
    except Exception as e:
        print(f"[audit] Audit logs error: {e}")
    # Sort and filter by source
    for lg in all_logs:
        lg['source_color'] = SRC_COLORS.get(lg.get('source', ''), '#6c757d')
        lg['source_icon'] = SRC_ICONS.get(lg.get('source', ''), 'question-circle')
        ts = lg.get('timestamp')
        if isinstance(ts, str):
            try:
                from datetime import datetime as _dt
                lg['timestamp'] = _dt.fromisoformat(ts.replace('Z', '+00:00'))
            except: pass
    all_logs.sort(key=lambda x: x.get('timestamp', ''), reverse=True)
    if source_filter:
        all_logs = [l for l in all_logs if l.get('source', '') == source_filter]
    return all_logs[:limit]

def get_stats():
    from datetime import datetime
    today = datetime.now().strftime('%Y-%m-%d')
    sources = {
        'App IAM': {'color': '#0d6efd', 'icon': 'shield-lock', 'total': 0, 'users': 0, 'today': 0},
        'App Ticketing': {'color': '#6f42c1', 'icon': 'ticket-perforated', 'total': 0, 'users': 0, 'today': 0},
        'App Audit': {'color': '#198754', 'icon': 'journal-check', 'total': 0, 'users': 0, 'today': 0},
    }
    try:
        c = get_iam_db(); cur = c.cursor()
        cur.execute("SELECT COUNT(*) FROM audit_log"); sources['App IAM']['total'] = cur.fetchone()[0]
        try: cur.execute("SELECT COUNT(DISTINCT username) FROM audit_log"); sources['App IAM']['users'] = cur.fetchone()[0]
        except: pass
        try: cur.execute("SELECT COUNT(*) FROM audit_log WHERE timestamp::date = %s", (today,)); sources['App IAM']['today'] = cur.fetchone()[0]
        except: pass
        cur.close(); c.close()
    except: pass
    try:
        c = get_ticketing_db(); cur = c.cursor()
        cur.execute("SELECT COUNT(*) FROM audit_log"); sources['App Ticketing']['total'] = cur.fetchone()[0]
        try: cur.execute("SELECT COUNT(DISTINCT username) FROM audit_log"); sources['App Ticketing']['users'] = cur.fetchone()[0]
        except: pass
        try: cur.execute("SELECT COUNT(*) FROM audit_log WHERE created_at::date = %s", (today,)); sources['App Ticketing']['today'] = cur.fetchone()[0]
        except: pass
        cur.close(); c.close()
    except: pass
    try:
        c = get_audit_db(); cur = c.cursor()
        cur.execute("SELECT COUNT(*) FROM action_logs"); sources['App Audit']['total'] = cur.fetchone()[0]
        try: cur.execute("SELECT COUNT(DISTINCT username) FROM action_logs"); sources['App Audit']['users'] = cur.fetchone()[0]
        except: pass
        try: cur.execute("SELECT COUNT(*) FROM action_logs WHERE timestamp::date = %s", (today,)); sources['App Audit']['today'] = cur.fetchone()[0]
        except: pass
        cur.close(); c.close()
    except: pass
    total = sum(s['total'] for s in sources.values())
    return {
        'total_logs': total,
        'total_users': sum(s['users'] for s in sources.values()),
        'today_logs': sum(s['today'] for s in sources.values()),
        'by_source': sources,
        'iam': sources['App IAM']['total'],
        'ticketing': sources['App Ticketing']['total'],
        'audit': sources['App Audit']['total'],
        'total': total,
    }

@app.route('/')
def index():
    if not is_authenticated():
        return redirect(url_for("login"))
    user = current_user()
    stats = get_stats()
    recent = get_all_logs(limit=10)
    log_app_action("view_audit_dashboard", {"total_logs": stats['total'], "iam": stats['iam'], "ticketing": stats['ticketing'], "audit": stats['audit']})
    return render_template('index.html', user=user, stats=stats, recent_logs=recent)

@app.route('/logs')
def logs_page():
    if not is_authenticated():
        return redirect(url_for("login"))
    user = current_user()
    sf = request.args.get('source', '')
    af = request.args.get('action', '')
    uf = request.args.get('username', '')
    df = request.args.get('date_from', '')
    dt = request.args.get('date_to', '')
    logs = get_all_logs(limit=200, source_filter=sf, action_filter=af, username_filter=uf, date_from=df, date_to=dt)
    log_app_action("view_all_logs", {"filters": {"source": sf or "all", "action": af or "all"}, "count": len(logs)})
    return render_template('logs.html', user=user, logs=logs,
                           log_sources=LOG_SOURCES,
                           filter_source=sf, filter_user=uf,
                           filter_date_from=df, filter_date_to=dt,
                           filter_action=af)

@app.route('/login')
def login():
    log_app_action("login_attempt", {"page": "login"})
    return login_redirect()

@app.route('/callback')
def callback():
    if handle_callback(): return redirect(url_for("index"))
    return redirect(url_for("login"))

@app.route('/logout')
def logout():
    user = current_user()
    username = user.get('username', 'unknown') if user else 'unknown'
    if username != 'unknown':
        log_app_action("logout", {"username": username, "ip_address": request.remote_addr})
    resp, _ = oidc_logout()
    return resp

@app.route('/health')
def health():
    return jsonify({"status": "ok", "app": "audit"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
