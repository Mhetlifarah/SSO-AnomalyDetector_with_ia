"""
Shared OIDC module for Keycloak authentication.
Uses requests library for the Authorization Code flow.
Supports OIDC_EXTERNAL_ISSUER to replace internal URLs for browser redirects.
"""
import os, time, functools, requests
from flask import session, redirect, url_for, request, current_app
from urllib.parse import urlencode

_oidc_config = {}

def init_oidc(app):
    global _oidc_config
    _oidc_config = {
        'client_id': app.config.get('OIDC_CLIENT_ID'),
        'client_secret': app.config.get('OIDC_CLIENT_SECRET'),
        'issuer': app.config.get('OIDC_ISSUER'),
        'redirect_uri': app.config.get('OIDC_REDIRECT_URI'),
        'external_issuer': app.config.get('OIDC_EXTERNAL_ISSUER', ''),
    }
    try:
        discovery_url = f"{_oidc_config['issuer']}/.well-known/openid-configuration"
        resp = requests.get(discovery_url, verify=False, timeout=10)
        if resp.ok:
            d = resp.json()
            _oidc_config['authorization_endpoint'] = d.get('authorization_endpoint')
            _oidc_config['token_endpoint'] = d.get('token_endpoint')
            _oidc_config['userinfo_endpoint'] = d.get('userinfo_endpoint')
            _oidc_config['end_session_endpoint'] = d.get('end_session_endpoint')
            print(f"[OIDC] Discovered endpoints for {_oidc_config['client_id']}")
        else:
            print(f"[OIDC] WARNING: Discovery failed, using defaults")
            _set_default_endpoints()
    except Exception as e:
        print(f"[OIDC] WARNING: Discovery error: {e}, using defaults")
        _set_default_endpoints()

    # Replace internal URLs with external URLs for browser-facing endpoints
    ext = _oidc_config.get('external_issuer', '')
    int_issuer = _oidc_config['issuer']
    if ext and ext != int_issuer:
        for key in ['authorization_endpoint', 'end_session_endpoint']:
            val = _oidc_config.get(key, '')
            if val and val.startswith(int_issuer):
                new_val = ext + val[len(int_issuer):]
                _oidc_config[key] = new_val
                print(f"[OIDC] {key}: {val} -> {new_val}")
        print(f"[OIDC] Using external issuer for browser redirects: {ext}")

    app.oidc = _oidc_config

def _set_default_endpoints():
    issuer = _oidc_config['issuer']
    _oidc_config['authorization_endpoint'] = f"{issuer}/protocol/openid-connect/auth"
    _oidc_config['token_endpoint'] = f"{issuer}/protocol/openid-connect/token"
    _oidc_config['userinfo_endpoint'] = f"{issuer}/protocol/openid-connect/userinfo"
    _oidc_config['end_session_endpoint'] = f"{issuer}/protocol/openid-connect/logout"

def login_redirect():
    params = {
        'client_id': _oidc_config['client_id'],
        'response_type': 'code',
        'redirect_uri': _oidc_config['redirect_uri'],
        'scope': 'openid profile email',
    }
    auth_url = f"{_oidc_config['authorization_endpoint']}?{urlencode(params)}"
    return redirect(auth_url)

def handle_callback():
    code = request.args.get('code')
    if not code:
        print("[OIDC] No authorization code in callback")
        return False
    try:
        token_resp = requests.post(
            _oidc_config['token_endpoint'],
            data={
                'grant_type': 'authorization_code',
                'code': code,
                'redirect_uri': _oidc_config['redirect_uri'],
                'client_id': _oidc_config['client_id'],
                'client_secret': _oidc_config['client_secret'],
            },
            verify=False, timeout=10,
        )
        if not token_resp.ok:
            print(f"[OIDC] Token exchange failed: {token_resp.status_code} - {token_resp.text[:300]}")
            return False
        tokens = token_resp.json()
        access_token = tokens.get('access_token')
        id_token = tokens.get('id_token')
        userinfo_resp = requests.get(
            _oidc_config['userinfo_endpoint'],
            headers={'Authorization': f'Bearer {access_token}'},
            verify=False, timeout=10,
        )
        if not userinfo_resp.ok:
            print(f"[OIDC] Userinfo failed: {userinfo_resp.status_code}")
            return False
        userinfo = userinfo_resp.json()
        import uuid
        session_id = str(uuid.uuid4())
        session['user'] = {
            'keycloak_id': userinfo.get('sub'),
            'username': userinfo.get('preferred_username', userinfo.get('sub')),
            'email': userinfo.get('email', ''),
            'roles': _extract_roles(userinfo, access_token),
            'access_token': access_token,
            'id_token': id_token,
        }
        session['session_id'] = session_id
        session.permanent = True
        print(f"[OIDC] User logged in: {session['user']['username']} (keycloak_id={session['user']['keycloak_id']})")
        return True
    except Exception as e:
        print(f"[OIDC] Callback error: {e}")
        return False

def _extract_roles(userinfo, access_token):
    roles = ['user']
    try:
        # Check realm_access.roles first (standard Keycloak)
        realm_access = userinfo.get('realm_access', {})
        if realm_access and 'roles' in realm_access:
            roles = realm_access['roles']
        # Check top-level 'roles' (custom mapper with claim.name=roles)
        elif 'roles' in userinfo:
            r = userinfo.get('roles', [])
            if isinstance(r, list):
                roles = r
    except Exception:
        pass
    return roles

def logout():
    user = session.pop('user', None)
    username = user.get('username', 'unknown') if user else 'unknown'
    id_token = user.get('id_token', '') if user else ''
    end_session = _oidc_config.get('end_session_endpoint', '')
    if end_session:
        params = {
            'client_id': _oidc_config['client_id'],
            'post_logout_redirect_uri': _oidc_config['redirect_uri'].rsplit('/', 1)[0] + '/',
        }
        if id_token:
            params['id_token_hint'] = id_token
        logout_url = f"{end_session}?{urlencode(params)}"
        return redirect(logout_url), username
    app_root = current_app.config.get('APPLICATION_ROOT', '/')
    return redirect(app_root + '/'), username

def get_current_user():
    return session.get('user')

def is_authenticated():
    return 'user' in session

def login_required(f):
    @functools.wraps(f)
    def decorated(*args, **kwargs):
        if not is_authenticated():
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated

def require_role(*roles):
    def decorator(f):
        @functools.wraps(f)
        def decorated(*args, **kwargs):
            if not is_authenticated():
                return redirect(url_for('login'))
            user_roles = session.get('user', {}).get('roles', [])
            if not any(r in user_roles for r in roles):
                return "Forbidden: Insufficient role", 403
            return f(*args, **kwargs)
        return decorated
    return decorator
