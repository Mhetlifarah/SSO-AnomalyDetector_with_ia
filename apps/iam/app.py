import os, sys
from flask import Flask, render_template, redirect, url_for, session, request, jsonify
from werkzeug.middleware.proxy_fix import ProxyFix
import psycopg2
import psycopg2.extras
sys.path.insert(0, '/app')
from oidc import init_oidc, login_redirect, handle_callback, logout as oidc_logout, get_current_user, is_authenticated, login_required, require_role
from kafka_logger import log_action
from datetime import datetime

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', 'iam-key')
app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1)
app.config['APPLICATION_ROOT'] = '/iam'

app.config["OIDC_CLIENT_ID"] = os.environ.get("OIDC_CLIENT_ID")
app.config["OIDC_CLIENT_SECRET"] = os.environ.get("OIDC_CLIENT_SECRET")
app.config["OIDC_ISSUER"] = os.environ.get("OIDC_ISSUER")
app.config["OIDC_REDIRECT_URI"] = os.environ.get("OIDC_REDIRECT_URI")
init_oidc(app)

APP_NAME = "iam"
DB_HOST = os.environ.get('DB_HOST', 'postgres')
DB_PORT = os.environ.get('DB_PORT', '5432')
DB_NAME = os.environ.get('DB_NAME', 'iam_db')
DB_USER = os.environ.get('DB_USER', 'pfe')
DB_PASS = os.environ.get('DB_PASS', 'pfe_secret')

def get_db():
    return psycopg2.connect(host=DB_HOST, port=DB_PORT, dbname=DB_NAME, user=DB_USER, password=DB_PASS)

def current_user():
    u = get_current_user()
    return u if u else {}

def _log(action, details=None, severity="INFO"):
    user = get_current_user()
    username = user.get('username', 'anonymous') if user else 'anonymous'
    log_action(APP_NAME, action, details=details or {}, user=username, severity=severity)

def _log_to_audit(action, details=None):
    user = get_current_user()
    if not user:
        return
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO audit_log (keycloak_id, username, action, details, ip_address, user_agent, hour_of_day, session_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
            (user.get('keycloak_id'), user.get('username'), action,
             str(details or ''), request.remote_addr,
             request.headers.get('User-Agent', '')[:500],
             datetime.utcnow().hour, session.get('session_id', '')))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"[IAM] audit_log error: {e}")

def _ensure_user_in_db():
    user = get_current_user()
    if not user:
        return
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute(
            """INSERT INTO users (keycloak_id, username, email, role)
               VALUES (%s, %s, %s, %s)
               ON CONFLICT (keycloak_id) DO UPDATE SET
                 username = EXCLUDED.username, email = EXCLUDED.email""",
            (user.get('keycloak_id'), user.get('username'), user.get('email', ''),
             'admin' if 'admin' in user.get('roles', []) else 'user'))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"[IAM] Error syncing user: {e}")

def query_one(sql, params=None):
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(sql, params)
    row = cur.fetchone()
    cur.close()
    conn.close()
    return row

def query_all(sql, params=None):
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(sql, params)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return rows

def execute_sql(sql, params=None):
    conn = get_db()
    cur = conn.cursor()
    cur.execute(sql, params)
    conn.commit()
    cur.close()
    conn.close()


@app.route('/')
def index():
    if not is_authenticated():
        return redirect(url_for('login'))
    _ensure_user_in_db()
    _log('view_dashboard')
    _log_to_audit('view_dashboard')

    total_users = query_one("SELECT COUNT(*) as c FROM users")['c']
    total_logs = query_one("SELECT COUNT(*) as c FROM audit_log")['c']
    today_logs = query_one("SELECT COUNT(*) as c FROM audit_log WHERE DATE(timestamp) = CURRENT_DATE")['c']
    recent_logs = query_all("SELECT * FROM audit_log ORDER BY timestamp DESC LIMIT 10")

    return render_template('index.html',
                           total_users=total_users, total_logs=total_logs,
                           today_logs=today_logs, recent_logs=recent_logs,
                           user=get_current_user())


@app.route('/profile')
@login_required
def profile():
    _ensure_user_in_db()
    _log('view_profile')
    _log_to_audit('view_profile')
    user = get_current_user()
    db_user = query_one("SELECT * FROM users WHERE keycloak_id = %s", (user.get('keycloak_id'),))
    user_logs = query_all("SELECT * FROM audit_log WHERE keycloak_id = %s ORDER BY timestamp DESC LIMIT 20", (user.get('keycloak_id'),))
    return render_template('profile.html', db_user=db_user, user_logs=user_logs, user=get_current_user())


@app.route('/users')
@login_required
def users():
    _log('view_users_list')
    _log_to_audit('view_users_list')
    all_users = query_all("SELECT * FROM users ORDER BY created_at DESC")
    return render_template('users.html', all_users=all_users, user=get_current_user())


@app.route('/users/<int:user_id>')
@login_required
def user_detail(user_id):
    _log('view_user_detail', {'target_user_id': user_id})
    _log_to_audit('view_user_detail', {'target_user_id': user_id})
    target = query_one("SELECT * FROM users WHERE id = %s", (user_id,))
    if not target:
        return "User not found", 404
    target_logs = query_all("SELECT * FROM audit_log WHERE keycloak_id = %s ORDER BY timestamp DESC LIMIT 20", (target.get('keycloak_id'),))
    return render_template('user_detail.html', target=target, target_logs=target_logs, user=get_current_user())


@app.route('/users/<int:user_id>/role', methods=['POST'])
@login_required
@require_role('admin')
def change_role(user_id):
    new_role = request.form.get('role', 'user')
    execute_sql("UPDATE users SET role = %s WHERE id = %s", (new_role, user_id))
    _log('change_user_role', {'target_user_id': user_id, 'new_role': new_role}, severity="WARNING")
    _log_to_audit('change_user_role', {'target_user_id': user_id, 'new_role': new_role})
    return redirect(url_for('users'))


@app.route('/audit-logs')
@login_required
def audit_logs():
    _log('view_audit_logs')
    _log_to_audit('view_audit_logs')
    page = request.args.get('page', 1, type=int)
    per_page = 25
    offset = (page - 1) * per_page
    logs = query_all("SELECT * FROM audit_log ORDER BY timestamp DESC LIMIT %s OFFSET %s", (per_page, offset))
    total = query_one("SELECT COUNT(*) as c FROM audit_log")['c']
    return render_template('audit.html', logs=logs, page=page,
                           total_pages=max(1, (total + per_page - 1) // per_page),
                           user=get_current_user())


@app.route('/login')
def login():
    if is_authenticated():
        return redirect(url_for('index'))
    return login_redirect()


@app.route('/callback')
def callback():
    if handle_callback(): return redirect(url_for("index"))
    return redirect(url_for("login"))


@app.route('/logout')
def logout():
    _log('logout')
    _log_to_audit('logout')
    resp, _ = oidc_logout()
    return resp


@app.route('/health')
def health():
    return jsonify({"status": "ok", "app": APP_NAME})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
