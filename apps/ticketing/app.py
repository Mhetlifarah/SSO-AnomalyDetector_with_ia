import os, sys
from flask import Flask, render_template, redirect, url_for, session, request, jsonify, flash
from werkzeug.middleware.proxy_fix import ProxyFix
import psycopg2
sys.path.insert(0, '/app')
from oidc import init_oidc, login_redirect, handle_callback, logout as oidc_logout, is_authenticated, get_current_user
from kafka_logger import log_action

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', os.environ.get('APP_SECRET_KEY', 'ticketing-key'))
app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1)
app.config['APPLICATION_ROOT'] = '/ticketing'
app.config["OIDC_CLIENT_ID"] = os.environ.get("OIDC_CLIENT_ID")
app.config["OIDC_CLIENT_SECRET"] = os.environ.get("OIDC_CLIENT_SECRET")
app.config["OIDC_ISSUER"] = os.environ.get("OIDC_ISSUER")
app.config["OIDC_REDIRECT_URI"] = os.environ.get("OIDC_REDIRECT_URI")
init_oidc(app)

APP_NAME = "ticketing"
DB_HOST = os.environ.get('DB_HOST', 'postgres')
DB_PORT = os.environ.get('DB_PORT', '5432')
DB_NAME = os.environ.get('DB_NAME', 'ticketing_db')
DB_USER = os.environ.get('DB_USER', 'pfe')
DB_PASS = os.environ.get('DB_PASS', 'pfe_secret')

def get_db():
    return psycopg2.connect(host=DB_HOST, port=DB_PORT, dbname=DB_NAME, user=DB_USER, password=DB_PASS)

def current_user():
    u = get_current_user()
    return u if u else {}

def log_app_action(action, details=None, severity="INFO"):
    log_action(APP_NAME, action, details=details, user=current_user(), severity=severity)
    try:
        user = current_user()
        username = user.get('name', 'unknown') if user else 'unknown'
        conn = get_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO audit_log (username, action, details, ip_address) VALUES (%s, %s, %s, %s)", (username, action, str(details) if details else '', request.remote_addr))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        print(f"[ticketing] audit_log error: {e}")

@app.route('/')
def index():
    if not is_authenticated():
        return redirect(url_for("login"))
    user = current_user()
    conn = get_db()
    cur = conn.cursor()
    status_filter = request.args.get('status', '')
    priority_filter = request.args.get('priority', '')
    q = "SELECT id, title, description, status, priority, created_by, assigned_to, created_at, updated_at FROM tickets WHERE 1=1"
    params = []
    if status_filter:
        q += " AND status = %s"
        params.append(status_filter)
    if priority_filter:
        q += " AND priority = %s"
        params.append(priority_filter)
    q += " ORDER BY created_at DESC"
    cur.execute(q, params)
    cols = [desc[0] for desc in cur.description]
    tickets = [dict(zip(cols, row)) for row in cur.fetchall()]
    cur.execute("SELECT COUNT(*) FROM tickets")
    total = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM tickets WHERE status='open'")
    open_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM tickets WHERE status='in_progress'")
    in_progress_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM tickets WHERE status='resolved'")
    resolved_count = cur.fetchone()[0]
    cur.execute("SELECT COUNT(*) FROM tickets WHERE status='closed'")
    closed_count = cur.fetchone()[0]
    cur.close()
    conn.close()
    log_app_action("view_tickets", {"total": total, "filter_status": status_filter or "all", "filter_priority": priority_filter or "all"})
    return render_template('index.html', user=user, tickets=tickets, total=total, open_count=open_count, in_progress_count=in_progress_count, resolved_count=resolved_count, closed_count=closed_count, status_filter=status_filter, priority_filter=priority_filter)

@app.route('/tickets/new', methods=['GET', 'POST'])
def new_ticket():
    user = current_user()
    if request.method == 'POST':
        title = request.form.get('title', '')
        description = request.form.get('description', '')
        priority = request.form.get('priority', 'medium')
        conn = get_db()
        cur = conn.cursor()
        cur.execute("INSERT INTO tickets (title, description, status, priority, created_by, assigned_to) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id", (title, description, 'open', priority, user.get('name', 'unknown'), ''))
        ticket_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()
        log_app_action("create_ticket", {"ticket_id": ticket_id, "title": title, "priority": priority, "status": "open"})
        flash('Ticket cree!', 'success')
        return redirect(url_for('index'))
    log_app_action("view_new_ticket_form", {"page": "new_ticket"})
    return render_template('new_ticket.html', user=user)

@app.route('/tickets/<int:ticket_id>')
def view_ticket(ticket_id):
    user = current_user()
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT id, title, description, status, priority, created_by, assigned_to, created_at, updated_at FROM tickets WHERE id=%s", (ticket_id,))
    cols = [desc[0] for desc in cur.description]
    ticket = dict(zip(cols, cur.fetchone())) if cur.rowcount else None
    cur.close()
    conn.close()
    if not ticket:
        flash('Ticket non trouve', 'danger')
        return redirect(url_for('index'))
    log_app_action("view_ticket_detail", {"ticket_id": ticket_id, "title": ticket['title'], "status": ticket['status']})
    return render_template('view_ticket.html', user=user, ticket=ticket)

@app.route('/tickets/<int:ticket_id>/status', methods=['POST'])
def update_status(ticket_id):
    user = current_user()
    new_status = request.form.get('status', '')
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT title, status FROM tickets WHERE id=%s", (ticket_id,))
    row = cur.fetchone()
    old_status = row[1] if row else 'unknown'
    ticket_title = row[0] if row else 'unknown'
    cur.execute("UPDATE tickets SET status=%s, updated_at=NOW() WHERE id=%s", (new_status, ticket_id))
    conn.commit()
    cur.close()
    conn.close()
    log_app_action("change_ticket_status", {"ticket_id": ticket_id, "title": ticket_title, "old_status": old_status, "new_status": new_status}, severity="WARNING")
    flash(f'Statut mis a jour: {new_status}', 'success')
    return redirect(url_for('view_ticket', ticket_id=ticket_id))

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
    username = user.get('name', 'unknown')
    if username != 'unknown':
        log_app_action("logout", {"username": username, "ip_address": request.remote_addr})
    resp, _ = oidc_logout()
    return resp

@app.route('/health')
def health():
    return jsonify({"status": "ok", "app": "ticketing"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
