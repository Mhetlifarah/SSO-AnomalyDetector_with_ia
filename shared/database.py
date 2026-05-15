"""
shared/database.py – Connexion PostgreSQL pour les 3 applications
"""

import os
import psycopg2
import psycopg2.extras


def get_db():
    conn = psycopg2.connect(os.environ["DATABASE_URL"])
    conn.autocommit = True
    return conn


def get_db_for_database(dbname):
    base_url = os.environ["DATABASE_URL"]
    parts = base_url.rsplit('/', 1)
    new_url = f"{parts[0]}/{dbname}"
    conn = psycopg2.connect(new_url)
    conn.autocommit = True
    return conn


def query(sql, params=None):
    conn = get_db()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
            cur.execute(sql, params)
            return cur.fetchall()
    finally:
        conn.close()


def execute(sql, params=None):
    conn = get_db()
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
    finally:
        conn.close()


def execute_on_db(dbname, sql, params=None):
    conn = get_db_for_database(dbname)
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
    finally:
        conn.close()


def log_action_with_details(dbname, table_name, username, action, ip_address, user_agent, keycloak_id=None, session_id=None):
    conn = get_db_for_database(dbname)
    try:
        with conn.cursor() as cur:
            # Troncature du session_id à 100 caractères
            if session_id and len(session_id) > 100:
                session_id = session_id[:100]
            
            if keycloak_id and session_id:
                cur.execute(f"""
                    INSERT INTO {table_name} 
                    (username, keycloak_id, action, ip_address, user_agent, session_id, timestamp)
                    VALUES (%s, %s, %s, %s, %s, %s, NOW())
                """, (username, keycloak_id, action, ip_address, user_agent, session_id))
            elif keycloak_id:
                cur.execute(f"""
                    INSERT INTO {table_name} 
                    (username, keycloak_id, action, ip_address, user_agent, timestamp)
                    VALUES (%s, %s, %s, %s, %s, NOW())
                """, (username, keycloak_id, action, ip_address, user_agent))
            else:
                cur.execute(f"""
                    INSERT INTO {table_name} 
                    (username, action, ip_address, user_agent, timestamp)
                    VALUES (%s, %s, %s, %s, NOW())
                """, (username, action, ip_address, user_agent))
    finally:
        conn.close()
