--
-- PostgreSQL database cluster dump
--

\restrict dMcQD31ph5N3L1ZEZvndrDqCMaGnbedq7Lv2gLnVt8U7qQWK4ca98oDXzilvcZW

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE pfe;
ALTER ROLE pfe WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:r1tK7tRV1GgXLgvWvF5ldw==$4UxeIQpAYNwMvRl7oVD4FwrEm5ea0vlHLEY9SM9J/2Q=:Xhc4bpxW+kVmmQo/i6UaM93KZGXtnfNvABml5Ezhfoc=';

--
-- User Configurations
--








\unrestrict dMcQD31ph5N3L1ZEZvndrDqCMaGnbedq7Lv2gLnVt8U7qQWK4ca98oDXzilvcZW

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict 2lpvaR4Yl6IPx8XrSUYq63ic4RM3sCyS68Tau6PcGVdnquVzTiWNWAlg6Weq1TB

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 2lpvaR4Yl6IPx8XrSUYq63ic4RM3sCyS68Tau6PcGVdnquVzTiWNWAlg6Weq1TB

--
-- Database "anomaly_db" dump
--

--
-- PostgreSQL database dump
--

\restrict cEmBgV9pv4bBXjPzT79Weyz7amcvbnY2VTyrz7Kbeh1VMWpwXO1ZIu98mS6Ad2a

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: anomaly_db; Type: DATABASE; Schema: -; Owner: pfe
--

CREATE DATABASE anomaly_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE anomaly_db OWNER TO pfe;

\unrestrict cEmBgV9pv4bBXjPzT79Weyz7amcvbnY2VTyrz7Kbeh1VMWpwXO1ZIu98mS6Ad2a
\connect anomaly_db
\restrict cEmBgV9pv4bBXjPzT79Weyz7amcvbnY2VTyrz7Kbeh1VMWpwXO1ZIu98mS6Ad2a

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: anomalies; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.anomalies (
    id integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    username character varying(128) NOT NULL,
    keycloak_id character varying(256),
    anomaly_score double precision NOT NULL,
    anomaly_type character varying(64) NOT NULL,
    model_used character varying(64) NOT NULL,
    details jsonb,
    is_confirmed boolean DEFAULT false
);


ALTER TABLE public.anomalies OWNER TO pfe;

--
-- Name: anomalies_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.anomalies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.anomalies_id_seq OWNER TO pfe;

--
-- Name: anomalies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.anomalies_id_seq OWNED BY public.anomalies.id;


--
-- Name: model_metrics; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.model_metrics (
    id integer NOT NULL,
    model_name character varying(64) NOT NULL,
    accuracy double precision,
    precision_score double precision,
    recall double precision,
    f1_score double precision,
    trained_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.model_metrics OWNER TO pfe;

--
-- Name: model_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.model_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.model_metrics_id_seq OWNER TO pfe;

--
-- Name: model_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.model_metrics_id_seq OWNED BY public.model_metrics.id;


--
-- Name: anomalies id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.anomalies ALTER COLUMN id SET DEFAULT nextval('public.anomalies_id_seq'::regclass);


--
-- Name: model_metrics id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.model_metrics ALTER COLUMN id SET DEFAULT nextval('public.model_metrics_id_seq'::regclass);


--
-- Data for Name: anomalies; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.anomalies (id, "timestamp", username, keycloak_id, anomaly_score, anomaly_type, model_used, details, is_confirmed) FROM stdin;
\.


--
-- Data for Name: model_metrics; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.model_metrics (id, model_name, accuracy, precision_score, recall, f1_score, trained_at) FROM stdin;
\.


--
-- Name: anomalies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.anomalies_id_seq', 1, false);


--
-- Name: model_metrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.model_metrics_id_seq', 1, false);


--
-- Name: anomalies anomalies_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.anomalies
    ADD CONSTRAINT anomalies_pkey PRIMARY KEY (id);


--
-- Name: model_metrics model_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.model_metrics
    ADD CONSTRAINT model_metrics_pkey PRIMARY KEY (id);


--
-- Name: idx_anomalies_score; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_anomalies_score ON public.anomalies USING btree (anomaly_score);


--
-- Name: idx_anomalies_timestamp; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_anomalies_timestamp ON public.anomalies USING btree ("timestamp");


--
-- Name: idx_anomalies_type; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_anomalies_type ON public.anomalies USING btree (anomaly_type);


--
-- Name: idx_anomalies_username; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_anomalies_username ON public.anomalies USING btree (username);


--
-- Name: idx_model_metrics_name; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_model_metrics_name ON public.model_metrics USING btree (model_name);


--
-- Name: idx_model_metrics_trained_at; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_model_metrics_trained_at ON public.model_metrics USING btree (trained_at);


--
-- PostgreSQL database dump complete
--

\unrestrict cEmBgV9pv4bBXjPzT79Weyz7amcvbnY2VTyrz7Kbeh1VMWpwXO1ZIu98mS6Ad2a

--
-- Database "audit_db" dump
--

--
-- PostgreSQL database dump
--

\restrict k89uqnQXP6MBO8AZwCviAvexiMgaDKZeyoWZtXf3VJLr0vJedZKj6OIJPv5D9dg

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: audit_db; Type: DATABASE; Schema: -; Owner: pfe
--

CREATE DATABASE audit_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE audit_db OWNER TO pfe;

\unrestrict k89uqnQXP6MBO8AZwCviAvexiMgaDKZeyoWZtXf3VJLr0vJedZKj6OIJPv5D9dg
\connect audit_db
\restrict k89uqnQXP6MBO8AZwCviAvexiMgaDKZeyoWZtXf3VJLr0vJedZKj6OIJPv5D9dg

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_logs; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.action_logs (
    id integer NOT NULL,
    keycloak_id character varying(255),
    username character varying(100) NOT NULL,
    action character varying(100) NOT NULL,
    details text DEFAULT ''::text,
    "timestamp" timestamp without time zone DEFAULT now(),
    ip_address character varying(45),
    user_agent character varying(512),
    hour_of_day integer,
    session_id character varying(128),
    severity character varying(20) DEFAULT 'INFO'::character varying
);


ALTER TABLE public.action_logs OWNER TO pfe;

--
-- Name: action_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.action_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.action_logs_id_seq OWNER TO pfe;

--
-- Name: action_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.action_logs_id_seq OWNED BY public.action_logs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.users (
    id integer NOT NULL,
    keycloak_id character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: action_logs id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.action_logs ALTER COLUMN id SET DEFAULT nextval('public.action_logs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: action_logs; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.action_logs (id, keycloak_id, username, action, details, "timestamp", ip_address, user_agent, hour_of_day, session_id, severity) FROM stdin;
1	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-01 01:55:43.071264	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	INFO
2	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-01 01:55:59.563009	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	INFO
3	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN		2026-05-01 10:00:18.753674	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	INFO
4	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-01 10:00:18.794759	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJydlduOqzYUhl-lynVTcQiZyb5qwikwwWwIYOyqGoEhwWAIO-QAbPXda5hpe9GqlXpFZNbPOnj9X74vEkLyrnu_Xaq8WXxZ5IN	INFO
5	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-01 12:08:17.658361	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJydlduOqzYUhl-lynVTcQiZyb5qwikwwWwIYOyqGoEhwWAIO-QAbPXda5hpe9GqlXpFZNbPOnj9X74vEkLyrnu_Xaq8WXxZ5IN	INFO
6	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	LOGIN		2026-05-01 12:57:43.461597	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	INFO
7	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 12:57:43.515816	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydVdmOq0YU_JXIz_EVmxfuU2zw0hgag9maKBqx2SzdtmfAYIjy7zl4JpGiRImUJ_Dxqe46SxW_TqIkyer6rblV2XXyfZL1Wh7	INFO
8	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	LOGIN		2026-05-01 12:58:09.369832	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydVdmOq0YU_JXIz_EVmxfuU2zw0hgag9maKBqx2SzdtmfAYIjy7zl4JpGiRImUJ_Dxqe46SxW_TqIkyer6rblV2XXyfZL1Wh7	INFO
9	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 12:58:09.404677	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydVWvPssYW_Ssnfq5vuPrI-6kKgvjKoAiMMycnhrvA4A2US9P_3o3P0yZNe9Kkn8Bxr9lrX9bil0kQRUldn5prmVwm3ydJvzm	INFO
10	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 12:58:09.835291	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydVWvPssYW_Ssnfq5vuPrI-6kKgvjKoAiMMycnhrvA4A2US9P_3o3P0yZNe9Kkn8Bxr9lrX9bil0kQRUldn5prmVwm3ydJvzm	INFO
11	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 12:58:15.375533	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydVWvPssYW_Ssnfq5vuPrI-6kKgvjKoAiMMycnhrvA4A2US9P_3o3P0yZNe9Kkn8Bxr9lrX9bil0kQRUldn5prmVwm3ydJvzm	INFO
12	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN		2026-05-01 13:45:44.44293	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	none	INFO
13	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-01 13:45:44.474969	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJydVV2PqzYU_CtVnrsVHyHZ3KdmQyAmYBbCl6mqCAwJNiZhA0mAqv-9ht17-1K1Up-MjIcz53hm-GOWYJw3zbG9lvll9m2W90a	INFO
14	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN		2026-05-01 13:48:40.04049	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	INFO
15	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-01 13:48:40.074805	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVdmuq8YS_ZXIz_ERs815is02uDkM20xNdxRtQRubqTHbYDNE-ffbOLlJpBvdSMlTW9WsrqpVq5Z_XiWEZF330d-qrFl9XWW	INFO
16	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	LOGIN		2026-05-01 16:56:39.710768	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	INFO
17	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 16:56:39.750402	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydldmOq8YWhl_lyNfxFqPb7Ku4wUOxqaLBzEdHLSiwGQpMG2wMUd49C3cnUpToRMoFAoq1qtb0f_yyiCnNuu69v1RZs_i-yEY	INFO
18	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_LOGS		2026-05-01 16:56:50.252935	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydldmOq8YWhl_lyNfxFqPb7Ku4wUOxqaLBzEdHLSiwGQpMG2wMUd49C3cnUpToRMoFAoq1qtb0f_yyiCnNuu69v1RZs_i-yEY	INFO
19	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 16:57:01.023765	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydldmOq8YWhl_lyNfxFqPb7Ku4wUOxqaLBzEdHLSiwGQpMG2wMUd49C3cnUpToRMoFAoq1qtb0f_yyiCnNuu69v1RZs_i-yEY	INFO
20	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD		2026-05-01 16:57:17.33539	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydldmOq8YWhl_lyNfxFqPb7Ku4wUOxqaLBzEdHLSiwGQpMG2wMUd49C3cnUpToRMoFAoq1qtb0f_yyiCnNuu69v1RZs_i-yEY	INFO
21	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	LOGOUT		2026-05-01 16:57:19.814149	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJydldmOq8YWhl_lyNfxFqPb7Ku4wUOxqaLBzEdHLSiwGQpMG2wMUd49C3cnUpToRMoFAoq1qtb0f_yyiCnNuu69v1RZs_i-yEY	INFO
22	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN		2026-05-01 22:13:04.522724	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	INFO
23	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-01 22:13:10.809345	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
24	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-01 22:24:05.301538	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
25	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-01 22:24:20.873816	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
26	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_LOGS		2026-05-01 22:24:27.370893	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
27	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_LOGS		2026-05-01 22:24:48.087975	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
28	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-01 22:25:03.413583	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllVmPqzgahv_KKNedI5aQhHPVhCTEFIYKAYw9GpXYEjYTiqVYWv3fx-T09Iw0rWmp58rRZ15_-5NfVkEUJW370T2LpFp9XyW	INFO
29	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN		2026-05-02 08:43:01.35207	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	INFO
30	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-02 08:43:01.426467	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVdmuo0YQ_ZXIz_GI1fcyT7HNYrh0c8Fs3VFksdksjTfALKP59zSeySRSRhlp8gSqpvpU1Tl1-LSIkiRrmkN7qbLz4uMiG40	INFO
31	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-02 08:43:32.283957	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVdmuo0YQ_ZXIz_GI1fcyT7HNYrh0c8Fs3VFksdksjTfALKP59zSeySRSRhlp8gSqpvpU1Tl1-LSIkiRrmkN7qbLz4uMiG40	INFO
32	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD		2026-05-02 08:45:27.203153	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVdmuo0YQ_ZXIz_GI1fcyT7HNYrh0c8Fs3VFksdksjTfALKP59zSeySRSRhlp8gSqpvpU1Tl1-LSIkiRrmkN7qbLz4uMiG40	INFO
33	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN		2026-05-02 09:03:35.223395	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	none	INFO
34	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-02 09:03:35.311173	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJydlVmPqzYYhv9KleumYgmZyblqBkJiBsNA2OyqOgJDwmITEkhYqv73msy0valaqVcg2y_f4u99-G0RE5K17ffuUmX14tsiG40	INFO
35	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-02 09:07:33.709144	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJydlVmPqzYYhv9KleumYgmZyblqBkJiBsNA2OyqOgJDwmITEkhYqv73msy0valaqVcg2y_f4u99-G0RE5K17ffuUmX14tsiG40	INFO
36	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD		2026-05-02 09:07:44.2848	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJydlVmPqzYYhv9KleumYgmZyblqBkJiBsNA2OyqOgJDwmITEkhYqv73msy0valaqVcg2y_f4u99-G0RE5K17ffuUmX14tsiG40	INFO
39	\N	unknown	view_audit_dashboard	{'total_logs': 94, 'iam': 57, 'ticketing': 1, 'audit': 36}	2026-05-02 11:20:32.537671	172.18.0.1	\N	\N	\N	INFO
40	\N	Alice Admin	view_audit_dashboard	{'total_logs': 96, 'iam': 57, 'ticketing': 2, 'audit': 37}	2026-05-02 11:21:05.363042	192.168.222.143	\N	\N	\N	INFO
41	\N	Alice Admin	view_audit_dashboard	{'total_logs': 97, 'iam': 57, 'ticketing': 2, 'audit': 38}	2026-05-02 11:21:07.820732	192.168.222.143	\N	\N	\N	INFO
42	\N	Alice Admin	view_audit_dashboard	{'total_logs': 98, 'iam': 57, 'ticketing': 2, 'audit': 39}	2026-05-02 11:21:21.098215	192.168.222.143	\N	\N	\N	INFO
43	\N	Alice Admin	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 2}	2026-05-02 11:21:52.910641	192.168.222.143	\N	\N	\N	INFO
44	\N	Alice Admin	view_audit_dashboard	{'total_logs': 100, 'iam': 57, 'ticketing': 2, 'audit': 41}	2026-05-02 11:21:57.686011	192.168.222.143	\N	\N	\N	INFO
45	\N	unknown	view_audit_dashboard	{'total_logs': 101, 'iam': 57, 'ticketing': 2, 'audit': 42}	2026-05-02 11:22:40.584874	127.0.0.1	\N	\N	\N	INFO
46	\N	Charlie User	view_audit_dashboard	{'total_logs': 108, 'iam': 57, 'ticketing': 8, 'audit': 43}	2026-05-02 12:55:55.444676	192.168.222.1	\N	\N	\N	INFO
47	\N	Charlie User	logout	{'username': 'Charlie User', 'ip_address': '192.168.222.1'}	2026-05-02 12:56:19.188972	192.168.222.1	\N	\N	\N	INFO
48	\N	Alice Admin	view_audit_dashboard	{'total_logs': 111, 'iam': 57, 'ticketing': 9, 'audit': 45}	2026-05-02 12:57:51.578332	192.168.222.143	\N	\N	\N	INFO
49	\N	Alice Admin	view_audit_dashboard	{'total_logs': 112, 'iam': 57, 'ticketing': 9, 'audit': 46}	2026-05-02 12:57:58.181417	192.168.222.143	\N	\N	\N	INFO
50	\N	Alice Admin	view_audit_dashboard	{'total_logs': 115, 'iam': 57, 'ticketing': 11, 'audit': 47}	2026-05-02 12:58:48.417915	192.168.222.143	\N	\N	\N	INFO
51	\N	Alice Admin	view_audit_dashboard	{'total_logs': 117, 'iam': 57, 'ticketing': 12, 'audit': 48}	2026-05-02 12:59:07.238242	192.168.222.143	\N	\N	\N	INFO
52	\N	Alice Admin	view_audit_dashboard	{'total_logs': 118, 'iam': 57, 'ticketing': 12, 'audit': 49}	2026-05-02 12:59:09.495528	192.168.222.143	\N	\N	\N	INFO
53	\N	Alice Admin	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 12}	2026-05-02 12:59:10.833822	192.168.222.143	\N	\N	\N	INFO
54	\N	unknown	view_audit_dashboard	{'total_logs': 120, 'iam': 57, 'ticketing': 12, 'audit': 51}	2026-05-02 13:04:19.514595	192.168.222.146	\N	\N	\N	INFO
55	\N	unknown	view_audit_dashboard	{'total_logs': 124, 'iam': 57, 'ticketing': 15, 'audit': 52}	2026-05-02 13:34:16.131147	192.168.222.146	\N	\N	\N	INFO
56	\N	unknown	view_audit_dashboard	{'total_logs': 127, 'iam': 57, 'ticketing': 17, 'audit': 53}	2026-05-02 14:14:05.674011	192.168.222.146	\N	\N	\N	INFO
57	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 14:57:46.4191	192.168.222.143	\N	\N	\N	INFO
58	\N	Alice Admin	view_audit_dashboard	{'total_logs': 140, 'iam': 57, 'ticketing': 28, 'audit': 55}	2026-05-02 14:57:46.737226	192.168.222.143	\N	\N	\N	INFO
59	\N	Alice Admin	view_audit_dashboard	{'total_logs': 143, 'iam': 57, 'ticketing': 30, 'audit': 56}	2026-05-02 15:22:08.485708	192.168.222.143	\N	\N	\N	INFO
60	\N	Alice Admin	view_audit_dashboard	{'total_logs': 148, 'iam': 57, 'ticketing': 34, 'audit': 57}	2026-05-02 15:28:27.659795	192.168.222.143	\N	\N	\N	INFO
61	\N	Alice Admin	view_audit_dashboard	{'total_logs': 149, 'iam': 57, 'ticketing': 34, 'audit': 58}	2026-05-02 15:28:41.693665	192.168.222.143	\N	\N	\N	INFO
62	\N	Alice Admin	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 34}	2026-05-02 15:28:43.774766	192.168.222.143	\N	\N	\N	INFO
63	\N	Alice Admin	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 34}	2026-05-02 15:28:50.895266	192.168.222.143	\N	\N	\N	INFO
64	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 15:32:37.455911	192.168.222.1	\N	\N	\N	INFO
65	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 15:37:21.859937	192.168.222.1	\N	\N	\N	INFO
66	\N	Alice Admin	view_audit_dashboard	{'total_logs': 155, 'iam': 57, 'ticketing': 35, 'audit': 63}	2026-05-02 15:37:22.153164	192.168.222.1	\N	\N	\N	INFO
67	\N	Alice Admin	view_audit_dashboard	{'total_logs': 159, 'iam': 57, 'ticketing': 38, 'audit': 64}	2026-05-02 15:37:47.370634	192.168.222.1	\N	\N	\N	INFO
68	\N	Alice Admin	logout	{'username': 'Alice Admin', 'ip_address': '192.168.222.1'}	2026-05-02 15:40:26.680296	192.168.222.1	\N	\N	\N	INFO
69	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 15:41:00.2379	192.168.222.1	\N	\N	\N	INFO
70	\N	Bob Manager	view_audit_dashboard	{'total_logs': 162, 'iam': 57, 'ticketing': 38, 'audit': 67}	2026-05-02 15:41:00.414354	192.168.222.1	\N	\N	\N	INFO
71	\N	Bob Manager	view_audit_dashboard	{'total_logs': 163, 'iam': 57, 'ticketing': 38, 'audit': 68}	2026-05-02 15:41:40.20407	192.168.222.1	\N	\N	\N	INFO
72	\N	Bob Manager	view_audit_dashboard	{'total_logs': 164, 'iam': 57, 'ticketing': 38, 'audit': 69}	2026-05-02 15:51:56.873143	192.168.222.1	\N	\N	\N	INFO
73	\N	Bob Manager	view_audit_dashboard	{'total_logs': 167, 'iam': 57, 'ticketing': 40, 'audit': 70}	2026-05-02 15:52:29.546337	192.168.222.1	\N	\N	\N	INFO
74	\N	Bob Manager	view_audit_dashboard	{'total_logs': 170, 'iam': 57, 'ticketing': 42, 'audit': 71}	2026-05-02 15:52:46.218732	192.168.222.1	\N	\N	\N	INFO
75	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 42}	2026-05-02 15:52:48.733538	192.168.222.1	\N	\N	\N	INFO
76	\N	Bob Manager	view_audit_dashboard	{'total_logs': 172, 'iam': 57, 'ticketing': 42, 'audit': 73}	2026-05-02 15:53:03.668293	192.168.222.1	\N	\N	\N	INFO
77	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 42}	2026-05-02 15:53:06.661756	192.168.222.1	\N	\N	\N	INFO
78	\N	Bob Manager	view_audit_dashboard	{'total_logs': 174, 'iam': 57, 'ticketing': 42, 'audit': 75}	2026-05-02 15:53:16.422555	192.168.222.1	\N	\N	\N	INFO
79	\N	Bob Manager	view_audit_dashboard	{'total_logs': 180, 'iam': 57, 'ticketing': 47, 'audit': 76}	2026-05-02 15:53:46.879446	192.168.222.1	\N	\N	\N	INFO
80	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 47}	2026-05-02 15:53:58.762546	192.168.222.1	\N	\N	\N	INFO
81	\N	Bob Manager	view_audit_dashboard	{'total_logs': 183, 'iam': 57, 'ticketing': 48, 'audit': 78}	2026-05-02 16:18:26.836768	192.168.222.1	\N	\N	\N	INFO
82	\N	Bob Manager	view_audit_dashboard	{'total_logs': 184, 'iam': 57, 'ticketing': 48, 'audit': 79}	2026-05-02 16:18:34.209168	192.168.222.1	\N	\N	\N	INFO
83	\N	Bob Manager	view_audit_dashboard	{'total_logs': 192, 'iam': 64, 'ticketing': 48, 'audit': 80}	2026-05-02 16:25:31.290762	192.168.222.1	\N	\N	\N	INFO
84	\N	Bob Manager	view_audit_dashboard	{'total_logs': 193, 'iam': 64, 'ticketing': 48, 'audit': 81}	2026-05-02 16:25:37.251601	192.168.222.1	\N	\N	\N	INFO
85	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:25:40.626235	192.168.222.1	\N	\N	\N	INFO
86	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:25:46.115013	192.168.222.1	\N	\N	\N	INFO
87	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:25:50.751837	192.168.222.1	\N	\N	\N	INFO
88	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:26:00.090534	192.168.222.1	\N	\N	\N	INFO
89	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:26:17.392515	192.168.222.1	\N	\N	\N	INFO
90	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 48}	2026-05-02 16:26:28.947043	192.168.222.1	\N	\N	\N	INFO
91	\N	Bob Manager	view_audit_dashboard	{'total_logs': 206, 'iam': 70, 'ticketing': 48, 'audit': 88}	2026-05-02 16:32:57.617704	192.168.222.1	\N	\N	\N	INFO
92	\N	Bob Manager	view_audit_dashboard	{'total_logs': 221, 'iam': 83, 'ticketing': 49, 'audit': 89}	2026-05-02 16:35:15.89419	192.168.222.1	\N	\N	\N	INFO
93	\N	Bob Manager	view_audit_dashboard	{'total_logs': 222, 'iam': 83, 'ticketing': 49, 'audit': 90}	2026-05-02 16:35:19.26371	192.168.222.1	\N	\N	\N	INFO
94	\N	Bob Manager	view_audit_dashboard	{'total_logs': 223, 'iam': 83, 'ticketing': 49, 'audit': 91}	2026-05-02 16:35:33.314271	192.168.222.1	\N	\N	\N	INFO
95	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 49}	2026-05-02 16:35:36.444362	192.168.222.1	\N	\N	\N	INFO
96	\N	Bob Manager	view_audit_dashboard	{'total_logs': 225, 'iam': 83, 'ticketing': 49, 'audit': 93}	2026-05-02 16:35:37.537097	192.168.222.1	\N	\N	\N	INFO
97	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 49}	2026-05-02 16:35:45.368585	192.168.222.1	\N	\N	\N	INFO
98	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 49}	2026-05-02 16:42:58.066913	192.168.222.1	\N	\N	\N	INFO
99	\N	Bob Manager	view_audit_dashboard	{'total_logs': 230, 'iam': 84, 'ticketing': 50, 'audit': 96}	2026-05-02 16:43:15.436067	192.168.222.1	\N	\N	\N	INFO
100	\N	Bob Manager	view_audit_dashboard	{'total_logs': 231, 'iam': 84, 'ticketing': 50, 'audit': 97}	2026-05-02 16:43:21.602786	192.168.222.1	\N	\N	\N	INFO
101	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 50}	2026-05-02 16:43:26.392957	192.168.222.1	\N	\N	\N	INFO
102	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 51}	2026-05-02 16:44:00.100373	192.168.222.1	\N	\N	\N	INFO
103	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 51}	2026-05-02 16:44:01.336401	192.168.222.1	\N	\N	\N	INFO
104	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 51}	2026-05-02 16:44:30.04223	192.168.222.1	\N	\N	\N	INFO
105	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 55}	2026-05-02 16:44:42.700377	192.168.222.1	\N	\N	\N	INFO
106	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 55}	2026-05-02 16:44:58.153958	192.168.222.1	\N	\N	\N	INFO
107	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 55}	2026-05-02 16:46:35.452804	192.168.222.1	\N	\N	\N	INFO
108	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 55}	2026-05-02 16:55:20.56837	192.168.222.1	\N	\N	\N	INFO
109	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 55}	2026-05-02 16:58:51.249516	192.168.222.1	\N	\N	\N	INFO
110	\N	Bob Manager	view_audit_dashboard	{'total_logs': 252, 'iam': 90, 'ticketing': 55, 'audit': 107}	2026-05-02 16:59:03.771857	192.168.222.1	\N	\N	\N	INFO
111	\N	Bob Manager	view_audit_dashboard	{'total_logs': 253, 'iam': 90, 'ticketing': 55, 'audit': 108}	2026-05-02 16:59:08.030933	192.168.222.1	\N	\N	\N	INFO
112	\N	Bob Manager	view_audit_dashboard	{'total_logs': 258, 'iam': 94, 'ticketing': 55, 'audit': 109}	2026-05-02 16:59:27.119956	192.168.222.1	\N	\N	\N	INFO
113	\N	Bob Manager	view_audit_dashboard	{'total_logs': 259, 'iam': 94, 'ticketing': 55, 'audit': 110}	2026-05-02 16:59:31.195282	192.168.222.1	\N	\N	\N	INFO
114	\N	Bob Manager	view_audit_dashboard	{'total_logs': 260, 'iam': 94, 'ticketing': 55, 'audit': 111}	2026-05-02 16:59:31.531963	192.168.222.1	\N	\N	\N	INFO
115	\N	Bob Manager	view_audit_dashboard	{'total_logs': 261, 'iam': 94, 'ticketing': 55, 'audit': 112}	2026-05-02 16:59:32.338637	192.168.222.1	\N	\N	\N	INFO
116	\N	Bob Manager	view_audit_dashboard	{'total_logs': 262, 'iam': 94, 'ticketing': 55, 'audit': 113}	2026-05-02 16:59:32.58461	192.168.222.1	\N	\N	\N	INFO
117	\N	Bob Manager	view_audit_dashboard	{'total_logs': 263, 'iam': 94, 'ticketing': 55, 'audit': 114}	2026-05-02 16:59:33.008653	192.168.222.1	\N	\N	\N	INFO
118	\N	Bob Manager	view_audit_dashboard	{'total_logs': 264, 'iam': 94, 'ticketing': 55, 'audit': 115}	2026-05-02 16:59:33.234947	192.168.222.1	\N	\N	\N	INFO
119	\N	Bob Manager	view_audit_dashboard	{'total_logs': 265, 'iam': 94, 'ticketing': 55, 'audit': 116}	2026-05-02 16:59:33.553362	192.168.222.1	\N	\N	\N	INFO
120	\N	Bob Manager	view_audit_dashboard	{'total_logs': 266, 'iam': 94, 'ticketing': 55, 'audit': 117}	2026-05-02 16:59:33.784735	192.168.222.1	\N	\N	\N	INFO
121	\N	Bob Manager	view_audit_dashboard	{'total_logs': 267, 'iam': 94, 'ticketing': 55, 'audit': 118}	2026-05-02 17:03:52.678285	192.168.222.1	\N	\N	\N	INFO
122	\N	Bob Manager	view_audit_dashboard	{'total_logs': 273, 'iam': 98, 'ticketing': 56, 'audit': 119}	2026-05-02 17:04:08.237475	192.168.222.1	\N	\N	\N	INFO
123	\N	Bob Manager	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:04:44.864625	192.168.222.1	\N	\N	\N	INFO
124	\N	Bob Manager	logout	{'username': 'Bob Manager', 'ip_address': '192.168.222.1'}	2026-05-02 17:06:40.997017	192.168.222.1	\N	\N	\N	INFO
125	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:09:28.667973	192.168.222.1	\N	\N	\N	INFO
126	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:09:32.869321	192.168.222.1	\N	\N	\N	INFO
127	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:45.438931	192.168.222.1	\N	\N	\N	INFO
128	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:49.697	192.168.222.1	\N	\N	\N	INFO
129	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:55.936428	192.168.222.1	\N	\N	\N	INFO
130	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:56.152271	192.168.222.1	\N	\N	\N	INFO
131	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:56.551375	192.168.222.1	\N	\N	\N	INFO
132	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:09:58.486304	192.168.222.1	\N	\N	\N	INFO
133	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:10:03.172299	192.168.222.1	\N	\N	\N	INFO
134	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:10:10.381833	192.168.222.1	\N	\N	\N	INFO
135	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:10:34.631271	192.168.222.1	\N	\N	\N	INFO
136	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:12:27.103448	192.168.222.1	\N	\N	\N	INFO
137	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:12:41.119531	192.168.222.1	\N	\N	\N	INFO
138	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:12:46.829921	192.168.222.1	\N	\N	\N	INFO
139	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:16:25.954929	192.168.222.1	\N	\N	\N	INFO
140	\N	unknown	view_audit_dashboard	{'total_logs': 299, 'iam': 103, 'ticketing': 59, 'audit': 137}	2026-05-02 17:17:14.276103	192.168.222.1	\N	\N	\N	INFO
141	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:19:58.299247	192.168.222.1	\N	\N	\N	INFO
142	\N	unknown	view_audit_dashboard	{'total_logs': 306, 'iam': 106, 'ticketing': 61, 'audit': 139}	2026-05-02 17:21:45.715938	192.168.222.1	\N	\N	\N	INFO
143	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:21:57.364528	192.168.222.1	\N	\N	\N	INFO
144	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:22:06.320799	192.168.222.1	\N	\N	\N	INFO
145	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:22:12.130309	192.168.222.1	\N	\N	\N	INFO
146	\N	unknown	view_audit_dashboard	{'total_logs': 310, 'iam': 106, 'ticketing': 61, 'audit': 143}	2026-05-02 17:25:22.776106	192.168.222.1	\N	\N	\N	INFO
147	\N	unknown	view_audit_dashboard	{'total_logs': 313, 'iam': 107, 'ticketing': 62, 'audit': 144}	2026-05-02 17:25:29.943214	192.168.222.1	\N	\N	\N	INFO
148	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:25:36.670591	192.168.222.1	\N	\N	\N	INFO
149	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 17:25:58.228613	192.168.222.1	\N	\N	\N	INFO
150	\N	unknown	view_all_logs	{'filters': {'source': 'all'}, 'count': 200}	2026-05-02 17:30:29.729008	192.168.222.1	\N	\N	\N	INFO
151	\N	unknown	view_all_logs	{'filters': {'source': 'all'}, 'count': 200}	2026-05-02 17:30:41.086826	192.168.222.1	\N	\N	\N	INFO
152	\N	unknown	view_all_logs	{'filters': {'source': 'App Audit'}, 'count': 22}	2026-05-02 17:31:00.566206	192.168.222.1	\N	\N	\N	INFO
153	\N	unknown	view_all_logs	{'filters': {'source': 'App Audit'}, 'count': 22}	2026-05-02 17:34:18.729583	192.168.222.1	\N	\N	\N	INFO
154	\N	unknown	view_all_logs	{'filters': {'source': 'App Audit'}, 'count': 22}	2026-05-02 17:34:25.355084	192.168.222.1	\N	\N	\N	INFO
155	\N	unknown	view_all_logs	{'filters': {'source': 'App Audit'}, 'count': 22}	2026-05-02 17:34:25.833268	192.168.222.1	\N	\N	\N	INFO
156	\N	unknown	view_all_logs	{'filters': {'source': 'App Audit'}, 'count': 22}	2026-05-02 17:34:26.115091	192.168.222.1	\N	\N	\N	INFO
157	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:34:26.965006	192.168.222.1	\N	\N	\N	INFO
158	\N	unknown	view_audit_dashboard	{'total_logs': 324, 'iam': 107, 'ticketing': 62, 'audit': 155}	2026-05-02 17:34:27.140831	192.168.222.1	\N	\N	\N	INFO
159	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:34:38.450523	192.168.222.1	\N	\N	\N	INFO
160	\N	unknown	view_audit_dashboard	{'total_logs': 326, 'iam': 107, 'ticketing': 62, 'audit': 157}	2026-05-02 17:34:38.671926	192.168.222.1	\N	\N	\N	INFO
161	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:35:33.083267	192.168.222.1	\N	\N	\N	INFO
162	\N	unknown	view_audit_dashboard	{'total_logs': 332, 'iam': 109, 'ticketing': 64, 'audit': 159}	2026-05-02 17:35:40.849242	192.168.222.1	\N	\N	\N	INFO
163	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:43:48.818432	192.168.222.1	\N	\N	\N	INFO
164	\N	unknown	view_audit_dashboard	{'total_logs': 334, 'iam': 109, 'ticketing': 64, 'audit': 161}	2026-05-02 17:43:49.030176	192.168.222.1	\N	\N	\N	INFO
165	\N	unknown	view_audit_dashboard	{'total_logs': 335, 'iam': 109, 'ticketing': 64, 'audit': 162}	2026-05-02 17:43:49.602277	192.168.222.1	\N	\N	\N	INFO
166	\N	unknown	view_audit_dashboard	{'total_logs': 336, 'iam': 109, 'ticketing': 64, 'audit': 163}	2026-05-02 17:43:56.040116	192.168.222.1	\N	\N	\N	INFO
167	\N	unknown	view_audit_dashboard	{'total_logs': 345, 'iam': 114, 'ticketing': 67, 'audit': 164}	2026-05-02 17:47:40.304016	192.168.222.1	\N	\N	\N	INFO
168	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 17:55:03.268763	192.168.222.1	\N	\N	\N	INFO
169	\N	unknown	view_audit_dashboard	{'total_logs': 355, 'iam': 114, 'ticketing': 75, 'audit': 166}	2026-05-02 17:55:24.274036	192.168.222.1	\N	\N	\N	INFO
170	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:00:29.666797	192.168.222.1	\N	\N	\N	INFO
171	\N	unknown	view_audit_dashboard	{'total_logs': 360, 'iam': 114, 'ticketing': 78, 'audit': 168}	2026-05-02 18:00:29.846963	192.168.222.1	\N	\N	\N	INFO
172	\N	unknown	view_all_logs	{'filters': {'source': 'all'}, 'count': 200}	2026-05-02 18:00:37.944115	192.168.222.1	\N	\N	\N	INFO
173	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:04:11.17354	192.168.222.1	\N	\N	\N	INFO
174	\N	unknown	view_audit_dashboard	{'total_logs': 363, 'iam': 114, 'ticketing': 78, 'audit': 171}	2026-05-02 18:04:11.3634	192.168.222.1	\N	\N	\N	INFO
175	\N	unknown	view_audit_dashboard	{'total_logs': 364, 'iam': 114, 'ticketing': 78, 'audit': 172}	2026-05-02 18:04:31.588774	192.168.222.1	\N	\N	\N	INFO
176	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:25:42.716634	192.168.222.1	\N	\N	\N	INFO
177	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:26:08.003015	192.168.222.1	\N	\N	\N	INFO
178	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:26:13.261841	192.168.222.1	\N	\N	\N	INFO
179	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:32.625966	192.168.222.1	\N	\N	\N	INFO
180	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:39.252761	192.168.222.1	\N	\N	\N	INFO
181	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:46.905783	192.168.222.1	\N	\N	\N	INFO
182	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:47.270419	192.168.222.1	\N	\N	\N	INFO
183	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:47.512297	192.168.222.1	\N	\N	\N	INFO
184	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:48.841995	192.168.222.1	\N	\N	\N	INFO
185	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:48.966298	192.168.222.1	\N	\N	\N	INFO
186	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:49.083507	192.168.222.1	\N	\N	\N	INFO
187	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:52.055044	192.168.222.1	\N	\N	\N	INFO
188	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:52.184024	192.168.222.1	\N	\N	\N	INFO
189	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:52.424848	192.168.222.1	\N	\N	\N	INFO
190	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:53.673087	192.168.222.1	\N	\N	\N	INFO
191	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:53.810502	192.168.222.1	\N	\N	\N	INFO
192	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:54.044274	192.168.222.1	\N	\N	\N	INFO
193	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:54.173393	192.168.222.1	\N	\N	\N	INFO
194	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:54.93063	192.168.222.1	\N	\N	\N	INFO
195	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:55.054232	192.168.222.1	\N	\N	\N	INFO
196	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:55.179112	192.168.222.1	\N	\N	\N	INFO
197	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:55.405797	192.168.222.1	\N	\N	\N	INFO
198	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:56.278499	192.168.222.1	\N	\N	\N	INFO
199	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:56.459689	192.168.222.1	\N	\N	\N	INFO
200	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:56.732598	192.168.222.1	\N	\N	\N	INFO
201	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:56.911252	192.168.222.1	\N	\N	\N	INFO
202	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:58.859175	192.168.222.1	\N	\N	\N	INFO
203	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:58.991828	192.168.222.1	\N	\N	\N	INFO
204	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:41:59.107549	192.168.222.1	\N	\N	\N	INFO
205	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:00.028812	192.168.222.1	\N	\N	\N	INFO
206	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:00.14311	192.168.222.1	\N	\N	\N	INFO
207	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:00.257712	192.168.222.1	\N	\N	\N	INFO
208	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:01.221153	192.168.222.1	\N	\N	\N	INFO
209	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:01.352414	192.168.222.1	\N	\N	\N	INFO
210	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:01.57619	192.168.222.1	\N	\N	\N	INFO
211	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:01.986363	192.168.222.1	\N	\N	\N	INFO
212	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:03.939047	192.168.222.1	\N	\N	\N	INFO
213	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:04.16558	192.168.222.1	\N	\N	\N	INFO
214	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:04.28302	192.168.222.1	\N	\N	\N	INFO
215	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:05.480811	192.168.222.1	\N	\N	\N	INFO
216	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:05.713201	192.168.222.1	\N	\N	\N	INFO
217	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:42:05.832926	192.168.222.1	\N	\N	\N	INFO
218	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:03.392627	192.168.222.1	\N	\N	\N	INFO
219	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:03.513518	192.168.222.1	\N	\N	\N	INFO
220	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:03.629235	192.168.222.1	\N	\N	\N	INFO
221	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:03.848321	192.168.222.1	\N	\N	\N	INFO
222	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:05.03426	192.168.222.1	\N	\N	\N	INFO
223	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:05.146739	192.168.222.1	\N	\N	\N	INFO
224	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:05.265326	192.168.222.1	\N	\N	\N	INFO
225	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:05.50048	192.168.222.1	\N	\N	\N	INFO
226	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:10.794733	192.168.222.1	\N	\N	\N	INFO
227	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:10.928467	192.168.222.1	\N	\N	\N	INFO
228	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:11.325254	192.168.222.1	\N	\N	\N	INFO
229	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:11.988544	192.168.222.1	\N	\N	\N	INFO
230	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:12.110735	192.168.222.1	\N	\N	\N	INFO
231	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 18:43:12.339247	192.168.222.1	\N	\N	\N	INFO
232	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:15:31.290944	127.0.0.1	\N	\N	\N	INFO
233	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:15:32.098893	172.18.0.11	\N	\N	\N	INFO
234	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:17:23.022366	192.168.222.146	\N	\N	\N	INFO
235	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:19:41.138399	192.168.222.1	\N	\N	\N	INFO
236	\N	unknown	view_audit_dashboard	{'total_logs': 486, 'iam': 114, 'ticketing': 139, 'audit': 233}	2026-05-02 19:19:41.295057	192.168.222.1	\N	\N	\N	INFO
237	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:19:44.086838	192.168.222.1	\N	\N	\N	INFO
238	\N	unknown	view_audit_dashboard	{'total_logs': 488, 'iam': 114, 'ticketing': 139, 'audit': 235}	2026-05-02 19:19:58.386949	192.168.222.1	\N	\N	\N	INFO
239	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:20:06.166278	192.168.222.1	\N	\N	\N	INFO
240	\N	unknown	view_audit_dashboard	{'total_logs': 490, 'iam': 114, 'ticketing': 139, 'audit': 237}	2026-05-02 19:20:06.499905	192.168.222.1	\N	\N	\N	INFO
241	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:20:11.652791	192.168.222.1	\N	\N	\N	INFO
242	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:20:25.53115	192.168.222.1	\N	\N	\N	INFO
243	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:20:25.804469	192.168.222.1	\N	\N	\N	INFO
244	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:20:26.145068	192.168.222.1	\N	\N	\N	INFO
245	\N	unknown	view_audit_dashboard	{'total_logs': 495, 'iam': 114, 'ticketing': 139, 'audit': 242}	2026-05-02 19:20:28.929438	192.168.222.1	\N	\N	\N	INFO
246	\N	unknown	view_audit_dashboard	{'total_logs': 496, 'iam': 114, 'ticketing': 139, 'audit': 243}	2026-05-02 19:20:29.172687	192.168.222.1	\N	\N	\N	INFO
247	\N	unknown	view_audit_dashboard	{'total_logs': 497, 'iam': 114, 'ticketing': 139, 'audit': 244}	2026-05-02 19:20:29.551007	192.168.222.1	\N	\N	\N	INFO
248	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 19:24:02.379264	192.168.222.1	\N	\N	\N	INFO
249	\N	unknown	view_audit_dashboard	{'total_logs': 499, 'iam': 114, 'ticketing': 139, 'audit': 246}	2026-05-02 19:24:10.151257	192.168.222.1	\N	\N	\N	INFO
250	\N	unknown	view_audit_dashboard	{'total_logs': 500, 'iam': 114, 'ticketing': 139, 'audit': 247}	2026-05-02 19:24:15.272345	192.168.222.1	\N	\N	\N	INFO
251	\N	unknown	view_audit_dashboard	{'total_logs': 501, 'iam': 114, 'ticketing': 139, 'audit': 248}	2026-05-02 19:24:15.513304	192.168.222.1	\N	\N	\N	INFO
252	\N	unknown	view_audit_dashboard	{'total_logs': 502, 'iam': 114, 'ticketing': 139, 'audit': 249}	2026-05-02 19:24:15.819519	192.168.222.1	\N	\N	\N	INFO
253	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:24:17.697104	192.168.222.1	\N	\N	\N	INFO
254	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 139}	2026-05-02 19:24:26.85835	192.168.222.1	\N	\N	\N	INFO
255	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 20:08:23.493175	192.168.222.1	\N	\N	\N	INFO
256	\N	unknown	view_audit_dashboard	{'total_logs': 508, 'iam': 114, 'ticketing': 141, 'audit': 253}	2026-05-02 20:08:23.650537	192.168.222.1	\N	\N	\N	INFO
257	\N	unknown	view_audit_dashboard	{'total_logs': 510, 'iam': 114, 'ticketing': 142, 'audit': 254}	2026-05-02 20:09:09.600014	192.168.222.1	\N	\N	\N	INFO
258	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 20:11:42.900512	192.168.222.1	\N	\N	\N	INFO
259	\N	unknown	view_audit_dashboard	{'total_logs': 512, 'iam': 114, 'ticketing': 142, 'audit': 256}	2026-05-02 20:11:43.07482	192.168.222.1	\N	\N	\N	INFO
260	\N	unknown	view_audit_dashboard	{'total_logs': 520, 'iam': 114, 'ticketing': 149, 'audit': 257}	2026-05-02 20:12:59.971629	192.168.222.1	\N	\N	\N	INFO
261	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 20:13:02.271158	192.168.222.1	\N	\N	\N	INFO
262	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 20:35:03.218185	192.168.222.1	\N	\N	\N	INFO
263	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 20:35:05.357111	192.168.222.1	\N	\N	\N	INFO
264	\N	unknown	view_all_logs	{'filters': {'source': 'App Ticketing', 'action': 'view_all_logs'}, 'count': 0}	2026-05-02 20:35:17.740956	192.168.222.1	\N	\N	\N	INFO
265	\N	unknown	view_all_logs	{'filters': {'source': 'App Ticketing', 'action': 'view_all_logs'}, 'count': 0}	2026-05-02 20:35:24.056509	192.168.222.1	\N	\N	\N	INFO
266	\N	unknown	view_all_logs	{'filters': {'source': 'App Ticketing', 'action': 'all'}, 'count': 151}	2026-05-02 20:35:53.002278	192.168.222.1	\N	\N	\N	INFO
267	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 20:35:57.993679	192.168.222.1	\N	\N	\N	INFO
268	\N	unknown	view_all_logs	{'filters': {'source': 'App IAM', 'action': 'all'}, 'count': 114}	2026-05-02 20:36:02.90253	192.168.222.1	\N	\N	\N	INFO
269	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 20:36:07.640082	192.168.222.1	\N	\N	\N	INFO
270	\N	unknown	view_audit_dashboard	{'total_logs': 532, 'iam': 114, 'ticketing': 151, 'audit': 267}	2026-05-02 20:36:10.828482	192.168.222.1	\N	\N	\N	INFO
271	\N	unknown	view_audit_dashboard	{'total_logs': 535, 'iam': 114, 'ticketing': 153, 'audit': 268}	2026-05-02 20:36:49.509638	192.168.222.1	\N	\N	\N	INFO
272	\N	unknown	logout	{'username': 'alice', 'ip_address': '192.168.222.1'}	2026-05-02 20:37:18.60947	192.168.222.1	\N	\N	\N	INFO
273	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 20:37:18.655945	192.168.222.1	\N	\N	\N	INFO
274	\N	unknown	view_audit_dashboard	{'total_logs': 542, 'iam': 114, 'ticketing': 157, 'audit': 271}	2026-05-02 20:43:48.431886	192.168.222.1	\N	\N	\N	INFO
275	\N	unknown	view_audit_dashboard	{'total_logs': 543, 'iam': 114, 'ticketing': 157, 'audit': 272}	2026-05-02 20:43:52.787505	192.168.222.1	\N	\N	\N	INFO
276	\N	unknown	view_all_logs	{'filters': {'source': 'all', 'action': 'all'}, 'count': 200}	2026-05-02 20:43:54.692959	192.168.222.1	\N	\N	\N	INFO
277	\N	unknown	view_audit_dashboard	{'total_logs': 545, 'iam': 114, 'ticketing': 157, 'audit': 274}	2026-05-02 20:43:57.991967	192.168.222.1	\N	\N	\N	INFO
278	\N	unknown	view_audit_dashboard	{'total_logs': 554, 'iam': 114, 'ticketing': 165, 'audit': 275}	2026-05-02 20:48:23.489702	192.168.222.1	\N	\N	\N	INFO
279	\N	unknown	view_audit_dashboard	{'total_logs': 555, 'iam': 114, 'ticketing': 165, 'audit': 276}	2026-05-02 20:48:23.816407	192.168.222.1	\N	\N	\N	INFO
280	\N	unknown	view_audit_dashboard	{'total_logs': 556, 'iam': 114, 'ticketing': 165, 'audit': 277}	2026-05-02 20:48:24.529744	192.168.222.1	\N	\N	\N	INFO
281	\N	unknown	view_audit_dashboard	{'total_logs': 557, 'iam': 114, 'ticketing': 165, 'audit': 278}	2026-05-02 20:48:24.856633	192.168.222.1	\N	\N	\N	INFO
282	\N	unknown	view_audit_dashboard	{'total_logs': 558, 'iam': 114, 'ticketing': 165, 'audit': 279}	2026-05-02 20:48:25.166077	192.168.222.1	\N	\N	\N	INFO
283	\N	unknown	view_audit_dashboard	{'total_logs': 559, 'iam': 114, 'ticketing': 165, 'audit': 280}	2026-05-02 20:48:25.517317	192.168.222.1	\N	\N	\N	INFO
284	\N	unknown	view_audit_dashboard	{'total_logs': 561, 'iam': 114, 'ticketing': 166, 'audit': 281}	2026-05-02 20:48:33.898752	192.168.222.1	\N	\N	\N	INFO
285	\N	unknown	view_audit_dashboard	{'total_logs': 567, 'iam': 115, 'ticketing': 170, 'audit': 282}	2026-05-02 20:52:27.012051	192.168.222.1	\N	\N	\N	INFO
286	\N	unknown	view_audit_dashboard	{'total_logs': 568, 'iam': 115, 'ticketing': 170, 'audit': 283}	2026-05-02 20:53:11.894982	192.168.222.1	\N	\N	\N	INFO
287	\N	unknown	view_audit_dashboard	{'total_logs': 569, 'iam': 115, 'ticketing': 170, 'audit': 284}	2026-05-02 20:53:21.259216	192.168.222.1	\N	\N	\N	INFO
288	\N	unknown	view_audit_dashboard	{'total_logs': 570, 'iam': 115, 'ticketing': 170, 'audit': 285}	2026-05-02 20:53:36.869741	192.168.222.1	\N	\N	\N	INFO
289	\N	unknown	view_audit_dashboard	{'total_logs': 571, 'iam': 115, 'ticketing': 170, 'audit': 286}	2026-05-02 20:54:02.900972	192.168.222.1	\N	\N	\N	INFO
290	\N	unknown	view_audit_dashboard	{'total_logs': 572, 'iam': 115, 'ticketing': 170, 'audit': 287}	2026-05-02 20:54:04.134389	192.168.222.1	\N	\N	\N	INFO
291	\N	unknown	view_audit_dashboard	{'total_logs': 573, 'iam': 115, 'ticketing': 170, 'audit': 288}	2026-05-02 20:54:04.59257	192.168.222.1	\N	\N	\N	INFO
292	\N	unknown	view_audit_dashboard	{'total_logs': 576, 'iam': 115, 'ticketing': 172, 'audit': 289}	2026-05-02 20:54:23.607017	192.168.222.1	\N	\N	\N	INFO
293	\N	unknown	view_audit_dashboard	{'total_logs': 577, 'iam': 115, 'ticketing': 172, 'audit': 290}	2026-05-02 20:54:27.183112	192.168.222.1	\N	\N	\N	INFO
294	\N	unknown	view_audit_dashboard	{'total_logs': 578, 'iam': 115, 'ticketing': 172, 'audit': 291}	2026-05-02 20:54:34.857395	192.168.222.1	\N	\N	\N	INFO
295	\N	unknown	view_audit_dashboard	{'total_logs': 581, 'iam': 115, 'ticketing': 174, 'audit': 292}	2026-05-02 21:03:54.56744	192.168.222.1	\N	\N	\N	INFO
296	\N	unknown	view_audit_dashboard	{'total_logs': 582, 'iam': 115, 'ticketing': 174, 'audit': 293}	2026-05-02 21:03:58.640422	192.168.222.1	\N	\N	\N	INFO
297	\N	unknown	view_audit_dashboard	{'total_logs': 585, 'iam': 117, 'ticketing': 174, 'audit': 294}	2026-05-02 21:09:27.095587	192.168.222.1	\N	\N	\N	INFO
298	\N	unknown	view_audit_dashboard	{'total_logs': 591, 'iam': 120, 'ticketing': 176, 'audit': 295}	2026-05-02 21:33:46.440058	192.168.222.1	\N	\N	\N	INFO
299	\N	unknown	view_audit_dashboard	{'total_logs': 592, 'iam': 120, 'ticketing': 176, 'audit': 296}	2026-05-02 21:33:47.688789	192.168.222.1	\N	\N	\N	INFO
300	\N	unknown	view_audit_dashboard	{'total_logs': 596, 'iam': 123, 'ticketing': 176, 'audit': 297}	2026-05-02 21:34:04.863447	192.168.222.1	\N	\N	\N	INFO
301	\N	unknown	logout	{'username': 'charlie', 'ip_address': '192.168.222.1'}	2026-05-02 21:34:36.201405	192.168.222.1	\N	\N	\N	INFO
302	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 21:34:36.254151	192.168.222.1	\N	\N	\N	INFO
303	\N	unknown	login_attempt	{'page': 'login'}	2026-05-02 21:34:43.98755	192.168.222.1	\N	\N	\N	INFO
304	\N	unknown	view_audit_dashboard	{'total_logs': 601, 'iam': 123, 'ticketing': 177, 'audit': 301}	2026-05-02 21:34:55.198641	192.168.222.1	\N	\N	\N	INFO
305	\N	unknown	view_audit_dashboard	{'total_logs': 603, 'iam': 123, 'ticketing': 178, 'audit': 302}	2026-05-02 21:34:57.363585	192.168.222.1	\N	\N	\N	INFO
306	\N	unknown	view_audit_dashboard	{'total_logs': 610, 'iam': 128, 'ticketing': 179, 'audit': 303}	2026-05-02 21:35:19.435534	192.168.222.1	\N	\N	\N	INFO
307	\N	unknown	view_audit_dashboard	{'total_logs': 611, 'iam': 128, 'ticketing': 179, 'audit': 304}	2026-05-02 21:35:37.217934	192.168.222.1	\N	\N	\N	INFO
308	\N	charlie	view_audit_dashboard	{'total_logs': 620, 'iam': 135, 'ticketing': 180, 'audit': 305}	2026-05-02 21:39:01.678964	192.168.222.1	\N	\N	\N	INFO
309	\N	charlie	view_audit_dashboard	{'total_logs': 621, 'iam': 135, 'ticketing': 180, 'audit': 306}	2026-05-02 21:39:07.590986	192.168.222.1	\N	\N	\N	INFO
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.users (id, keycloak_id, username, email, created_at) FROM stdin;
1	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	charlie@pfe.local	2026-05-01 01:55:43.04987
2	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	bob@pfe.local	2026-05-01 12:57:43.44163
3	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	alice@pfe.local	2026-05-01 13:48:40.03036
\.


--
-- Name: action_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.action_logs_id_seq', 309, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: action_logs action_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.action_logs
    ADD CONSTRAINT action_logs_pkey PRIMARY KEY (id);


--
-- Name: users users_keycloak_id_key; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_keycloak_id_key UNIQUE (keycloak_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_action_logs_hour; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_action_logs_hour ON public.action_logs USING btree (hour_of_day);


--
-- Name: idx_action_logs_timestamp; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_action_logs_timestamp ON public.action_logs USING btree ("timestamp");


--
-- Name: idx_action_logs_username; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_action_logs_username ON public.action_logs USING btree (username);


--
-- Name: idx_logs_action; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_logs_action ON public.action_logs USING btree (action);


--
-- Name: idx_logs_time; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_logs_time ON public.action_logs USING btree ("timestamp");


--
-- Name: idx_logs_user; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_logs_user ON public.action_logs USING btree (username);


--
-- PostgreSQL database dump complete
--

\unrestrict k89uqnQXP6MBO8AZwCviAvexiMgaDKZeyoWZtXf3VJLr0vJedZKj6OIJPv5D9dg

--
-- Database "iam_db" dump
--

--
-- PostgreSQL database dump
--

\restrict VTx8tNoBJm9Qf4RWRnJuo9qkuZBZgnPh1QmZK1xMbF70KsatiRNVN2xmBZtyooe

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: iam_db; Type: DATABASE; Schema: -; Owner: pfe
--

CREATE DATABASE iam_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE iam_db OWNER TO pfe;

\unrestrict VTx8tNoBJm9Qf4RWRnJuo9qkuZBZgnPh1QmZK1xMbF70KsatiRNVN2xmBZtyooe
\connect iam_db
\restrict VTx8tNoBJm9Qf4RWRnJuo9qkuZBZgnPh1QmZK1xMbF70KsatiRNVN2xmBZtyooe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.audit_log (
    id integer NOT NULL,
    keycloak_id character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    action character varying(100) NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now(),
    ip_address character varying(45),
    user_agent character varying(512),
    hour_of_day integer,
    session_id character varying(128),
    details text
);


ALTER TABLE public.audit_log OWNER TO pfe;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.audit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_log_id_seq OWNER TO pfe;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);


ALTER TABLE public.roles OWNER TO pfe;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO pfe;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.users (
    id integer NOT NULL,
    keycloak_id character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    role character varying(50) DEFAULT 'user'::character varying
);


ALTER TABLE public.users OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.audit_log (id, keycloak_id, username, action, "timestamp", ip_address, user_agent, hour_of_day, session_id, details) FROM stdin;
1	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN	2026-04-30 21:48:19.864073	172.18.0.13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	\N
2	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-04-30 21:48:19.89218	172.18.0.13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	\N
3	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_PROFILE	2026-04-30 21:48:41.553628	172.18.0.13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	\N
4	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-04-30 21:48:43.776807	172.18.0.13	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	\N
5	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 01:55:53.048081	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	\N
6	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 01:56:04.456608	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJzFlVuPqzgSx7_KKs-TkYFA0udpcyNxGpuGAMZerVrcEi52kg4kXEbz3dfknDnzMtqR9mWfQHYVVfWvqh-_TaIkyer6s7lW2WX	\N
7	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN	2026-05-01 10:00:11.435098	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	\N
8	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 10:00:11.466551	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
9	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 10:00:20.821545	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
10	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_PROFILE	2026-05-01 10:00:22.426292	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
11	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 10:00:24.152768	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
12	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 10:08:59.167642	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
13	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 10:21:24.013129	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
14	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 12:07:47.493403	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
15	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN	2026-05-01 12:56:16.958785	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	\N
16	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 12:56:16.979272	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
17	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_PROFILE	2026-05-01 12:56:29.985474	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
18	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_USERS_LIST	2026-05-01 12:56:33.617882	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
19	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	LOGIN	2026-05-01 12:58:17.371112	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	\N
20	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD	2026-05-01 12:58:17.394984	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVGuvozgS_SurfJ7b4pkb-tMkIRBzwTThYcxq1eKVYDCE3JAHjOa_b5Fu7Wik0Y5Wq3wwseu4yqdOnd8WaZ6X1-v34dyU3eL	\N
21	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_USERS_LIST	2026-05-01 12:58:20.02892	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVGuvozgS_SurfJ7b4pkb-tMkIRBzwTThYcxq1eKVYDCE3JAHjOa_b5Fu7Wik0Y5Wq3wwseu4yqdOnd8WaZ6X1-v34dyU3eL	\N
22	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 13:11:54.371749	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
23	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 13:45:10.628989	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
24	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN	2026-05-01 13:45:31.541112	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	none	\N
25	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 13:45:31.561847	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVFuPs0YS_SuRn-NPXIxn-J7WhgEa081gc-1VNOJmczdjbG5R_vsWni_ZfYgSRftgtVX06ao6p-r8ugrjOO26j_u1TJvV91U	\N
52	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN	2026-05-02 08:58:11.127371	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	none	\N
26	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 13:45:42.506116	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVFuPs0YS_SuRn-NPXIxn-J7WhgEa081gc-1VNOJmczdjbG5R_vsWni_ZfYgSRftgtVX06ao6p-r8ugrjOO26j_u1TJvV91U	\N
27	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	VIEW_DASHBOARD	2026-05-01 13:46:34.439331	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVGuvozgS_SurfJ7b4pkb-tMkIRBzwTThYcxq1eKVYDCE3JAHjOa_b5Fu7Wik0Y5Wq3wwseu4yqdOnd8WaZ6X1-v34dyU3eL	\N
28	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 13:47:03.648806	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJylVFuTozYT_SspP2e2uHrMPsUXYMQgMDYgpK9SLhBgEBd7BmwDqfz3CO9WkoetpCrfE1RLR919us_5bRFTmnXdqb9UWbv4ush	\N
29	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 13:48:52.748217	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVFuPs0YS_SuRn-NPXIxn-J7WhgEa081gc-1VNOJmczdjbG5R_vsWni_ZfYgSRftgtVX06ao6p-r8ugrjOO26j_u1TJvV91U	\N
30	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 13:49:16.776524	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVFuPs0YS_SuRn-NPXIxn-J7WhgEa081gc-1VNOJmczdjbG5R_vsWni_ZfYgSRftgtVX06ao6p-r8ugrjOO26j_u1TJvV91U	\N
31	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN	2026-05-01 17:38:20.451851	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	none	\N
32	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 17:38:20.480531	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVF2vo7YW_StXeW5GfCZhnsqBQMzBMCGAgeoqAkOCwZCcAwkfVf97TTpq78PoVmofkNG2l9fey3uvX1cpxkXXnftbXbSrr6t	\N
33	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_PROFILE	2026-05-01 17:38:43.936383	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVF2vo7YW_StXeW5GfCZhnsqBQMzBMCGAgeoqAkOCwZCcAwkfVf97TTpq78PoVmofkNG2l9fey3uvX1cpxkXXnftbXbSrr6t	\N
34	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 17:38:45.987453	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVF2vo7YW_StXeW5GfCZhnsqBQMzBMCGAgeoqAkOCwZCcAwkfVf97TTpq78PoVmofkNG2l9fey3uvX1cpxkXXnftbXbSrr6t	\N
35	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 17:51:14.081556	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVF2vo7YW_StXeW5GfCZhnsqBQMzBMCGAgeoqAkOCwZCcAwkfVf97TTpq78PoVmofkNG2l9fey3uvX1cpxkXXnftbXbSrr6t	\N
36	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGIN	2026-05-01 19:23:36.412991	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	none	\N
37	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 19:23:36.4372	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJyllduyqkgShl9lwut2BwfR5b4aPKDFosotAmXVxITBSaEsFEXl0NHvPolrd89cdExHzFxJFPWTmX9mfv46COM4rarD43pOL4P	\N
38	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	LOGOUT	2026-05-01 19:24:14.041696	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	.eJyllduyqkgShl9lwut2BwfR5b4aPKDFosotAmXVxITBSaEsFEXl0NHvPolrd89cdExHzFxJFPWTmX9mfv46COM4rarD43pOL4P	\N
39	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-01 21:35:27.932189	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJyllNmuo0gShl-l5et2icXYx3U1GAwkB5JiJ7PVOmKzWRJM2WCWVr_7JD7VPSPNaFqavrKV5J8R8UfE99smTtP88fjob3Xebr5	\N
40	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN	2026-05-01 21:47:57.242551	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	\N
41	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 21:48:08.68904	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
42	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 21:55:09.353948	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
43	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 22:12:24.595553	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
44	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 22:24:14.417623	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
45	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 22:25:11.008411	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
46	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-01 22:29:22.599874	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
47	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_PROFILE	2026-05-01 22:29:25.067399	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
48	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_USERS_LIST	2026-05-01 22:29:29.819617	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVFmvqzYX_StVnpsrxiTcp5IBYg6GEyZjPlVHTEkwhuQEwlT1v9fkXrV9uGqlfk-gbW-vtYe1flvEaZo3zUd7K_N68XWRj8Y	\N
49	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	LOGIN	2026-05-02 08:41:54.846139	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	none	\N
50	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-02 08:41:54.881002	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVNuuqzgS_ZVRnjtHXJPNeWpCAjE7hg0YjBmNtrglXEzCDrmAW_3vY9JHPfNwNC31PIHKrlqrlqvWb4s0z8th-Lxd2vK8-L4	\N
51	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	VIEW_DASHBOARD	2026-05-02 08:42:48.979891	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	\N	.eJylVNuuqzgS_ZVRnjtHXJPNeWpCAjE7hg0YjBmNtrglXEzCDrmAW_3vY9JHPfNwNC31PIHKrlqrlqvWb4s0z8th-Lxd2vK8-L4	\N
53	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-02 08:58:11.17917	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVdmu4kgS_ZURz03JCzZFPQ3XYJy-zgQbr9kaXXnDTi9gMOCl1f8-YW51dT-UpqXpJ6PMOBkRJ04cfpuFcZy27cf9Uqbn2bd	\N
54	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-02 09:03:01.484377	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVdmu4kgS_ZURz03JCzZFPQ3XYJy-zgQbr9kaXXnDTi9gMOCl1f8-YW51dT-UpqXpJ6PMOBkRJ04cfpuFcZy27cf9Uqbn2bd	\N
55	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-02 09:03:29.301504	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVdmu4kgS_ZURz03JCzZFPQ3XYJy-zgQbr9kaXXnDTi9gMOCl1f8-YW51dT-UpqXpJ6PMOBkRJ04cfpuFcZy27cf9Uqbn2bd	\N
56	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-02 09:07:42.912003	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVdmu4kgS_ZURz03JCzZFPQ3XYJy-zgQbr9kaXXnDTi9gMOCl1f8-YW51dT-UpqXpJ6PMOBkRJ04cfpuFcZy27cf9Uqbn2bd	\N
57	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	VIEW_DASHBOARD	2026-05-02 09:23:51.795105	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	.eJylVdmu4kgS_ZURz03JCzZFPQ3XYJy-zgQbr9kaXXnDTi9gMOCl1f8-YW51dT-UpqXpJ6PMOBkRJ04cfpuFcZy27cf9Uqbn2bd	\N
58	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:25:04.078848	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
59	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:25:05.040002	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
60	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 16:25:09.267606	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
61	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:25:10.922333	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
62	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:25:11.81981	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
63	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 16:25:24.735801	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
64	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:25:26.056995	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
65	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:26:36.466748	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
66	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:26:40.029382	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
67	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:31:59.276906	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
68	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:31:59.74935	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
69	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:32:14.083805	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
70	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:32:16.318456	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
71	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:48.533142	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
72	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:48.733055	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
73	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:48.911122	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
74	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:49.214505	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
75	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:49.386493	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
76	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:49.666506	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
77	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:49.826209	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
78	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:50.136623	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
79	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:50.297419	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
80	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:50.611876	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
81	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:50.779361	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
82	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:51.129144	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
83	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:34:51.327172	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
84	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:43:02.824286	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
85	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:43:50.970865	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
86	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:44:55.062377	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
87	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:55:03.354895	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
88	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:58:56.432474	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
89	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 16:58:58.350306	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
90	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:58:59.822944	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
91	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:59:10.468893	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
92	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 16:59:15.292387	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
93	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 16:59:18.296586	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
94	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 16:59:24.309853	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	16		
95	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:03:59.361642	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
96	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 17:04:01.318863	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
97	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 17:04:02.292561	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
98	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 17:04:03.385191	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
99	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 17:09:30.495296	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
100	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:10:25.513207	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
101	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:12:22.084353	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
102	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:16:16.911948	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
103	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:16:42.048863	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
104	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:19:52.37695	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
105	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:21:41.091558	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
106	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:21:41.440244	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
107	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:25:24.255248	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
108	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:35:07.233984	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
109	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:35:29.95857	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
110	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:43:57.752363	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
111	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:43:59.216175	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
112	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:43:59.477495	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
113	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 17:43:59.69922	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
114	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	logout	2026-05-02 17:44:02.970185	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	17		
175	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	view_dashboard	2026-05-02 20:50:32.104537	192.168.222.143	Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101 Firefox/140.0	20		
205	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:09:00.387025	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
206	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:09:02.246795	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
207	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 21:09:57.482721	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
208	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:10:06.582485	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
209	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 21:10:16.64159	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
210	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:33:51.318541	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
211	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 21:33:54.725223	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
212	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:34:01.808278	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
213	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:34:59.420747	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
214	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 21:35:01.203085	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
215	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_users_list	2026-05-02 21:35:02.442025	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
216	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 21:35:03.835246	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
217	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:35:17.934293	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
218	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:36:13.586606	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
219	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_audit_logs	2026-05-02 21:36:25.191273	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
220	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:36:26.75187	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
221	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:38:41.862172	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
222	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_profile	2026-05-02 21:38:46.578826	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
223	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:38:48.393542	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
224	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	view_dashboard	2026-05-02 21:38:54.319483	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	21	087a4899-30ea-41e6-95b2-a7a19e7754d5	
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.roles (id, name, description) FROM stdin;
1	admin	Administrateur – accès total
2	manager	Manager – accès intermédiaire
3	user	Utilisateur standard
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.users (id, keycloak_id, username, email, created_at, role) FROM stdin;
2	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	alice@pfe.local	2026-05-01 12:56:16.944389	user
1	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	charlie@pfe.local	2026-04-30 21:48:19.845922	user
3	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	bob@pfe.local	2026-05-01 12:58:17.353312	user
\.


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 224, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.users_id_seq', 105, true);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users users_keycloak_id_key; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_keycloak_id_key UNIQUE (keycloak_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_audit_log_hour; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_audit_log_hour ON public.audit_log USING btree (hour_of_day);


--
-- Name: idx_audit_log_timestamp; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_audit_log_timestamp ON public.audit_log USING btree ("timestamp");


--
-- Name: idx_audit_log_username; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_audit_log_username ON public.audit_log USING btree (username);


--
-- Name: idx_audit_time; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_audit_time ON public.audit_log USING btree ("timestamp");


--
-- Name: idx_audit_user; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_audit_user ON public.audit_log USING btree (username);


--
-- PostgreSQL database dump complete
--

\unrestrict VTx8tNoBJm9Qf4RWRnJuo9qkuZBZgnPh1QmZK1xMbF70KsatiRNVN2xmBZtyooe

--
-- Database "keycloak" dump
--

--
-- PostgreSQL database dump
--

\restrict 9PFNqlUg0qItVfcUfHQiksPAQIHj55WegZH5QGMUDLDdSDDYcmgF9tDlyGTcTwG

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: pfe
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO pfe;

\unrestrict 9PFNqlUg0qItVfcUfHQiksPAQIHj55WegZH5QGMUDLDdSDDYcmgF9tDlyGTcTwG
\connect keycloak
\restrict 9PFNqlUg0qItVfcUfHQiksPAQIHj55WegZH5QGMUDLDdSDDYcmgF9tDlyGTcTwG

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO pfe;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO pfe;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO pfe;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO pfe;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO pfe;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO pfe;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO pfe;

--
-- Name: client; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO pfe;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO pfe;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO pfe;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO pfe;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO pfe;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO pfe;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO pfe;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO pfe;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO pfe;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO pfe;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO pfe;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO pfe;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO pfe;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO pfe;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO pfe;

--
-- Name: component; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO pfe;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO pfe;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO pfe;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO pfe;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO pfe;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO pfe;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO pfe;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO pfe;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO pfe;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO pfe;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO pfe;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO pfe;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO pfe;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO pfe;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO pfe;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO pfe;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO pfe;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO pfe;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO pfe;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO pfe;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO pfe;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO pfe;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO pfe;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO pfe;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO pfe;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO pfe;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO pfe;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO pfe;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO pfe;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO pfe;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO pfe;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO pfe;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO pfe;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO pfe;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO pfe;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO pfe;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO pfe;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO pfe;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO pfe;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO pfe;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO pfe;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO pfe;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO pfe;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO pfe;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO pfe;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO pfe;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO pfe;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO pfe;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO pfe;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO pfe;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO pfe;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO pfe;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO pfe;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO pfe;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO pfe;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO pfe;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO pfe;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO pfe;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO pfe;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO pfe;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO pfe;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO pfe;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO pfe;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO pfe;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO pfe;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO pfe;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO pfe;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO pfe;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO pfe;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO pfe;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
41de572a-986d-4271-9fb9-bc1e27fac815	1777495559341	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	events/config	\N	\N	REALM
70dca623-126b-41be-8ea6-32ee9ae9e500	1777496459763	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	events/config	\N	\N	REALM
dffb288e-aa20-4f7c-92a4-8715f9b029ae	1777712381617	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	\N	\N	\N	REALM
a607a595-5e55-4717-b1ee-7c8b8dba2ce5	1777712382418	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	events/config	\N	\N	REALM
3c3dc011-c4d5-49d2-b165-496bca1dc89e	1777712404024	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	\N	\N	\N	REALM
bdda1510-0fa6-4381-bef3-e1e17e6d594b	1777712404617	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	events/config	\N	\N	REALM
2ee400ee-79f8-43c5-a202-9b1a65f268e3	1777712405426	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	\N	\N	\N	REALM
32f8a088-8a33-4efa-b289-a14d80f816ed	1777712405689	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	events/config	\N	\N	REALM
e5f03db7-d1c9-411a-9508-8e10380dfd52	1777712409233	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	\N	\N	\N	REALM
29477cd2-83f5-4caa-bb4f-9c016cd65e8e	1777712409369	ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	events/config	\N	\N	REALM
37ebad6d-3149-4c9d-b3c9-977658f9699e	1777712557923	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2740f411-4a45-46bc-b875-ffda2b4a420c	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.1	events/config	\N	\N	REALM
12185370-3194-496d-86b7-22d4e13a4538	1777743247947	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.146	clients/f79db544-11eb-44c3-a37a-bf20fdf4020d	\N	\N	CLIENT
7c9fd9f8-2d47-4086-be96-11477e09d8a5	1777743248181	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.146	clients/2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	\N	\N	CLIENT
b431f245-5ee9-40f5-af1f-eceb3944b79a	1777743248323	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	192.168.222.146	clients/9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	\N	\N	CLIENT
24c35c06-5a20-4a01-8d68-3d61acfbc918	1777745247404	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/f79db544-11eb-44c3-a37a-bf20fdf4020d	\N	\N	CLIENT
e5a3e8d6-e666-493a-a86e-2d675b31142f	1777745247545	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	\N	\N	CLIENT
bebc9c73-69e7-45cc-a861-431e0d5bd8a8	1777745247680	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	\N	\N	CLIENT
d9efa2f5-d0e9-41ad-8b29-3496df98de54	1777752406841	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/f79db544-11eb-44c3-a37a-bf20fdf4020d	\N	\N	CLIENT
8090b3f9-77c4-4b64-8d7d-8822b544b6e0	1777752406951	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	\N	\N	CLIENT
31d5e9cb-ae90-4b1d-a0ac-d3b72e9e2ac0	1777752407058	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	\N	\N	CLIENT
cb6126d6-106a-4264-b828-2b1c2daff0f4	1777752628940	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/f79db544-11eb-44c3-a37a-bf20fdf4020d	\N	\N	CLIENT
18ca27d3-50f8-446a-bcf4-95a5415016b1	1777752629128	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	\N	\N	CLIENT
ba0874f6-4aed-4a5b-b214-f26badb0a3ef	1777752629279	bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE	ae6d91ea-3c93-4e73-a890-315f220847af	2b9c585b-5363-40df-935a-565ffcaf2f6b	20bb810c-509c-48ac-be27-ec55ff54af6d	172.18.0.1	clients/9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	\N	\N	CLIENT
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
58ad7ec4-c8ee-4c32-b998-59ddb2698147	\N	auth-cookie	ae6d91ea-3c93-4e73-a890-315f220847af	42af4930-12f5-429f-978c-0a2b016a0752	2	10	f	\N	\N
b0bc2f22-fce4-4b26-9e37-db28dcaf5035	\N	auth-spnego	ae6d91ea-3c93-4e73-a890-315f220847af	42af4930-12f5-429f-978c-0a2b016a0752	3	20	f	\N	\N
6c9e66ee-1b95-41d8-9851-41770fe6b674	\N	identity-provider-redirector	ae6d91ea-3c93-4e73-a890-315f220847af	42af4930-12f5-429f-978c-0a2b016a0752	2	25	f	\N	\N
2d2c0131-be92-4af9-a598-31578a67c9bd	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	42af4930-12f5-429f-978c-0a2b016a0752	2	30	t	a0c41a8e-ee82-4871-9c92-b0dc97f0c811	\N
74eca7f9-7480-413a-bf6c-edc4d289c7aa	\N	auth-username-password-form	ae6d91ea-3c93-4e73-a890-315f220847af	a0c41a8e-ee82-4871-9c92-b0dc97f0c811	0	10	f	\N	\N
c4023eda-2bc9-4c6b-80ba-c004eb0b8f42	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	a0c41a8e-ee82-4871-9c92-b0dc97f0c811	1	20	t	11da9e0e-e577-4d4b-a11d-98625cc2c720	\N
a291acfb-7155-4bff-8dd2-4a1a6c6ee058	\N	conditional-user-configured	ae6d91ea-3c93-4e73-a890-315f220847af	11da9e0e-e577-4d4b-a11d-98625cc2c720	0	10	f	\N	\N
14b0970d-bc0a-4491-b9f1-046d693f527d	\N	auth-otp-form	ae6d91ea-3c93-4e73-a890-315f220847af	11da9e0e-e577-4d4b-a11d-98625cc2c720	0	20	f	\N	\N
df76bf3a-ee8c-4000-b8b0-ac18b7e258d8	\N	direct-grant-validate-username	ae6d91ea-3c93-4e73-a890-315f220847af	814b0413-0c58-4197-86ed-cfbf1c4adee6	0	10	f	\N	\N
03bec78d-52c7-433f-bd02-897b3d480b39	\N	direct-grant-validate-password	ae6d91ea-3c93-4e73-a890-315f220847af	814b0413-0c58-4197-86ed-cfbf1c4adee6	0	20	f	\N	\N
d253a4b9-7077-4b9e-825e-f024b6a0fd06	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	814b0413-0c58-4197-86ed-cfbf1c4adee6	1	30	t	a58a1ffd-3d32-4530-a774-4d2dd1011c74	\N
40eb9870-e79e-4363-8b88-a27c08aeda6a	\N	conditional-user-configured	ae6d91ea-3c93-4e73-a890-315f220847af	a58a1ffd-3d32-4530-a774-4d2dd1011c74	0	10	f	\N	\N
66592afe-58b9-45fa-b384-890ab3cd20b7	\N	direct-grant-validate-otp	ae6d91ea-3c93-4e73-a890-315f220847af	a58a1ffd-3d32-4530-a774-4d2dd1011c74	0	20	f	\N	\N
8cea82dd-20da-4cf1-9ac1-f2eb01d991b2	\N	registration-page-form	ae6d91ea-3c93-4e73-a890-315f220847af	854c0f6d-c67d-451e-9d54-f7a503fb7028	0	10	t	d7658bb8-7994-4388-bfbb-4aff484e4a2f	\N
97b86561-f79b-407a-8055-0a26175b95bd	\N	registration-user-creation	ae6d91ea-3c93-4e73-a890-315f220847af	d7658bb8-7994-4388-bfbb-4aff484e4a2f	0	20	f	\N	\N
25e351f1-3f8d-41ed-9c09-91a06020b66f	\N	registration-password-action	ae6d91ea-3c93-4e73-a890-315f220847af	d7658bb8-7994-4388-bfbb-4aff484e4a2f	0	50	f	\N	\N
8e20ddef-619c-47d9-bb48-0db00bc80e63	\N	registration-recaptcha-action	ae6d91ea-3c93-4e73-a890-315f220847af	d7658bb8-7994-4388-bfbb-4aff484e4a2f	3	60	f	\N	\N
5f655e94-927a-4955-85bf-59ddaeb7dd2b	\N	registration-terms-and-conditions	ae6d91ea-3c93-4e73-a890-315f220847af	d7658bb8-7994-4388-bfbb-4aff484e4a2f	3	70	f	\N	\N
8b462241-397f-4e6b-9f41-a119e57a9126	\N	reset-credentials-choose-user	ae6d91ea-3c93-4e73-a890-315f220847af	3d81a45b-54f9-42a3-90df-0850681c2cd5	0	10	f	\N	\N
1ab16149-a3fa-4b17-86ab-193493bd1298	\N	reset-credential-email	ae6d91ea-3c93-4e73-a890-315f220847af	3d81a45b-54f9-42a3-90df-0850681c2cd5	0	20	f	\N	\N
5ce557ef-1ca2-4687-ac16-4c132b8aaece	\N	reset-password	ae6d91ea-3c93-4e73-a890-315f220847af	3d81a45b-54f9-42a3-90df-0850681c2cd5	0	30	f	\N	\N
55bfbdf3-f38e-447e-8a6d-f4d382a5cdfc	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	3d81a45b-54f9-42a3-90df-0850681c2cd5	1	40	t	a8df7028-2650-4062-86d2-910b7c24de2f	\N
476aecdc-fa22-4af9-8dc4-ef832e4328b6	\N	conditional-user-configured	ae6d91ea-3c93-4e73-a890-315f220847af	a8df7028-2650-4062-86d2-910b7c24de2f	0	10	f	\N	\N
a8749720-506f-40b7-b843-7b9543fc363b	\N	reset-otp	ae6d91ea-3c93-4e73-a890-315f220847af	a8df7028-2650-4062-86d2-910b7c24de2f	0	20	f	\N	\N
28514218-fe6c-4ff0-9ccf-bc45af381a96	\N	client-secret	ae6d91ea-3c93-4e73-a890-315f220847af	ae2e86ec-52d4-4311-ac97-c1fe7f00c450	2	10	f	\N	\N
429e04e4-c7ac-45b4-afe8-f98204009cc2	\N	client-jwt	ae6d91ea-3c93-4e73-a890-315f220847af	ae2e86ec-52d4-4311-ac97-c1fe7f00c450	2	20	f	\N	\N
8c65acb2-029d-448d-a8ab-555eaeb1a091	\N	client-secret-jwt	ae6d91ea-3c93-4e73-a890-315f220847af	ae2e86ec-52d4-4311-ac97-c1fe7f00c450	2	30	f	\N	\N
97032640-8b82-4aeb-9878-242fee0c5e91	\N	client-x509	ae6d91ea-3c93-4e73-a890-315f220847af	ae2e86ec-52d4-4311-ac97-c1fe7f00c450	2	40	f	\N	\N
a6414ce7-a204-41ff-8053-66942edc6d5c	\N	idp-review-profile	ae6d91ea-3c93-4e73-a890-315f220847af	b4d8aef3-114a-4569-a21e-175dbdbfae5f	0	10	f	\N	53f2d2c2-d400-4a29-b8b0-dec6b1e4aca7
31a747ca-1781-45c3-9481-80fbd957b53b	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	b4d8aef3-114a-4569-a21e-175dbdbfae5f	0	20	t	577cbe45-e68e-4519-88d5-089f06446bf6	\N
143414c4-7dbe-4010-951b-197596927210	\N	idp-create-user-if-unique	ae6d91ea-3c93-4e73-a890-315f220847af	577cbe45-e68e-4519-88d5-089f06446bf6	2	10	f	\N	38ccfa72-16f1-4293-9662-1cfd85521d7d
fec25387-00d9-422e-b4ba-ad3df97b2463	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	577cbe45-e68e-4519-88d5-089f06446bf6	2	20	t	500ff1a3-7995-496d-9983-89d9aa2fec9f	\N
dab4413a-0ca6-45a2-b028-dd68485bc506	\N	idp-confirm-link	ae6d91ea-3c93-4e73-a890-315f220847af	500ff1a3-7995-496d-9983-89d9aa2fec9f	0	10	f	\N	\N
53a9d767-bb11-4019-a719-fb858dcb9128	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	500ff1a3-7995-496d-9983-89d9aa2fec9f	0	20	t	091c925a-19f9-49b6-84eb-e29b06f91e0f	\N
0c619260-2a72-4caf-9d53-2d2a70f14c69	\N	idp-email-verification	ae6d91ea-3c93-4e73-a890-315f220847af	091c925a-19f9-49b6-84eb-e29b06f91e0f	2	10	f	\N	\N
2985d0fd-a97d-4045-a6d3-9a944be4e93d	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	091c925a-19f9-49b6-84eb-e29b06f91e0f	2	20	t	938f03b0-dda3-4ae4-8e27-a7cdac69339d	\N
d44e32a1-a49f-4f7a-b282-168e209ba691	\N	idp-username-password-form	ae6d91ea-3c93-4e73-a890-315f220847af	938f03b0-dda3-4ae4-8e27-a7cdac69339d	0	10	f	\N	\N
88b22905-45ab-4565-8110-aaa7d38d33de	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	938f03b0-dda3-4ae4-8e27-a7cdac69339d	1	20	t	e24394ff-2d6c-48bf-87cf-c22bb709fb98	\N
e799e3cf-4799-4347-847b-058a93e798f6	\N	conditional-user-configured	ae6d91ea-3c93-4e73-a890-315f220847af	e24394ff-2d6c-48bf-87cf-c22bb709fb98	0	10	f	\N	\N
91387b53-c6c7-46b1-b02a-5ab1f6ed221b	\N	auth-otp-form	ae6d91ea-3c93-4e73-a890-315f220847af	e24394ff-2d6c-48bf-87cf-c22bb709fb98	0	20	f	\N	\N
f1551b46-1267-4509-91fd-6e7e493280b9	\N	http-basic-authenticator	ae6d91ea-3c93-4e73-a890-315f220847af	fa0f43e5-8ef0-4fb5-b5de-de87a21d41ec	0	10	f	\N	\N
7fece1ef-7ccf-47f8-843d-879ad2556309	\N	docker-http-basic-authenticator	ae6d91ea-3c93-4e73-a890-315f220847af	ef3a6168-38ce-45cb-aacd-e97e9c0fc6da	0	10	f	\N	\N
8b361c35-8edd-4a85-b9d9-b43944e47eab	\N	auth-cookie	bb68fba0-f9aa-4ada-879f-ab68c527b51b	4847cb48-abd7-4607-98b0-cc8998178536	2	10	f	\N	\N
764cbaf9-19b6-409c-9615-d71c76d5452c	\N	auth-spnego	bb68fba0-f9aa-4ada-879f-ab68c527b51b	4847cb48-abd7-4607-98b0-cc8998178536	3	20	f	\N	\N
e48f6b61-d754-40be-89aa-c11767ae2fdc	\N	identity-provider-redirector	bb68fba0-f9aa-4ada-879f-ab68c527b51b	4847cb48-abd7-4607-98b0-cc8998178536	2	25	f	\N	\N
e8947226-f8f3-484b-a174-58ca81d54e7c	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	4847cb48-abd7-4607-98b0-cc8998178536	2	30	t	5dc4c4d9-1d23-478d-9c5a-e7161d0537a5	\N
e00e8635-3636-460d-938d-1f09e714be41	\N	auth-username-password-form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5dc4c4d9-1d23-478d-9c5a-e7161d0537a5	0	10	f	\N	\N
fb29b558-1cd9-4ad7-b690-9b1bad6e0a41	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5dc4c4d9-1d23-478d-9c5a-e7161d0537a5	1	20	t	45f2eec4-4fed-444e-a9c6-024ee689cb25	\N
0032617b-7fa8-473b-b143-431d812e1146	\N	conditional-user-configured	bb68fba0-f9aa-4ada-879f-ab68c527b51b	45f2eec4-4fed-444e-a9c6-024ee689cb25	0	10	f	\N	\N
50566a28-9299-435f-ad97-ea0edb8e9119	\N	auth-otp-form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	45f2eec4-4fed-444e-a9c6-024ee689cb25	0	20	f	\N	\N
cafdfcec-17bf-46ba-97f1-487303bfff82	\N	direct-grant-validate-username	bb68fba0-f9aa-4ada-879f-ab68c527b51b	489a2268-fae0-4193-8bc1-02000ba6f1b1	0	10	f	\N	\N
7622f15d-b4dc-4881-81e4-2e24481c9f89	\N	direct-grant-validate-password	bb68fba0-f9aa-4ada-879f-ab68c527b51b	489a2268-fae0-4193-8bc1-02000ba6f1b1	0	20	f	\N	\N
eea714dc-8d5f-41da-8664-2aaa3f569b0a	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	489a2268-fae0-4193-8bc1-02000ba6f1b1	1	30	t	b4b65613-58cf-4dc1-b8fa-34b863b5ee8f	\N
c222258b-57d8-4df9-91ce-4f639b6f6db3	\N	conditional-user-configured	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b4b65613-58cf-4dc1-b8fa-34b863b5ee8f	0	10	f	\N	\N
c25d87c3-0e05-4c69-aebc-41d88ebab3dc	\N	direct-grant-validate-otp	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b4b65613-58cf-4dc1-b8fa-34b863b5ee8f	0	20	f	\N	\N
892b5c05-5ea5-4258-ae70-a85232aa2fd8	\N	registration-page-form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8f601e9f-78a6-4004-9771-7c804b978ffe	0	10	t	81ae7463-4c23-465b-9c58-a96842b3abe7	\N
60b319ad-31e7-4670-8756-a3cf144894cf	\N	registration-user-creation	bb68fba0-f9aa-4ada-879f-ab68c527b51b	81ae7463-4c23-465b-9c58-a96842b3abe7	0	20	f	\N	\N
c8765f4e-ef18-47ed-af70-0db29d3f60d5	\N	registration-password-action	bb68fba0-f9aa-4ada-879f-ab68c527b51b	81ae7463-4c23-465b-9c58-a96842b3abe7	0	50	f	\N	\N
0090d8ed-43f3-4b5e-bf00-1d020fbd1808	\N	registration-recaptcha-action	bb68fba0-f9aa-4ada-879f-ab68c527b51b	81ae7463-4c23-465b-9c58-a96842b3abe7	3	60	f	\N	\N
ac300303-a684-405c-8499-86308b3250d3	\N	registration-terms-and-conditions	bb68fba0-f9aa-4ada-879f-ab68c527b51b	81ae7463-4c23-465b-9c58-a96842b3abe7	3	70	f	\N	\N
65fb6a50-5ad8-4737-b8b1-ff70e26ab089	\N	reset-credentials-choose-user	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0618d95b-2748-4e6f-bb3e-e4da4650206a	0	10	f	\N	\N
3bd7c3da-a3fa-4498-b8a2-9dbe5111d0da	\N	reset-credential-email	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0618d95b-2748-4e6f-bb3e-e4da4650206a	0	20	f	\N	\N
f256bdeb-cbdd-46da-859a-da7080e8f928	\N	reset-password	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0618d95b-2748-4e6f-bb3e-e4da4650206a	0	30	f	\N	\N
24d1a273-06c4-4385-830f-cd08e9a230b4	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0618d95b-2748-4e6f-bb3e-e4da4650206a	1	40	t	6af70698-8867-45d5-93bd-7070b4569999	\N
24073ba7-7d1b-4846-8cc5-61c3cfe36755	\N	conditional-user-configured	bb68fba0-f9aa-4ada-879f-ab68c527b51b	6af70698-8867-45d5-93bd-7070b4569999	0	10	f	\N	\N
0846a908-76a4-4230-bdeb-ae8636ccc86e	\N	reset-otp	bb68fba0-f9aa-4ada-879f-ab68c527b51b	6af70698-8867-45d5-93bd-7070b4569999	0	20	f	\N	\N
b8cccd7b-7fce-44e0-839c-bea996110569	\N	client-secret	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f07ecc62-9f08-4ffe-b0ab-17a1395586e2	2	10	f	\N	\N
27005f26-2b04-44e9-9c18-6bf67e03a88d	\N	client-jwt	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f07ecc62-9f08-4ffe-b0ab-17a1395586e2	2	20	f	\N	\N
b257de0f-5b0b-4324-a897-dcec3d3d307f	\N	client-secret-jwt	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f07ecc62-9f08-4ffe-b0ab-17a1395586e2	2	30	f	\N	\N
2b920585-206b-4abc-9545-c537eb6fd26e	\N	client-x509	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f07ecc62-9f08-4ffe-b0ab-17a1395586e2	2	40	f	\N	\N
1aeb78dc-6d36-40d9-bd4d-b4e2141bad4a	\N	idp-review-profile	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1b693dbc-45e5-4d72-94b1-884b41e12b26	0	10	f	\N	9fac72d6-f7a7-43cd-abc3-3ec06705cd82
2011b188-2a20-4d11-8972-8a379c72f5c9	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1b693dbc-45e5-4d72-94b1-884b41e12b26	0	20	t	a6ddeaf3-fee6-4947-a69c-6433e91095c6	\N
a7cd5841-75f5-47de-8279-db40e0a6f6ea	\N	idp-create-user-if-unique	bb68fba0-f9aa-4ada-879f-ab68c527b51b	a6ddeaf3-fee6-4947-a69c-6433e91095c6	2	10	f	\N	2e9da370-00ac-456c-8822-08fcfa7b5025
43e1f2df-6bb4-4b26-bb29-d408d4bccb8f	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	a6ddeaf3-fee6-4947-a69c-6433e91095c6	2	20	t	5645b15e-9150-4571-a2fd-fef9c9a6f69b	\N
54bde460-a2b0-47e7-bf57-3dc0993d4662	\N	idp-confirm-link	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5645b15e-9150-4571-a2fd-fef9c9a6f69b	0	10	f	\N	\N
3dc405eb-bf06-4e2f-b964-f960070aa937	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5645b15e-9150-4571-a2fd-fef9c9a6f69b	0	20	t	2afd3277-2567-4512-9bb1-59d46367b109	\N
c5d67510-a8e6-4488-bdda-2566a3a370ea	\N	idp-email-verification	bb68fba0-f9aa-4ada-879f-ab68c527b51b	2afd3277-2567-4512-9bb1-59d46367b109	2	10	f	\N	\N
d6b7c730-9e67-44c8-9bd5-042b389009a3	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	2afd3277-2567-4512-9bb1-59d46367b109	2	20	t	5ed666a9-dda2-4478-b2a1-8f56b68e5dd1	\N
88857bf0-8604-4bc5-b57e-e94bcc5c3774	\N	idp-username-password-form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5ed666a9-dda2-4478-b2a1-8f56b68e5dd1	0	10	f	\N	\N
72acf54f-4545-43ae-a668-2ac58497dc0c	\N	\N	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5ed666a9-dda2-4478-b2a1-8f56b68e5dd1	1	20	t	57b2fe5f-b56f-4389-823d-346eea60785c	\N
00151722-2235-42c4-b158-9ef7b8d2b5b7	\N	conditional-user-configured	bb68fba0-f9aa-4ada-879f-ab68c527b51b	57b2fe5f-b56f-4389-823d-346eea60785c	0	10	f	\N	\N
84f8201c-f97e-403b-ae9d-088b1edc5ea2	\N	auth-otp-form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	57b2fe5f-b56f-4389-823d-346eea60785c	0	20	f	\N	\N
caa3abc3-bc39-48b2-9a50-5e353ba173ae	\N	http-basic-authenticator	bb68fba0-f9aa-4ada-879f-ab68c527b51b	08cb58a2-f6e6-4fa3-9b5f-fafca1ec296f	0	10	f	\N	\N
8351b28d-00aa-4851-a525-8871cde4f0ee	\N	docker-http-basic-authenticator	bb68fba0-f9aa-4ada-879f-ab68c527b51b	661b001a-38ce-4eab-b729-ab799bc3f6be	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
42af4930-12f5-429f-978c-0a2b016a0752	browser	browser based authentication	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
a0c41a8e-ee82-4871-9c92-b0dc97f0c811	forms	Username, password, otp and other auth forms.	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
11da9e0e-e577-4d4b-a11d-98625cc2c720	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
814b0413-0c58-4197-86ed-cfbf1c4adee6	direct grant	OpenID Connect Resource Owner Grant	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
a58a1ffd-3d32-4530-a774-4d2dd1011c74	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
854c0f6d-c67d-451e-9d54-f7a503fb7028	registration	registration flow	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
d7658bb8-7994-4388-bfbb-4aff484e4a2f	registration form	registration form	ae6d91ea-3c93-4e73-a890-315f220847af	form-flow	f	t
3d81a45b-54f9-42a3-90df-0850681c2cd5	reset credentials	Reset credentials for a user if they forgot their password or something	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
a8df7028-2650-4062-86d2-910b7c24de2f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
ae2e86ec-52d4-4311-ac97-c1fe7f00c450	clients	Base authentication for clients	ae6d91ea-3c93-4e73-a890-315f220847af	client-flow	t	t
b4d8aef3-114a-4569-a21e-175dbdbfae5f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
577cbe45-e68e-4519-88d5-089f06446bf6	User creation or linking	Flow for the existing/non-existing user alternatives	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
500ff1a3-7995-496d-9983-89d9aa2fec9f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
091c925a-19f9-49b6-84eb-e29b06f91e0f	Account verification options	Method with which to verity the existing account	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
938f03b0-dda3-4ae4-8e27-a7cdac69339d	Verify Existing Account by Re-authentication	Reauthentication of existing account	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
e24394ff-2d6c-48bf-87cf-c22bb709fb98	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	f	t
fa0f43e5-8ef0-4fb5-b5de-de87a21d41ec	saml ecp	SAML ECP Profile Authentication Flow	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
ef3a6168-38ce-45cb-aacd-e97e9c0fc6da	docker auth	Used by Docker clients to authenticate against the IDP	ae6d91ea-3c93-4e73-a890-315f220847af	basic-flow	t	t
4847cb48-abd7-4607-98b0-cc8998178536	browser	browser based authentication	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
5dc4c4d9-1d23-478d-9c5a-e7161d0537a5	forms	Username, password, otp and other auth forms.	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
45f2eec4-4fed-444e-a9c6-024ee689cb25	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
489a2268-fae0-4193-8bc1-02000ba6f1b1	direct grant	OpenID Connect Resource Owner Grant	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
b4b65613-58cf-4dc1-b8fa-34b863b5ee8f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
8f601e9f-78a6-4004-9771-7c804b978ffe	registration	registration flow	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
81ae7463-4c23-465b-9c58-a96842b3abe7	registration form	registration form	bb68fba0-f9aa-4ada-879f-ab68c527b51b	form-flow	f	t
0618d95b-2748-4e6f-bb3e-e4da4650206a	reset credentials	Reset credentials for a user if they forgot their password or something	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
6af70698-8867-45d5-93bd-7070b4569999	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
f07ecc62-9f08-4ffe-b0ab-17a1395586e2	clients	Base authentication for clients	bb68fba0-f9aa-4ada-879f-ab68c527b51b	client-flow	t	t
1b693dbc-45e5-4d72-94b1-884b41e12b26	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
a6ddeaf3-fee6-4947-a69c-6433e91095c6	User creation or linking	Flow for the existing/non-existing user alternatives	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
5645b15e-9150-4571-a2fd-fef9c9a6f69b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
2afd3277-2567-4512-9bb1-59d46367b109	Account verification options	Method with which to verity the existing account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
5ed666a9-dda2-4478-b2a1-8f56b68e5dd1	Verify Existing Account by Re-authentication	Reauthentication of existing account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
57b2fe5f-b56f-4389-823d-346eea60785c	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	f	t
08cb58a2-f6e6-4fa3-9b5f-fafca1ec296f	saml ecp	SAML ECP Profile Authentication Flow	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
661b001a-38ce-4eab-b729-ab799bc3f6be	docker auth	Used by Docker clients to authenticate against the IDP	bb68fba0-f9aa-4ada-879f-ab68c527b51b	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
53f2d2c2-d400-4a29-b8b0-dec6b1e4aca7	review profile config	ae6d91ea-3c93-4e73-a890-315f220847af
38ccfa72-16f1-4293-9662-1cfd85521d7d	create unique user config	ae6d91ea-3c93-4e73-a890-315f220847af
9fac72d6-f7a7-43cd-abc3-3ec06705cd82	review profile config	bb68fba0-f9aa-4ada-879f-ab68c527b51b
2e9da370-00ac-456c-8822-08fcfa7b5025	create unique user config	bb68fba0-f9aa-4ada-879f-ab68c527b51b
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
38ccfa72-16f1-4293-9662-1cfd85521d7d	false	require.password.update.after.registration
53f2d2c2-d400-4a29-b8b0-dec6b1e4aca7	missing	update.profile.on.first.login
2e9da370-00ac-456c-8822-08fcfa7b5025	false	require.password.update.after.registration
9fac72d6-f7a7-43cd-abc3-3ec06705cd82	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	f	master-realm	0	f	\N	\N	t	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1781e806-776d-48a5-95ba-839e0a57cd02	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1e524d5a-f671-4a96-b877-518e0f11369d	t	f	broker	0	f	\N	\N	t	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2740f411-4a45-46bc-b875-ffda2b4a420c	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2b9c585b-5363-40df-935a-565ffcaf2f6b	t	f	admin-cli	0	t	\N	\N	f	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
fab40a15-e55c-40e6-843a-308eb6e53b13	t	f	pfe-realm	0	f	\N	\N	t	\N	f	ae6d91ea-3c93-4e73-a890-315f220847af	\N	0	f	f	pfe Realm	f	client-secret	\N	\N	\N	t	f	f	f
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	f	realm-management	0	f	\N	\N	t	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
f0275901-ed04-4b9d-ae28-d66de424b069	t	f	account	0	t	\N	/realms/pfe/account/	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	t	f	account-console	0	t	\N	/realms/pfe/account/	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e34ac089-905a-478a-8f29-5e68e5f0205a	t	f	broker	0	f	\N	\N	t	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
71700017-4f1b-4b6a-9db9-f4a1e50c1202	t	f	security-admin-console	0	t	\N	/admin/pfe/console/	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	t	f	admin-cli	0	t	\N	\N	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
f79db544-11eb-44c3-a37a-bf20fdf4020d	t	t	app-iam	0	f	iam-secret	\N	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	f	f
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	t	t	app-ticketing	0	f	ticketing-secret	\N	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	f	f
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	t	t	app-audit	0	f	audit-secret	\N	f	\N	f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
668b3405-4a1b-4c81-9cbc-ecd724f328b1	post.logout.redirect.uris	+
1781e806-776d-48a5-95ba-839e0a57cd02	post.logout.redirect.uris	+
1781e806-776d-48a5-95ba-839e0a57cd02	pkce.code.challenge.method	S256
2740f411-4a45-46bc-b875-ffda2b4a420c	post.logout.redirect.uris	+
2740f411-4a45-46bc-b875-ffda2b4a420c	pkce.code.challenge.method	S256
f0275901-ed04-4b9d-ae28-d66de424b069	post.logout.redirect.uris	+
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	post.logout.redirect.uris	+
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	pkce.code.challenge.method	S256
71700017-4f1b-4b6a-9db9-f4a1e50c1202	post.logout.redirect.uris	+
71700017-4f1b-4b6a-9db9-f4a1e50c1202	pkce.code.challenge.method	S256
f79db544-11eb-44c3-a37a-bf20fdf4020d	post.logout.redirect.uris	https://192.168.222.146/iam/##https://192.168.222.146/iam/*
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	post.logout.redirect.uris	https://192.168.222.146/ticketing/##https://192.168.222.146/ticketing/*
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	post.logout.redirect.uris	https://192.168.222.146/audit/##https://192.168.222.146/audit/*
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
5d282498-e23b-446a-bb2a-8762a123fee1	offline_access	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect built-in scope: offline_access	openid-connect
e52833ca-803d-4cf0-863e-5653d72b6914	role_list	ae6d91ea-3c93-4e73-a890-315f220847af	SAML role list	saml
1d96c492-2610-4f50-895a-47bb4eaa497a	profile	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect built-in scope: profile	openid-connect
d85c7381-616b-4e13-b2a6-88447163497e	email	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect built-in scope: email	openid-connect
20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	address	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect built-in scope: address	openid-connect
06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	phone	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect built-in scope: phone	openid-connect
a128ac5f-a515-47ad-a358-ac4e1875d65c	roles	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect scope for add user roles to the access token	openid-connect
85e2cbe3-fc11-4693-822f-a1bc476005c3	web-origins	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e80ce24a-5154-4641-b25a-7946accaa355	microprofile-jwt	ae6d91ea-3c93-4e73-a890-315f220847af	Microprofile - JWT built-in scope	openid-connect
e5af9ffa-a0b8-4264-990e-9d0e775486da	acr	ae6d91ea-3c93-4e73-a890-315f220847af	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
b476d5a5-23fc-41a4-aeeb-25b238feebd7	offline_access	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect built-in scope: offline_access	openid-connect
e9926443-9775-4d3a-b3fd-ec5d4b421c2b	role_list	bb68fba0-f9aa-4ada-879f-ab68c527b51b	SAML role list	saml
b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	profile	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect built-in scope: profile	openid-connect
40316e2f-4e65-4f3e-9297-1d1b55c9f614	email	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect built-in scope: email	openid-connect
67da9fcb-56db-405d-8c0a-ecb4315dad6a	address	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect built-in scope: address	openid-connect
2ba33045-6c73-4108-b9c0-d44c4c7d09ec	phone	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect built-in scope: phone	openid-connect
e18aa91f-739a-4a21-9baa-d10824062257	roles	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect scope for add user roles to the access token	openid-connect
5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	web-origins	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect scope for add allowed web origins to the access token	openid-connect
cf6c89c1-7006-410e-a19b-809cf10b2d46	microprofile-jwt	bb68fba0-f9aa-4ada-879f-ab68c527b51b	Microprofile - JWT built-in scope	openid-connect
ced9d6c0-467f-4799-9232-3be51c6b7755	acr	bb68fba0-f9aa-4ada-879f-ab68c527b51b	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
5d282498-e23b-446a-bb2a-8762a123fee1	true	display.on.consent.screen
5d282498-e23b-446a-bb2a-8762a123fee1	${offlineAccessScopeConsentText}	consent.screen.text
e52833ca-803d-4cf0-863e-5653d72b6914	true	display.on.consent.screen
e52833ca-803d-4cf0-863e-5653d72b6914	${samlRoleListScopeConsentText}	consent.screen.text
1d96c492-2610-4f50-895a-47bb4eaa497a	true	display.on.consent.screen
1d96c492-2610-4f50-895a-47bb4eaa497a	${profileScopeConsentText}	consent.screen.text
1d96c492-2610-4f50-895a-47bb4eaa497a	true	include.in.token.scope
d85c7381-616b-4e13-b2a6-88447163497e	true	display.on.consent.screen
d85c7381-616b-4e13-b2a6-88447163497e	${emailScopeConsentText}	consent.screen.text
d85c7381-616b-4e13-b2a6-88447163497e	true	include.in.token.scope
20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	true	display.on.consent.screen
20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	${addressScopeConsentText}	consent.screen.text
20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	true	include.in.token.scope
06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	true	display.on.consent.screen
06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	${phoneScopeConsentText}	consent.screen.text
06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	true	include.in.token.scope
a128ac5f-a515-47ad-a358-ac4e1875d65c	true	display.on.consent.screen
a128ac5f-a515-47ad-a358-ac4e1875d65c	${rolesScopeConsentText}	consent.screen.text
a128ac5f-a515-47ad-a358-ac4e1875d65c	false	include.in.token.scope
85e2cbe3-fc11-4693-822f-a1bc476005c3	false	display.on.consent.screen
85e2cbe3-fc11-4693-822f-a1bc476005c3		consent.screen.text
85e2cbe3-fc11-4693-822f-a1bc476005c3	false	include.in.token.scope
e80ce24a-5154-4641-b25a-7946accaa355	false	display.on.consent.screen
e80ce24a-5154-4641-b25a-7946accaa355	true	include.in.token.scope
e5af9ffa-a0b8-4264-990e-9d0e775486da	false	display.on.consent.screen
e5af9ffa-a0b8-4264-990e-9d0e775486da	false	include.in.token.scope
b476d5a5-23fc-41a4-aeeb-25b238feebd7	true	display.on.consent.screen
b476d5a5-23fc-41a4-aeeb-25b238feebd7	${offlineAccessScopeConsentText}	consent.screen.text
e9926443-9775-4d3a-b3fd-ec5d4b421c2b	true	display.on.consent.screen
e9926443-9775-4d3a-b3fd-ec5d4b421c2b	${samlRoleListScopeConsentText}	consent.screen.text
b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	true	display.on.consent.screen
b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	${profileScopeConsentText}	consent.screen.text
b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	true	include.in.token.scope
40316e2f-4e65-4f3e-9297-1d1b55c9f614	true	display.on.consent.screen
40316e2f-4e65-4f3e-9297-1d1b55c9f614	${emailScopeConsentText}	consent.screen.text
40316e2f-4e65-4f3e-9297-1d1b55c9f614	true	include.in.token.scope
67da9fcb-56db-405d-8c0a-ecb4315dad6a	true	display.on.consent.screen
67da9fcb-56db-405d-8c0a-ecb4315dad6a	${addressScopeConsentText}	consent.screen.text
67da9fcb-56db-405d-8c0a-ecb4315dad6a	true	include.in.token.scope
2ba33045-6c73-4108-b9c0-d44c4c7d09ec	true	display.on.consent.screen
2ba33045-6c73-4108-b9c0-d44c4c7d09ec	${phoneScopeConsentText}	consent.screen.text
2ba33045-6c73-4108-b9c0-d44c4c7d09ec	true	include.in.token.scope
e18aa91f-739a-4a21-9baa-d10824062257	true	display.on.consent.screen
e18aa91f-739a-4a21-9baa-d10824062257	${rolesScopeConsentText}	consent.screen.text
e18aa91f-739a-4a21-9baa-d10824062257	false	include.in.token.scope
5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	false	display.on.consent.screen
5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1		consent.screen.text
5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	false	include.in.token.scope
cf6c89c1-7006-410e-a19b-809cf10b2d46	false	display.on.consent.screen
cf6c89c1-7006-410e-a19b-809cf10b2d46	true	include.in.token.scope
ced9d6c0-467f-4799-9232-3be51c6b7755	false	display.on.consent.screen
ced9d6c0-467f-4799-9232-3be51c6b7755	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
668b3405-4a1b-4c81-9cbc-ecd724f328b1	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
668b3405-4a1b-4c81-9cbc-ecd724f328b1	1d96c492-2610-4f50-895a-47bb4eaa497a	t
668b3405-4a1b-4c81-9cbc-ecd724f328b1	d85c7381-616b-4e13-b2a6-88447163497e	t
668b3405-4a1b-4c81-9cbc-ecd724f328b1	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
668b3405-4a1b-4c81-9cbc-ecd724f328b1	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
668b3405-4a1b-4c81-9cbc-ecd724f328b1	e80ce24a-5154-4641-b25a-7946accaa355	f
668b3405-4a1b-4c81-9cbc-ecd724f328b1	5d282498-e23b-446a-bb2a-8762a123fee1	f
668b3405-4a1b-4c81-9cbc-ecd724f328b1	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
668b3405-4a1b-4c81-9cbc-ecd724f328b1	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
1781e806-776d-48a5-95ba-839e0a57cd02	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
1781e806-776d-48a5-95ba-839e0a57cd02	1d96c492-2610-4f50-895a-47bb4eaa497a	t
1781e806-776d-48a5-95ba-839e0a57cd02	d85c7381-616b-4e13-b2a6-88447163497e	t
1781e806-776d-48a5-95ba-839e0a57cd02	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
1781e806-776d-48a5-95ba-839e0a57cd02	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
1781e806-776d-48a5-95ba-839e0a57cd02	e80ce24a-5154-4641-b25a-7946accaa355	f
1781e806-776d-48a5-95ba-839e0a57cd02	5d282498-e23b-446a-bb2a-8762a123fee1	f
1781e806-776d-48a5-95ba-839e0a57cd02	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
1781e806-776d-48a5-95ba-839e0a57cd02	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
2b9c585b-5363-40df-935a-565ffcaf2f6b	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
2b9c585b-5363-40df-935a-565ffcaf2f6b	1d96c492-2610-4f50-895a-47bb4eaa497a	t
2b9c585b-5363-40df-935a-565ffcaf2f6b	d85c7381-616b-4e13-b2a6-88447163497e	t
2b9c585b-5363-40df-935a-565ffcaf2f6b	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
2b9c585b-5363-40df-935a-565ffcaf2f6b	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
2b9c585b-5363-40df-935a-565ffcaf2f6b	e80ce24a-5154-4641-b25a-7946accaa355	f
2b9c585b-5363-40df-935a-565ffcaf2f6b	5d282498-e23b-446a-bb2a-8762a123fee1	f
2b9c585b-5363-40df-935a-565ffcaf2f6b	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
2b9c585b-5363-40df-935a-565ffcaf2f6b	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
1e524d5a-f671-4a96-b877-518e0f11369d	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
1e524d5a-f671-4a96-b877-518e0f11369d	1d96c492-2610-4f50-895a-47bb4eaa497a	t
1e524d5a-f671-4a96-b877-518e0f11369d	d85c7381-616b-4e13-b2a6-88447163497e	t
1e524d5a-f671-4a96-b877-518e0f11369d	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
1e524d5a-f671-4a96-b877-518e0f11369d	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
1e524d5a-f671-4a96-b877-518e0f11369d	e80ce24a-5154-4641-b25a-7946accaa355	f
1e524d5a-f671-4a96-b877-518e0f11369d	5d282498-e23b-446a-bb2a-8762a123fee1	f
1e524d5a-f671-4a96-b877-518e0f11369d	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
1e524d5a-f671-4a96-b877-518e0f11369d	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
50c8ef45-e2ba-4681-a4be-40a3e99963ee	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
50c8ef45-e2ba-4681-a4be-40a3e99963ee	1d96c492-2610-4f50-895a-47bb4eaa497a	t
50c8ef45-e2ba-4681-a4be-40a3e99963ee	d85c7381-616b-4e13-b2a6-88447163497e	t
50c8ef45-e2ba-4681-a4be-40a3e99963ee	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
50c8ef45-e2ba-4681-a4be-40a3e99963ee	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
50c8ef45-e2ba-4681-a4be-40a3e99963ee	e80ce24a-5154-4641-b25a-7946accaa355	f
50c8ef45-e2ba-4681-a4be-40a3e99963ee	5d282498-e23b-446a-bb2a-8762a123fee1	f
50c8ef45-e2ba-4681-a4be-40a3e99963ee	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
50c8ef45-e2ba-4681-a4be-40a3e99963ee	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
2740f411-4a45-46bc-b875-ffda2b4a420c	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
2740f411-4a45-46bc-b875-ffda2b4a420c	1d96c492-2610-4f50-895a-47bb4eaa497a	t
2740f411-4a45-46bc-b875-ffda2b4a420c	d85c7381-616b-4e13-b2a6-88447163497e	t
2740f411-4a45-46bc-b875-ffda2b4a420c	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
2740f411-4a45-46bc-b875-ffda2b4a420c	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
2740f411-4a45-46bc-b875-ffda2b4a420c	e80ce24a-5154-4641-b25a-7946accaa355	f
2740f411-4a45-46bc-b875-ffda2b4a420c	5d282498-e23b-446a-bb2a-8762a123fee1	f
2740f411-4a45-46bc-b875-ffda2b4a420c	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
2740f411-4a45-46bc-b875-ffda2b4a420c	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
f0275901-ed04-4b9d-ae28-d66de424b069	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
f0275901-ed04-4b9d-ae28-d66de424b069	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
f0275901-ed04-4b9d-ae28-d66de424b069	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
f0275901-ed04-4b9d-ae28-d66de424b069	e18aa91f-739a-4a21-9baa-d10824062257	t
f0275901-ed04-4b9d-ae28-d66de424b069	ced9d6c0-467f-4799-9232-3be51c6b7755	t
f0275901-ed04-4b9d-ae28-d66de424b069	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
f0275901-ed04-4b9d-ae28-d66de424b069	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
f0275901-ed04-4b9d-ae28-d66de424b069	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
f0275901-ed04-4b9d-ae28-d66de424b069	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	e18aa91f-739a-4a21-9baa-d10824062257	t
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	ced9d6c0-467f-4799-9232-3be51c6b7755	t
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	e18aa91f-739a-4a21-9baa-d10824062257	t
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	ced9d6c0-467f-4799-9232-3be51c6b7755	t
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
2e40c67b-6559-44d2-bd07-68d2f88e6c9b	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
e34ac089-905a-478a-8f29-5e68e5f0205a	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
e34ac089-905a-478a-8f29-5e68e5f0205a	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
e34ac089-905a-478a-8f29-5e68e5f0205a	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
e34ac089-905a-478a-8f29-5e68e5f0205a	e18aa91f-739a-4a21-9baa-d10824062257	t
e34ac089-905a-478a-8f29-5e68e5f0205a	ced9d6c0-467f-4799-9232-3be51c6b7755	t
e34ac089-905a-478a-8f29-5e68e5f0205a	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
e34ac089-905a-478a-8f29-5e68e5f0205a	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
e34ac089-905a-478a-8f29-5e68e5f0205a	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
e34ac089-905a-478a-8f29-5e68e5f0205a	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	e18aa91f-739a-4a21-9baa-d10824062257	t
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	ced9d6c0-467f-4799-9232-3be51c6b7755	t
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
8bc7be32-6c84-4bcf-9cd8-689aec0e617f	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
71700017-4f1b-4b6a-9db9-f4a1e50c1202	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
71700017-4f1b-4b6a-9db9-f4a1e50c1202	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
71700017-4f1b-4b6a-9db9-f4a1e50c1202	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
71700017-4f1b-4b6a-9db9-f4a1e50c1202	e18aa91f-739a-4a21-9baa-d10824062257	t
71700017-4f1b-4b6a-9db9-f4a1e50c1202	ced9d6c0-467f-4799-9232-3be51c6b7755	t
71700017-4f1b-4b6a-9db9-f4a1e50c1202	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
71700017-4f1b-4b6a-9db9-f4a1e50c1202	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
71700017-4f1b-4b6a-9db9-f4a1e50c1202	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
71700017-4f1b-4b6a-9db9-f4a1e50c1202	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
f79db544-11eb-44c3-a37a-bf20fdf4020d	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
f79db544-11eb-44c3-a37a-bf20fdf4020d	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
f79db544-11eb-44c3-a37a-bf20fdf4020d	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
f79db544-11eb-44c3-a37a-bf20fdf4020d	e18aa91f-739a-4a21-9baa-d10824062257	t
f79db544-11eb-44c3-a37a-bf20fdf4020d	ced9d6c0-467f-4799-9232-3be51c6b7755	t
f79db544-11eb-44c3-a37a-bf20fdf4020d	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
f79db544-11eb-44c3-a37a-bf20fdf4020d	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
f79db544-11eb-44c3-a37a-bf20fdf4020d	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
f79db544-11eb-44c3-a37a-bf20fdf4020d	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	e18aa91f-739a-4a21-9baa-d10824062257	t
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	ced9d6c0-467f-4799-9232-3be51c6b7755	t
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	e18aa91f-739a-4a21-9baa-d10824062257	t
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	ced9d6c0-467f-4799-9232-3be51c6b7755	t
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
5d282498-e23b-446a-bb2a-8762a123fee1	73864e8e-6ccc-455c-a9f7-9998000a37aa
b476d5a5-23fc-41a4-aeeb-25b238feebd7	24995697-a0f6-4175-8adb-a6ae05d41c8f
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
41f662bc-d91c-4b17-b44a-8b91d489656a	Trusted Hosts	ae6d91ea-3c93-4e73-a890-315f220847af	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
d57db625-dd72-4563-8f32-ab00e17d6261	Consent Required	ae6d91ea-3c93-4e73-a890-315f220847af	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
c58befc5-f799-4d09-a178-adc2ff69c22e	Full Scope Disabled	ae6d91ea-3c93-4e73-a890-315f220847af	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
dc536fc6-8717-429f-a76d-daaacc9da8ee	Max Clients Limit	ae6d91ea-3c93-4e73-a890-315f220847af	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
05671fa0-a8f0-4a86-a79b-59a1f474e21f	Allowed Protocol Mapper Types	ae6d91ea-3c93-4e73-a890-315f220847af	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
1cd447b4-0d89-447b-8531-d0dd185a7c25	Allowed Client Scopes	ae6d91ea-3c93-4e73-a890-315f220847af	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	anonymous
a7bf8991-83fd-448d-b42b-896db9dcd108	Allowed Protocol Mapper Types	ae6d91ea-3c93-4e73-a890-315f220847af	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	authenticated
1467ef0c-c5f9-4f81-b852-6574c8cf1dc2	Allowed Client Scopes	ae6d91ea-3c93-4e73-a890-315f220847af	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	authenticated
e4de45fe-3f42-44f4-8a4a-0cce66cb05c3	rsa-generated	ae6d91ea-3c93-4e73-a890-315f220847af	rsa-generated	org.keycloak.keys.KeyProvider	ae6d91ea-3c93-4e73-a890-315f220847af	\N
de495888-62bf-4b13-b517-f7ea1e654e17	rsa-enc-generated	ae6d91ea-3c93-4e73-a890-315f220847af	rsa-enc-generated	org.keycloak.keys.KeyProvider	ae6d91ea-3c93-4e73-a890-315f220847af	\N
f7b7cdb5-287b-4392-82cc-f0fb604366ab	hmac-generated-hs512	ae6d91ea-3c93-4e73-a890-315f220847af	hmac-generated	org.keycloak.keys.KeyProvider	ae6d91ea-3c93-4e73-a890-315f220847af	\N
39f7a072-e9a2-4549-8816-e7d6f85dea37	aes-generated	ae6d91ea-3c93-4e73-a890-315f220847af	aes-generated	org.keycloak.keys.KeyProvider	ae6d91ea-3c93-4e73-a890-315f220847af	\N
a7c0630a-5ca6-472f-942a-31de2d60e2e1	\N	ae6d91ea-3c93-4e73-a890-315f220847af	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	ae6d91ea-3c93-4e73-a890-315f220847af	\N
a34f1e95-0a35-4877-a70b-bb65946036bb	rsa-generated	bb68fba0-f9aa-4ada-879f-ab68c527b51b	rsa-generated	org.keycloak.keys.KeyProvider	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N
f63fda1d-362c-44dc-a54b-39994d41b0b8	rsa-enc-generated	bb68fba0-f9aa-4ada-879f-ab68c527b51b	rsa-enc-generated	org.keycloak.keys.KeyProvider	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N
31120db4-d46a-4a7d-ad82-503361b89d4c	hmac-generated-hs512	bb68fba0-f9aa-4ada-879f-ab68c527b51b	hmac-generated	org.keycloak.keys.KeyProvider	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N
7bd7c034-113f-46bf-bf98-c5d8172daacd	aes-generated	bb68fba0-f9aa-4ada-879f-ab68c527b51b	aes-generated	org.keycloak.keys.KeyProvider	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N
db3bae72-61f1-46be-9ddc-86ffc1ac396d	Trusted Hosts	bb68fba0-f9aa-4ada-879f-ab68c527b51b	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
79d72a5a-f387-452b-a21d-7aba8f7233ee	Consent Required	bb68fba0-f9aa-4ada-879f-ab68c527b51b	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
1b4026e3-77a0-4c3b-83fe-6fdb7c3b716b	Full Scope Disabled	bb68fba0-f9aa-4ada-879f-ab68c527b51b	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
3a438069-03ca-4541-aae3-25703560a322	Max Clients Limit	bb68fba0-f9aa-4ada-879f-ab68c527b51b	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	Allowed Protocol Mapper Types	bb68fba0-f9aa-4ada-879f-ab68c527b51b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
023d224a-e55a-44c0-8567-2be6364251f6	Allowed Client Scopes	bb68fba0-f9aa-4ada-879f-ab68c527b51b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	anonymous
f21515c6-527c-4e6b-961f-01a6766c17fc	Allowed Protocol Mapper Types	bb68fba0-f9aa-4ada-879f-ab68c527b51b	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	authenticated
5308a888-8b71-4c00-bf06-870f81327291	Allowed Client Scopes	bb68fba0-f9aa-4ada-879f-ab68c527b51b	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
49cfbec6-28ea-4bdc-86c0-67120b8eff4c	1467ef0c-c5f9-4f81-b852-6574c8cf1dc2	allow-default-scopes	true
d691ac8c-61c8-4a34-92de-12a2d4f07b61	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bb800d7d-27e9-44c9-81fc-49a3d8bcbdeb	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	saml-user-attribute-mapper
29329629-f0ca-422d-bd08-87a4cbbfb75e	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
bf81dd67-356a-4d38-b66e-f226f2bae8c0	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	saml-user-property-mapper
953b72e4-67ad-4e83-89af-86b12f9545e9	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	oidc-full-name-mapper
4e5e9d05-12ab-4ab3-a5d3-f5c4e1bd0644	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	oidc-address-mapper
6af6b264-25a7-4b75-a2fc-52691f08ba62	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	saml-role-list-mapper
edd8bc1b-9c3b-4a1d-a89e-d054376b4d69	05671fa0-a8f0-4a86-a79b-59a1f474e21f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
dc384d08-cf46-4a23-ae79-cf3d5073f027	dc536fc6-8717-429f-a76d-daaacc9da8ee	max-clients	200
4cf5bee0-9106-490c-a8a7-9e97ea323271	41f662bc-d91c-4b17-b44a-8b91d489656a	host-sending-registration-request-must-match	true
6efacd9d-7212-4996-a009-4eae0957454a	41f662bc-d91c-4b17-b44a-8b91d489656a	client-uris-must-match	true
139a1274-bd8f-4040-9d5b-39ae508e43fb	1cd447b4-0d89-447b-8531-d0dd185a7c25	allow-default-scopes	true
f1d96171-87db-49b3-9d5a-b6ddaf62596b	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ac380e9b-d42b-486c-bd40-96030c94db69	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
589794f3-69fe-41b4-8a75-2877197ea8a0	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	saml-user-property-mapper
237bc42d-63a0-49c6-a51c-f49c22931ac1	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	oidc-full-name-mapper
c5073e07-fe10-41b4-8024-cee7a2d7cf6e	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	oidc-address-mapper
0f6297ae-a3d3-48da-b437-a180b857f414	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5b704d37-9d5f-4104-85b2-221b39f44dac	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	saml-role-list-mapper
f4134e19-61a4-469e-acb8-150886d7de1a	a7bf8991-83fd-448d-b42b-896db9dcd108	allowed-protocol-mapper-types	saml-user-attribute-mapper
548f7ed3-f489-48fe-86c0-d9ce328f172f	de495888-62bf-4b13-b517-f7ea1e654e17	priority	100
45fc4116-a9a3-4e33-ba67-7263842f9d7d	de495888-62bf-4b13-b517-f7ea1e654e17	privateKey	MIIEpAIBAAKCAQEA6f0QbQGwtE09uK9ryzrhx/vHCLAwnUc7umH2U4+k2rxFQ9ViOS1vSgM0RAyt4Z+Nqd5KIvgwZgDyTy/EWRfvFYkJAgVH6n4D46Z9Am+jkAu/2+kUh7S6JwD5RLfthM8ZPjBUitcg6Cw+uEhnVLEYKYrfRPB2bIbsXb9jIC+NDqafUmyFf1d+wG9FW2gqANphm89hWjIJgTd0bd5qV9VqkN5O89klsFzhf6mInDDL/LaQIm8RpjybRFrtNkDI/BMDkxRrb3exE7z9vAdM89CIq0wra1fozT7uDoz+Btv/dcOZeaQrW+q/P48BTr8CquEMWw4RRQyaePt3v67uvMzSIQIDAQABAoIBAGl/cKL9UpsQgmYdLahNbZQZyIT5z4lyHxNrbMEDMGxw23f4oxctjZJcvHl8D//8zMYMk/eNWGD9R0L9wfT7jg/zH60aDXFEDOPc4lsxU5k0OvZfciK3kQDZ9wmNNhmduH9qEgwhb9ROcp7rAi/UwxSj6QOvuW04LiUckAhoeBxkle7G69AvvHdHxm6zCP5bYp5YkmlpwRzn0qSDGIuSdfMjLR9QC1xBvOLektkgIazoS3mm+PskIykSVmZr76t1FabPba6mnj3jpavcAKZev5VYUiE1gFhiPglh9QXvPEFIiBom01fCngU7cKJBJmQHRjiP61GRDj0apKzUJ6B9+rsCgYEA/lwTVXl85IgVXhbxIdn5C0XbUJFoY0QNaZhRpcuSXHQAGG1xw618a1ARF/c16VpfefbcUhos9MggGh4wretc98YhACbAERlS/yC7un1Nb/vuhgEcvSndy4/gX8+mKhXWlFa+aLPxMNyuBxbQjH64J6Kji18M5B+aXKvSCbK5XdMCgYEA639bli8+kmEabl2L9jOanHU6Twz2Cah4JTZaFr06r491KKVU9lg0d9yGEi++IfYWm50YLVQXq5qNhj6ZvthfgNOklEsIQB0w8YQDp4wV7N4QaMb+EsvE2b15LHUlHpmvNbDIrj5huNb8bN0kUp1zENQsZ7omBmRSl3RIbMOS87sCgYEAqofMpoeWxhi+SqCS9aEPqREiond6RuL/IwZt5vv+mmFjFv15Qjlzqva5HxosWNCwJjLtL1ZBQbNSYnBPLqsXXz7ELTfNmSkjTc0CT1tmqWd8WPcx71i8TJefVF0BCEIv5K/rZIMPdzTcsAAJvcfPazNM9km5eM//S5YecUYTpOUCgYEAjBKLok/lkuGI/B5OMpnNG8SqcvyNl38KP3ANs7rIHkZg9FUqrQAX7TdQ055sI/0gw1x0VfnPvnVGOpQflKFUZOb93GqotKHoS68vEUhEfkgzUG8UDo//PVfyrBvdgU7+JRxKsUFPlMbjC8mZYj5eg6L/6o6RMXoYmhdDQNYvISMCgYA7MPx+uSBWDENQhkE00huINoAOSOUBGv9hITWpBurp6TRM2fQcT5CPA6PjZfKe/w+Isu4WK7NCbCjU42yjymruEkV54v+8sUmGn3m+RsMsqw/aSXETMJiMqWA5i8NqT1SieQpC0U9gejBn1ejxzrS2ULfFXHT4+Cu37m5l8yxJhQ==
fb1ef2c2-686b-4ccd-a8b2-86ee0529c509	de495888-62bf-4b13-b517-f7ea1e654e17	keyUse	ENC
6f0b659a-7cb3-4961-95c7-98327f262317	de495888-62bf-4b13-b517-f7ea1e654e17	certificate	MIICmzCCAYMCBgGd2umy6zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNDI5MjAyMjIyWhcNMzYwNDI5MjAyNDAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDp/RBtAbC0TT24r2vLOuHH+8cIsDCdRzu6YfZTj6TavEVD1WI5LW9KAzREDK3hn42p3koi+DBmAPJPL8RZF+8ViQkCBUfqfgPjpn0Cb6OQC7/b6RSHtLonAPlEt+2Ezxk+MFSK1yDoLD64SGdUsRgpit9E8HZshuxdv2MgL40Opp9SbIV/V37Ab0VbaCoA2mGbz2FaMgmBN3Rt3mpX1WqQ3k7z2SWwXOF/qYicMMv8tpAibxGmPJtEWu02QMj8EwOTFGtvd7ETvP28B0zz0IirTCtrV+jNPu4OjP4G2/91w5l5pCtb6r8/jwFOvwKq4QxbDhFFDJp4+3e/ru68zNIhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACW98kIW4zoTSKV+r9gp5rs1c7kTO9yRW00dqXKKP7I7wEk8N2NyHuf9p7TpbLoV+AKGkK95j8+/QODQFnmdo0c3c60K9/rrHEYJ5LlxQf3lTy7nui5X7fOTh4R4PNB4mtWU5wpH2gmr3+WU4TZ+3W2gthy/E/iVz0wLQ5mKMjOeulPPsszKopj3aNxo7omQWJ1K1ClbWepJj3exClMamMBHri5Im0HPib3lDmlTm0M6ME5JimxNillHs4ilG+EsuEqJT8/L4wxEh2OIxeKG4y8nml23HUS1SyyLxpBDyLW6cLOYFxrfGqVDkhjfMKVu8Qgw8C64G3XKe6FbWxoUhSU=
404757b9-0eaf-4728-a0d5-522c94feeaae	de495888-62bf-4b13-b517-f7ea1e654e17	algorithm	RSA-OAEP
a64a8341-8b7a-4d7d-b062-d2f5c069716c	39f7a072-e9a2-4549-8816-e7d6f85dea37	priority	100
96ec499d-ffb4-43c2-93cd-26e0ed48aac9	39f7a072-e9a2-4549-8816-e7d6f85dea37	secret	39iVsl9eQ8lfwwoR9J5FzQ
e04d8910-2ba8-4b94-ad45-5ac5f932859b	39f7a072-e9a2-4549-8816-e7d6f85dea37	kid	d22afa2a-289c-437c-8d4c-431cfd476b6a
9554fffc-185e-402b-a463-70fadabb21a3	f7b7cdb5-287b-4392-82cc-f0fb604366ab	priority	100
b97ec991-8675-4234-97c6-6ad4774330e8	f7b7cdb5-287b-4392-82cc-f0fb604366ab	secret	p_4mDf-4rhcurewivNW0c95_wz0xIM5aS2lZZHO6Ovpt_aZgBqJlLFqVt5oqvkFagb4-w2jdXoOc4PxCGgjnJLzHMyOybSMALf82pKAz9j1y5-9KXfzkBqJU5oxig99C63AAQQ3XiIhc57yIp25U4D7zV4aFzxEbNNsJu46zxrk
7860b669-785f-4b75-b4e2-f596ac716850	f7b7cdb5-287b-4392-82cc-f0fb604366ab	kid	b84dcd0d-bfec-49c4-8cfb-a9172cdc80a6
a6355199-2493-4758-af4a-e7ee9f373318	f7b7cdb5-287b-4392-82cc-f0fb604366ab	algorithm	HS512
b2c53e0e-40f7-4243-b3ac-4e3ecb23ec2e	31120db4-d46a-4a7d-ad82-503361b89d4c	secret	cU_kSUc3E6PO2cvpWpkJb9D4_QkbaF-Uqx-wxYqVS_fIsOMvJV3mEDU_zVAljPJAVWEt6vUwwaKKe1fbRPp68fA7j2OHDLebhagS0RbijFwdHrILM89yxapwLQ_NmtqTQylm8zmxZZzLlopQWZmrWzZTvO-2heekWYPFn6nvXEA
f3c5edea-cde0-4f59-bf62-15b33aa60cda	a34f1e95-0a35-4877-a70b-bb65946036bb	priority	100
6016b608-bf79-40fa-9195-7c57057ff52b	e4de45fe-3f42-44f4-8a4a-0cce66cb05c3	privateKey	MIIEowIBAAKCAQEAr7pGz0HQ7w3ReTtjbILzO54llCHaSCYbqBytw0jsm3qku9TSaN09Ndz6nO5N+YoeZwuiRyGkn9BMu2DPtEZeMvdGoKw5qY9wJ5ZQGLwWW50FK2bBbQziFeW0HGTZaKDNkj73mTh/w/nrmVpVWN0OJcZPYOaqMQBna0ebPXgHM6V5lHFgLqFNtiiYpicdU/dIFsRYfdfCedY4zN0V2XZS0d/CaE0m+HSUr3Byw4/vVdvW20U/SPCMBFjpQlG3YEY8Kz+uewlG6UGe9+DunAnKTdELZ73NBAiJG6aaJ5Ht8OGjRMqRsmdrjiO6g2HUCw8b00auV/kUYmEhV7kPA6LJiwIDAQABAoIBAEP0xW1hBmtr7JX1YX2VJnrnraCbds5v7kIU1R2wFdAKnaoFo1jqNcGes0v83CqkPx2aYicf24nyA7pyteABVmxfM/DuqV3pGnY0qsTl9791+YnPMv34/XV6Xyyb03eit9zWfOnD76TaAUJMrLSwx8fT6N6QVUCd52CVUHN091QBBHvprUkqO2dlEUaeb4Ufcp7bqTVCGhaW1/S6fYxo78hBx1MLef6KiovTZM2ascmTnVqzORds4rrHClI1RMAjhn0dGaylpUEyvWlj936N1jA2UVW/exq/alHh8H0mlDKF0OO9rRdYew7jKkmKfwA29Cowc/D1s5wsA/9MZs96iAECgYEA8praPLJrExUwHMOKJCh4nZT6/OfKoblsq+XLrRdSVHZ1SDTXDLhvd8k2gRmrpmTVT6Xy+fnvyqLIm5J1ZBR6c0dxHbiLz2yEkK/l40E1qc2Ic0prmf6ulhA7TUq1fCcYcxvKpDJd8/JJuljTKdJnkDFMzQYV+rAG9oCDUHCaCVUCgYEAuW4iW9xMKaSFfLyi5B+1DW7lEwLdx+/BpVnzz3n+iX8eCYF+X/eR80y2OHECB0g+YJlbHw9EC/hqHEz0qLyFQM13tYJ/Oa5GHs4bro/I7XM6WzmYfmRv4MTUpmhDtB7bQTHnMSqlucwH9/UDlrgcBsXO6L1tEw0vLP0vipNYB18CgYEA1vedv0C9HgidPC+L/WQbFE7JY0WkSE88WsjhA/vxSMQ6QgQINc5LfxG9CQINFgCs/slmFliAQMajCS7qdAatRe6c7Z/zypU2ldo20nqaqV5ktPvRgn+ohXHWijNTwrIFuSF8GqhClgEvkT5ZxeoZOCxnCBiHaz2EvfG76ZAM/Y0CgYA+8hL5yeuUy0OBF2vYMqc8OyPJ81Qj9dBvd/yatpfgRuWEZo/mtdy2kZjdygbdP/nkwso63ezEf3xNxRXcXbqCR/1WAUl85BrrhB3DgQ29BTuPEhsg9KlBzK8/Ge+5qivVksIfX5HIY2llE6g3NqJU7jsRqJPpPrV/+SZ1TRU50wKBgHd1wE7atRJTLYFGdHCqZyBqLz4MOn6u1B7FVVQBHWGkllcc8Rhl5dmvmgatriugpFtUyhU/TarDB9uTYAYnMhUhX9Qjs3AAw23q69wKl6zpxdNDgd/uD2G9LSUra33kMwC9y4uG7UAAl5BWp3P2Lj4p/Gld861oxmaAz0Hy+3cI
665bfd0f-81ea-4df9-bdcb-652f1fc70211	e4de45fe-3f42-44f4-8a4a-0cce66cb05c3	certificate	MIICmzCCAYMCBgGd2umx9zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNDI5MjAyMjIxWhcNMzYwNDI5MjAyNDAxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvukbPQdDvDdF5O2NsgvM7niWUIdpIJhuoHK3DSOybeqS71NJo3T013Pqc7k35ih5nC6JHIaSf0Ey7YM+0Rl4y90agrDmpj3AnllAYvBZbnQUrZsFtDOIV5bQcZNlooM2SPveZOH/D+euZWlVY3Q4lxk9g5qoxAGdrR5s9eAczpXmUcWAuoU22KJimJx1T90gWxFh918J51jjM3RXZdlLR38JoTSb4dJSvcHLDj+9V29bbRT9I8IwEWOlCUbdgRjwrP657CUbpQZ734O6cCcpN0Qtnvc0ECIkbpponke3w4aNEypGyZ2uOI7qDYdQLDxvTRq5X+RRiYSFXuQ8DosmLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACEb3dSfjC+pROF5Ku3Xbl94I9sCgil91B0PiYA9EDOCz/nXCvLHGgkbhX9/gCd1VIVaMahuzmes6Yn/VeXoKYZu5PZnXcZ9ttXMF7UTr8h2JQL1jwuSkyTdwja93rHgjlYpUR4UpwoYlBH2FJn3bikLqvD8RX+dvDr+/aY/anOH/LBEIcpYDHedV3EFP8X0WZu3B3IxCE5ITbIBkfO/TAgfs/KucBUSqrHoczONsZT2oiuiQjA6I6Y7PYS1pk77SW7GlTPUf3Z42lGDWcardo1Re0FDbddtyEtIAXZqkjMIVEF/gSoCUzVZSQUFVWF3NGaKzG2ew4DtMGcsKJBY2wU=
268985fd-0822-4768-9a8c-217127be77e7	e4de45fe-3f42-44f4-8a4a-0cce66cb05c3	keyUse	SIG
51397fdc-0313-467c-8c47-fa538c40ed97	e4de45fe-3f42-44f4-8a4a-0cce66cb05c3	priority	100
7f0cc44c-5d2f-4cb9-b650-5c18e3bf59fc	a7c0630a-5ca6-472f-942a-31de2d60e2e1	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
8574d27b-fa23-434e-88ea-35dc2b73f86e	7bd7c034-113f-46bf-bf98-c5d8172daacd	priority	100
6fd534c1-c7d9-4a42-a55f-1a4294467a3b	7bd7c034-113f-46bf-bf98-c5d8172daacd	secret	6nPkcfg5vjbw4L9jev0RQg
9aeb332a-8ee3-4494-b10a-cf8c0c58c54d	7bd7c034-113f-46bf-bf98-c5d8172daacd	kid	0a0837be-471f-42d1-ae19-62c4e18e2cc6
0d9bf3b0-bae0-4295-bd31-742c752090d2	f63fda1d-362c-44dc-a54b-39994d41b0b8	certificate	MIIClTCCAX0CBgGd2unf9jANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANwZmUwHhcNMjYwNDI5MjAyMjMzWhcNMzYwNDI5MjAyNDEzWjAOMQwwCgYDVQQDDANwZmUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDhyWbiv7XM7ibAuCS2VqqIY2nhzHwM1u/7rpyWwnrQvo1l8PLmL8mldykNeeP4TtCLiqSIrGvOXpiA3DSQ2J3G8YUVgqNgokowQeSyGvy2OutFYrqFTkvQLOwFQnSeKMvpNxP99sFqjWRbO9UGH9bfBVZ1P5bPDf9Ire6TjtxB/KtLxTGm95+zO87W/iR9ORzbtKMtPzxu2TLep/jhKU8kldGs6FtlF7V68uO1dp1D+Jivuf/52IHzH4CdUhpInC3q6XbQbOqqX+N25xignwFZBYAHq4Xy3CPET9QrPaVmsF/ksSjfdXzvoX0s84HngchlptmtFOZZQ+fRB4J0rmKlAgMBAAEwDQYJKoZIhvcNAQELBQADggEBANUtYTerhDaSUJK3igLjo4KqIb+nSTiwQHWOTKZiqcoxMcieQEjAhh/mZoVc2nbi6XnZSI51mHTDmMLjuABE3qpus7wiEq7PLH32M+aL9qd8YIIrU8TWfUMegN6XWDmp87qdUjCfUGY7TkMAk5hyjgEsxO2Cw9lPp516x3WEYGt3QUDJeW7mEwX6qHKSXF1ByLpck3fM9x38qjUVWB2bLAMdr21ePY/E/DoxibPc+Krd0fkQpmrn1ESdwofYBIGBa2HEgHui0GgkjNYQ5Cmj42Th6SU3AIVxUp45st2VxA1Ysjh7Z9XXrlYY93Nl5Dc6XV6m+jas0BG4XLt4d/6fIUg=
add6df11-ddbd-4cee-b963-7a563a1d9fb4	f63fda1d-362c-44dc-a54b-39994d41b0b8	privateKey	MIIEogIBAAKCAQEA4clm4r+1zO4mwLgktlaqiGNp4cx8DNbv+66clsJ60L6NZfDy5i/JpXcpDXnj+E7Qi4qkiKxrzl6YgNw0kNidxvGFFYKjYKJKMEHkshr8tjrrRWK6hU5L0CzsBUJ0nijL6TcT/fbBao1kWzvVBh/W3wVWdT+Wzw3/SK3uk47cQfyrS8UxpvefszvO1v4kfTkc27SjLT88btky3qf44SlPJJXRrOhbZRe1evLjtXadQ/iYr7n/+diB8x+AnVIaSJwt6ul20Gzqql/jducYoJ8BWQWAB6uF8twjxE/UKz2lZrBf5LEo33V876F9LPOB54HIZabZrRTmWUPn0QeCdK5ipQIDAQABAoIBABMwVG3jaJ4+xCzfSYF0mqAmQManpAhMUQ90/spiQ2FPvIEkKeSNvaeyGZtTV2BQRHGDiimya6QZjoDvFgmUW05f0tVp6ZwqFr+ErhzD5ePP3JRkSGFRbuiFlNZ6mCIj6faLT4fnK3d0hkmpq1hOpuqDz939lkHJGP/ShmLkgowZ9go+SyvOXqG+qEpr5rnUwesa0LL9bsjLsrlwWUhvAD08bKASxTaGUPUqZRY/ie4+riE0EBbR58f46mgvd3ctDebSa/ueZetBeFj3wmQn4mVA7/OIB17fqFqHIGCeuHRa5MCAbrSBKUEZyo0Wj/zf+LarJLCnc3kKVzZfETS2GrkCgYEA+MrTcU8kDMGjWi9iTPJxizK8mfmKxEYOvARb/FNoOuA0ZJO9dJfd75jJfNxPb6EXPPaDBVVXH+RhAtXTVjvEmd8lneUA0CPmm70tLtiR3oZm6LEtRayqU5PcGy3iNvQq1KwfFQqYj39wdtgyJGYuWdUMNRzxERVE9CdBJeWSAxkCgYEA6FP0YvoeT94bCKCo2qU4ZUcsPEZ8cJxpF3ZtpNgbzSQBAMmiWFmg5AwWG92AkTZtMZTH1AFFBJ8OuXrhosc4KkHe/0j2KXS/sKkvr/EDp2U5i2aI9wC7e9EC/gaOgQBSujAjtjtL9g5BMlKixg+4RQrwpTFew0KaRUtgvBo2uW0CgYA1Rqm0r+/WU3j5jQAN3jT2S+0bQ9a1ZRMuq/hOtkWxpeVSTFjbqNG7xwoOlNbl3qctRNSVxcqcZ7lmdAeHhdD56lER2MIt0CJH42DTkUjbUAild5tsOidXMmiF4XN5tRue4yTcyqIUyIN6z50dMkxmrDqq/QGaWOWlKurGhLyZsQKBgFBZyOn6a0VgIaVoOz3zan/Mj8YA8sTXs5kDwoQCogre6uHk2psH1JdKftMAVpjiY/2D4WC3V7FzeVo435S2pfwncAKGr2xDDpEA0pddGdBpN++4dKJIxI7cCNbmWZ7QB8yRHajG9UySPYY0AkvR3/8w+22Gl6mcfVJ98WTdBBQ5AoGAQP50xafTlgbBrEznRhTJvtC6/pqFAIbqsVnCn04Up0m5BU0Xox9RhzceEsYu/8F71cu4QI6s97JHUpzoKSIkszDnaeaDbpIef3qRqM8lzfwslWlSHh384ICNGWrqd7/YXRkeZCEkAoaRvowX9KmYUFZ90N+HvSQORw+74B/ipMw=
5a004b20-95d2-484f-b498-abeae47238ab	f63fda1d-362c-44dc-a54b-39994d41b0b8	priority	100
7e43dd9c-2ab0-497c-bea0-af4f01f5214c	f63fda1d-362c-44dc-a54b-39994d41b0b8	keyUse	ENC
a2060b45-a5f0-4d59-8d40-1262261dbef9	f63fda1d-362c-44dc-a54b-39994d41b0b8	algorithm	RSA-OAEP
dd75fa20-4e5b-4a78-a635-022cdd50cea0	31120db4-d46a-4a7d-ad82-503361b89d4c	algorithm	HS512
ec0fb6eb-a9a9-43a1-b6fc-dfb27b81c921	31120db4-d46a-4a7d-ad82-503361b89d4c	kid	45aba61b-492f-48dd-9b34-d198f55b059e
1f1d0774-5304-4e80-8b31-241f5baf708d	31120db4-d46a-4a7d-ad82-503361b89d4c	priority	100
32d58e70-c8ff-496c-b89e-7d843eaf86fb	a34f1e95-0a35-4877-a70b-bb65946036bb	privateKey	MIIEpAIBAAKCAQEAvMdysPWpACg2GqpclbwFX7uP8mJWpf6ad7DUUySwV5xdL58jxw8rQ/IFLBQOWt+VlpoAN8T9MlQ6yd5DAlR8VrD53xEC+aliGNVozGH42++jIfrOAMfPypKJxqUBFihIvmjrqB1cfH7Pc9vRuLdwVXJZFMEzg8K113Uc3hFPsRcLe9FMJl7kV6j8lAjm4uWCuJJ3yqxSdnecpvZn/b4IMT56eR29IJZf4MPQVXBGj/k/SvCBphKirWuKSSzNkRMatQF1otrjxuHdqq1AX6J+lnqhqSqqmm5TxoKT8GZYvoeie3Nw/TXQdqy05xPHmGkhb3eYw+vKytJSMncnO+5vvQIDAQABAoIBACP6lUrRvzB2+XzSjEvDZnjM7A3jnSUM5c67BnSEMRG5jO8XEwAMzY+pEEBK4EOEimOGHVWDt0gA0qWHtVi71mjFWRIhEWKY3EfkYJFXeNEeFobS4LE4Y8t1a0nPR+o7qkWUBJnpYqedmZc4xXtBhujaHs08Vz+c/ABA40wVm40iBYrDzv65oY1Eh2yMe7LHI/FC6h0Aguyjq5IdmJw8Qg0LUuPEmqyY8mCCPzOorYKYWDU/D5PyLFXW1Qdgr6Lo2UyFNM0oCLcZq27ny6T9BegzbfYrQbvxYQf6ytIhm1XnhcE60CE7Rc8pAYIUfysRbC5VqXtAQqUhSgCmSGmp2+ECgYEA8rIMtylbvofVgsb7f1DVPtIaKZJQULMo0Hzfxxr4u88fDN8xddTKhAdwS9dMQE4aS1M2kzAGrT+Uvb+pW7kARcZRrGLYSnR3cG9JBWuJj5dCJl8zOPDv/p+RathJqcR+WRZEfdk0tMJ5wEOW+03FL/mhK77sl4iPxOm4RS5Q5ZECgYEAxyC+cs+vCdZiDKE0N9dcxU0Vf7qbMj37bW2REHzZURIR0gcXwDSiQ3cZQSqsybfQ0KmFGPVkDZ0T80JecI0E4VhZ/CySzvTDeBKXI+kg+vD4JITV7OsbleFKm3ioburkmKq+dnHT+eM4PXKIoQ4IeqmktRVwivttuR1+frEVIW0CgYEAnb2kDhhPjRL0bz+tjx6Wu3ILlyGGGi2YRYokWGDrcgY5BEC9AP0Bc7byAhk5ckJRTMwVGK2KaWh94KaGCRvBVZiE1SqZsiroxqdOKruueSmy0QXnYQcYtcI43d0eY71W8chLVBCs9R/Bynkj1MrDc18opio91G/qIe5W2oA0DEECgYAS+MesYKUopshIs8Mp3tbz5Vg7ByhqLQWbc2jyzTJXSwVvoUVeBqW/D8XUM6Cqx1yZxMzth9O0iFayQoyE5KqmXaiVIhoKpb9J3VuRDFEcF4FM2WsYW34RVZmqHmDN0ItfEEV9O3Max88/632g+plMNoV+y0AhvbrCfFDk+TIuMQKBgQDj7HL7zSeMPsoV4z3m+VEAdrTcY1+kr20BYToEM71B5h+5NabyGa1JelxFBS+hIEzwRgUcHIPGyk9+ZYiLt59u/55m9rY5pw28pJHAok3XCGoXOtZ9fdWvw/V82/EvvVm0Me3ZW9bVWBEOMYZbK+hknPaY2L7HbzHc6/I2hr2jtg==
2960a351-181a-4bdc-9bf4-38555b699417	a34f1e95-0a35-4877-a70b-bb65946036bb	certificate	MIIClTCCAX0CBgGd2une6jANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANwZmUwHhcNMjYwNDI5MjAyMjMzWhcNMzYwNDI5MjAyNDEzWjAOMQwwCgYDVQQDDANwZmUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8x3Kw9akAKDYaqlyVvAVfu4/yYlal/pp3sNRTJLBXnF0vnyPHDytD8gUsFA5a35WWmgA3xP0yVDrJ3kMCVHxWsPnfEQL5qWIY1WjMYfjb76Mh+s4Ax8/KkonGpQEWKEi+aOuoHVx8fs9z29G4t3BVclkUwTODwrXXdRzeEU+xFwt70UwmXuRXqPyUCObi5YK4knfKrFJ2d5ym9mf9vggxPnp5Hb0gll/gw9BVcEaP+T9K8IGmEqKta4pJLM2RExq1AXWi2uPG4d2qrUBfon6WeqGpKqqablPGgpPwZli+h6J7c3D9NdB2rLTnE8eYaSFvd5jD68rK0lIydyc77m+9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIRDzuLVyeBYxVeMlg3NGaX1vjAcrHpTdAGV/D0NsKKrisaeasu185Spaiwhhr4rc8xr+d5JPWzFgwjhwx1gNMQ+4cD1y3X+YxnliRYRfEXHtxYmBPWOnBAY3XpQBBlEt0u81YkDf4g+NQQOAeekLFKHC/bnXrFSbMyZjJrI6/mZ7klz1abdpCCkIJjqWQ5nL1SZKhhxGYCyK5mGL1nhyEym05Uc8eSvQfx6LZ+jiUbzSkfxDweJOtMwdrNaPV+fEBsokCs56NjMai+1zUkIT5VxUYXgQH/rgED6KvWqVxvpMIJbOBPxhn0lFE1gRhnBKSnEzWRTycfqW9/7z8mgsSc=
941ec388-3ed0-405d-855e-032ee55e71eb	a34f1e95-0a35-4877-a70b-bb65946036bb	keyUse	SIG
96eb3d55-8531-4187-a40f-39917c296037	023d224a-e55a-44c0-8567-2be6364251f6	allow-default-scopes	true
12549d23-5c74-4ec2-8e12-e5471df04472	db3bae72-61f1-46be-9ddc-86ffc1ac396d	client-uris-must-match	true
bcca706a-beda-4c73-a62f-7aa7bca8c44e	db3bae72-61f1-46be-9ddc-86ffc1ac396d	host-sending-registration-request-must-match	true
cb1e674a-c52a-4d8e-a424-2ac969934758	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	oidc-address-mapper
ad9954cd-be7c-4862-918a-89374e985580	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
94fc0855-df6d-41cb-82d8-0ec3ae28d59a	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	saml-user-property-mapper
bcbc6f06-5021-4e1a-9d41-aead41d641b6	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	saml-user-attribute-mapper
e729fdcc-7939-4bce-b6cf-07825028a4b3	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	saml-role-list-mapper
e74270db-3af8-4087-bd86-421e30f508dd	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1dfabf54-a56f-43e8-bd3b-a87d863df0d0	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c9950455-f4d8-4602-af8a-ff11cdf2f25e	dac8d778-2eba-4c8b-a6b5-ac495dc4b7b4	allowed-protocol-mapper-types	oidc-full-name-mapper
e48f3543-bc60-4757-8e7a-cac6f217b85a	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	saml-user-attribute-mapper
a50be3c6-8547-45cc-8d88-13eaf7fb08e9	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	oidc-address-mapper
8b4d195f-7a08-4793-aa8f-298450e9bb59	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6bf15f33-22c9-4a06-ac13-55364550f1be	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	oidc-full-name-mapper
8aa53044-ded6-40d5-bcd2-7e469a250bff	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
20d758ac-487d-47da-9620-d1b1816e0d07	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	saml-role-list-mapper
17cf194e-ae48-485b-8340-0b25c370dbe6	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ddf2c882-d344-4e60-839e-7ae48438af9c	f21515c6-527c-4e6b-961f-01a6766c17fc	allowed-protocol-mapper-types	saml-user-property-mapper
e2d9878d-af0e-48fc-a129-6a7c7f31dd35	5308a888-8b71-4c00-bf06-870f81327291	allow-default-scopes	true
70f4a26f-3872-4d8a-96d6-771dc97b3d20	3a438069-03ca-4541-aae3-25703560a322	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.composite_role (composite, child_role) FROM stdin;
04b88942-f33e-495f-b8d3-7a7050554b9c	24aa8963-c4ba-4171-b5c1-04ba6cbb43d5
04b88942-f33e-495f-b8d3-7a7050554b9c	52612d6b-bfc1-4261-a5c8-5db5e55a5d3a
04b88942-f33e-495f-b8d3-7a7050554b9c	25d87257-5840-44cc-8f27-7ae28cb316f3
04b88942-f33e-495f-b8d3-7a7050554b9c	49a0a88b-718a-4fca-8bdd-a1363ccb9eaa
04b88942-f33e-495f-b8d3-7a7050554b9c	92633045-6dc1-4305-92e9-0583ca92548e
04b88942-f33e-495f-b8d3-7a7050554b9c	eb8511b0-b082-4401-a1ee-f98ee028de86
04b88942-f33e-495f-b8d3-7a7050554b9c	a97451ae-b253-4cd6-abe6-988417503874
04b88942-f33e-495f-b8d3-7a7050554b9c	36c9e0c4-b0a8-4122-af31-b0a0e25e8aa7
04b88942-f33e-495f-b8d3-7a7050554b9c	c0b1a8be-e067-4243-8113-ef09fbe8c07f
04b88942-f33e-495f-b8d3-7a7050554b9c	5b1e4565-d8a4-46c7-b4ba-dae4f90f5617
04b88942-f33e-495f-b8d3-7a7050554b9c	7230b80c-c40a-4c3f-bd47-b3dcfa246945
04b88942-f33e-495f-b8d3-7a7050554b9c	ced38682-59ab-471f-a9ab-567e0b67f020
04b88942-f33e-495f-b8d3-7a7050554b9c	aea2dda9-f5be-4932-b0ca-519aaac7b669
04b88942-f33e-495f-b8d3-7a7050554b9c	ba48bd5f-cdde-4b65-a9f3-3c0726ac9a3a
04b88942-f33e-495f-b8d3-7a7050554b9c	415534d2-f4df-4083-87f9-7afa613234c6
04b88942-f33e-495f-b8d3-7a7050554b9c	e46f9035-ed6f-46cd-9231-99fecf2f9090
04b88942-f33e-495f-b8d3-7a7050554b9c	3cd76ce5-bb81-4ef1-9c16-417161a5a088
04b88942-f33e-495f-b8d3-7a7050554b9c	bcf1feef-46ee-4673-b2e7-2b1f972c0854
49a0a88b-718a-4fca-8bdd-a1363ccb9eaa	bcf1feef-46ee-4673-b2e7-2b1f972c0854
49a0a88b-718a-4fca-8bdd-a1363ccb9eaa	415534d2-f4df-4083-87f9-7afa613234c6
92633045-6dc1-4305-92e9-0583ca92548e	e46f9035-ed6f-46cd-9231-99fecf2f9090
c277df1c-ed33-4f5c-a640-c51766d8a67e	ad5955a0-b400-4d51-8fef-87a589fb6dcb
c277df1c-ed33-4f5c-a640-c51766d8a67e	ee4bef42-94f6-4f11-a0f7-48f9e5a505aa
ee4bef42-94f6-4f11-a0f7-48f9e5a505aa	01c0824a-7bcf-491f-bb8c-dbd935e15e84
b5cdc5e1-a48d-447f-9746-5cda51c176a4	a26a2a09-4a31-4bc4-95d9-d27174957d3e
04b88942-f33e-495f-b8d3-7a7050554b9c	0403d83c-9b1c-4557-b29b-7ed679b74b91
c277df1c-ed33-4f5c-a640-c51766d8a67e	73864e8e-6ccc-455c-a9f7-9998000a37aa
c277df1c-ed33-4f5c-a640-c51766d8a67e	124b6ea2-2061-453d-90b6-d800283fda1c
04b88942-f33e-495f-b8d3-7a7050554b9c	aa0961dd-8479-4c7e-ac09-411d7802b4fa
04b88942-f33e-495f-b8d3-7a7050554b9c	62890115-3874-4f7c-9fd7-a2238879bd6c
04b88942-f33e-495f-b8d3-7a7050554b9c	61e1caeb-9c59-49fd-a429-bb67b431ea6e
04b88942-f33e-495f-b8d3-7a7050554b9c	507b47cc-e4dd-4013-8325-25bea7f48083
04b88942-f33e-495f-b8d3-7a7050554b9c	f0421d9a-d77c-433f-8e4e-f825bc0c36bf
04b88942-f33e-495f-b8d3-7a7050554b9c	3da387b9-542a-4edc-9c5f-2545ffc1df00
04b88942-f33e-495f-b8d3-7a7050554b9c	b49d5a33-2dc7-435c-8a02-1723990ba417
04b88942-f33e-495f-b8d3-7a7050554b9c	7df39605-97df-49cf-814d-3fed8b30eaee
04b88942-f33e-495f-b8d3-7a7050554b9c	d1918b80-a57d-406d-a871-9ea7c4e0447b
04b88942-f33e-495f-b8d3-7a7050554b9c	85d28c23-23be-4531-a4a3-6cfb9bfd063b
04b88942-f33e-495f-b8d3-7a7050554b9c	b58a09ab-fd27-4681-8ada-80ef533189e1
04b88942-f33e-495f-b8d3-7a7050554b9c	1c247db8-655e-45f2-9d78-905993e0fdb8
04b88942-f33e-495f-b8d3-7a7050554b9c	2609cea6-4150-4c0a-812f-2638fcfabb47
04b88942-f33e-495f-b8d3-7a7050554b9c	043997aa-657a-4c97-bfee-8cba1432cf27
04b88942-f33e-495f-b8d3-7a7050554b9c	1a8ff3fe-c3e9-4197-8603-b59019384a00
04b88942-f33e-495f-b8d3-7a7050554b9c	d820d268-a16b-4112-9980-71aedf696315
04b88942-f33e-495f-b8d3-7a7050554b9c	e6248379-54f7-4194-9000-6d60f183c071
507b47cc-e4dd-4013-8325-25bea7f48083	1a8ff3fe-c3e9-4197-8603-b59019384a00
61e1caeb-9c59-49fd-a429-bb67b431ea6e	043997aa-657a-4c97-bfee-8cba1432cf27
61e1caeb-9c59-49fd-a429-bb67b431ea6e	e6248379-54f7-4194-9000-6d60f183c071
95afd97a-920b-421d-b9c3-41b893fa53fb	21a6845c-2aff-461e-9ed4-d770f4201115
95afd97a-920b-421d-b9c3-41b893fa53fb	d1b7c582-b9d6-4113-a659-51762ae1a38b
95afd97a-920b-421d-b9c3-41b893fa53fb	474b501b-a527-4b31-a412-dc4aa2112944
95afd97a-920b-421d-b9c3-41b893fa53fb	b44b0ba1-18d5-4338-bad7-657bac3d740a
95afd97a-920b-421d-b9c3-41b893fa53fb	a6c589b8-0c4f-45c5-a8a1-f989abcbdb35
95afd97a-920b-421d-b9c3-41b893fa53fb	5f66ecc3-a73e-4cb2-b640-2b90ae88a890
95afd97a-920b-421d-b9c3-41b893fa53fb	7f1c8611-e898-4e95-8713-cdfeddae0dbe
95afd97a-920b-421d-b9c3-41b893fa53fb	67b0be5f-a35d-410e-b164-4bae7089f025
95afd97a-920b-421d-b9c3-41b893fa53fb	b7b2892d-756c-44ce-8406-893550f49cb5
95afd97a-920b-421d-b9c3-41b893fa53fb	7ffe81f1-7e4b-4dba-aef3-7f84903bee52
95afd97a-920b-421d-b9c3-41b893fa53fb	d2b443ba-1ecf-46ff-9f57-ff58d95fa9b2
95afd97a-920b-421d-b9c3-41b893fa53fb	be474849-f2e4-48e9-b267-aff32bb344af
95afd97a-920b-421d-b9c3-41b893fa53fb	8df67668-fbeb-45c6-84e1-a82f433d74d6
95afd97a-920b-421d-b9c3-41b893fa53fb	25ba4f8b-d52b-4647-9de2-6df39dbfa1a0
95afd97a-920b-421d-b9c3-41b893fa53fb	c84a6e45-12e8-4cfe-96ac-de7d53545f8a
95afd97a-920b-421d-b9c3-41b893fa53fb	d82dff5f-410f-4cf5-a5d1-b8271c8ef09d
95afd97a-920b-421d-b9c3-41b893fa53fb	47c8159a-87df-428a-aae9-3e0db14fcf96
474b501b-a527-4b31-a412-dc4aa2112944	47c8159a-87df-428a-aae9-3e0db14fcf96
474b501b-a527-4b31-a412-dc4aa2112944	25ba4f8b-d52b-4647-9de2-6df39dbfa1a0
ac1849e3-73ba-4266-8b76-242b16a0bc86	0c63c4e2-2977-4099-97bf-2a805e0e7c5f
b44b0ba1-18d5-4338-bad7-657bac3d740a	c84a6e45-12e8-4cfe-96ac-de7d53545f8a
ac1849e3-73ba-4266-8b76-242b16a0bc86	09a3614f-067f-4d65-bc13-78e052cf5d10
09a3614f-067f-4d65-bc13-78e052cf5d10	28572276-49cb-41c9-9689-713926f76b76
6b2f57f1-de0e-4bf6-9525-29b5544aaf97	89755dad-2edb-48b1-95d3-a4acf73770e6
04b88942-f33e-495f-b8d3-7a7050554b9c	d8e33bfe-a4d0-4672-8f1f-59ac95a8e060
95afd97a-920b-421d-b9c3-41b893fa53fb	7c335b26-408e-4bac-9c29-85917b40694c
ac1849e3-73ba-4266-8b76-242b16a0bc86	24995697-a0f6-4175-8adb-a6ae05d41c8f
ac1849e3-73ba-4266-8b76-242b16a0bc86	6c72cac0-c823-483e-967c-330ee01a5f3d
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
59520716-66b2-4e45-93d9-06629dfe419a	\N	password	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	1777494251654	\N	{"value":"3+o6cggunlPg5zAKdRLMST6fWL+NC8ryUui73P5q/4VSCSA3Guz681Nn2syuXNa+2Ya5ZyB9CxhCAHu4SFJmuA==","salt":"V5p/VTohOZCArXK5mzuL6w==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
5145d1cb-2e4d-4138-b08e-46f2c597b07f	\N	password	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	1777494252353	\N	{"value":"DqzfFaQZPdP1uyEnol+QnfFkcmBYk/+qr64At0DJQTZ/rdZxlKzEI057vfIfJPvQdhYXioriDLWin+qqTv3aVA==","salt":"2qLCJ028O/zeAI0biQtncA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
a616032f-340b-4228-a8e6-70dc5e1b9f93	\N	password	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	1777494252913	\N	{"value":"6eCkklEV0ZyLyF3VwmXBZRcFYVC4o/jeVG69DUnNFZXtQhGpI0aMgU4b8GsDv+gMUKmuqiQjBKF/40aOCuxYMQ==","salt":"dLWT4fbwj7SPOwiFBmfEIg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
d818ab29-9ef7-475a-a98b-bc2dca485735	\N	password	20bb810c-509c-48ac-be27-ec55ff54af6d	1777494255609	\N	{"value":"e+DhrS00K/dDqiyISma4wzKDBtprhIFPphwmmXJ2D2PR/01OQM6qUq/8Uz6UZ5SYguyBwUcA6rbEZxRX/jsa9w==","salt":"TB3Xg9sBKWEYC8o8jGhZbA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-04-29 20:23:47.515715	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	7494224991
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-04-29 20:23:47.603566	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	7494224991
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-04-29 20:23:47.808029	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	7494224991
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-04-29 20:23:47.823448	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7494224991
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-04-29 20:23:48.204522	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	7494224991
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-04-29 20:23:48.229566	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	7494224991
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-04-29 20:23:48.569955	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	7494224991
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-04-29 20:23:48.593848	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	7494224991
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-04-29 20:23:48.611647	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	7494224991
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-04-29 20:23:49.099723	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	7494224991
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-04-29 20:23:49.56419	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7494224991
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-04-29 20:23:49.598911	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7494224991
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-04-29 20:23:49.751254	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7494224991
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-29 20:23:49.892712	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	7494224991
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-29 20:23:49.910156	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7494224991
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-29 20:23:49.931117	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	7494224991
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-04-29 20:23:49.953856	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	7494224991
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-04-29 20:23:50.272533	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	7494224991
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-04-29 20:23:50.526319	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	7494224991
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-04-29 20:23:50.557776	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	7494224991
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-29 20:23:55.872824	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	7494224991
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-04-29 20:23:50.575507	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	7494224991
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-04-29 20:23:50.588651	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	7494224991
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-04-29 20:23:50.77497	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	7494224991
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-04-29 20:23:50.796273	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	7494224991
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-04-29 20:23:50.805412	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	7494224991
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-04-29 20:23:50.990023	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	7494224991
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-04-29 20:23:51.371173	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	7494224991
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-04-29 20:23:51.391583	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	7494224991
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-04-29 20:23:51.716589	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	7494224991
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-04-29 20:23:51.835642	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	7494224991
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-04-29 20:23:52.046454	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	7494224991
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-04-29 20:23:52.087286	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	7494224991
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-29 20:23:52.14897	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7494224991
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-29 20:23:52.162758	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	7494224991
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-29 20:23:52.319951	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	7494224991
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-04-29 20:23:52.345648	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	7494224991
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-04-29 20:23:52.371943	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7494224991
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-04-29 20:23:52.421615	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	7494224991
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-04-29 20:23:52.451439	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	7494224991
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-29 20:23:52.466607	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	7494224991
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-29 20:23:52.491131	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	7494224991
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-04-29 20:23:52.551055	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	7494224991
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-04-29 20:23:53.127909	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	7494224991
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-04-29 20:23:53.148411	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	7494224991
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-29 20:23:53.17009	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	7494224991
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-29 20:23:53.211535	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	7494224991
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-29 20:23:53.223133	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	7494224991
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-29 20:23:53.531162	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	7494224991
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-04-29 20:23:53.553384	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	7494224991
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-04-29 20:23:53.716116	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	7494224991
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-04-29 20:23:53.870438	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	7494224991
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-04-29 20:23:53.901984	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-04-29 20:23:53.919061	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	7494224991
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-04-29 20:23:53.931895	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	7494224991
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-29 20:23:53.954796	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	7494224991
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-29 20:23:53.988408	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	7494224991
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-29 20:23:54.078734	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	7494224991
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-04-29 20:23:54.445521	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	7494224991
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-04-29 20:23:54.510066	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	7494224991
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-04-29 20:23:54.521274	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	7494224991
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-04-29 20:23:54.543029	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	7494224991
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-04-29 20:23:54.553238	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	7494224991
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-04-29 20:23:54.560709	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	7494224991
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-04-29 20:23:54.566497	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	7494224991
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-04-29 20:23:54.572917	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	7494224991
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-04-29 20:23:54.597383	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	7494224991
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-04-29 20:23:54.606306	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	7494224991
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-04-29 20:23:54.61497	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	7494224991
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-04-29 20:23:54.675308	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	7494224991
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-04-29 20:23:54.695536	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	7494224991
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-04-29 20:23:54.70785	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	7494224991
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-29 20:23:54.72761	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7494224991
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-29 20:23:54.742109	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7494224991
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-29 20:23:54.749845	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7494224991
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-29 20:23:54.824769	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	7494224991
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-04-29 20:23:54.845812	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	7494224991
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-29 20:23:54.855487	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	7494224991
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-29 20:23:54.858486	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	7494224991
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-29 20:23:54.931737	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	7494224991
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-04-29 20:23:54.94009	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	7494224991
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-29 20:23:54.970358	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	7494224991
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-29 20:23:54.982367	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7494224991
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-29 20:23:55.004563	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7494224991
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-29 20:23:55.011537	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7494224991
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-04-29 20:23:55.02497	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7494224991
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-04-29 20:23:55.043239	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	7494224991
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-04-29 20:23:55.096301	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	7494224991
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-04-29 20:23:55.129185	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	7494224991
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.172568	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	7494224991
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.202534	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	7494224991
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.222428	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7494224991
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.261206	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	7494224991
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.264811	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	7494224991
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.299274	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	7494224991
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.30554	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	7494224991
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-04-29 20:23:55.321279	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	7494224991
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.34526	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7494224991
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.348565	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.385765	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.411013	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.419791	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.445893	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	7494224991
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-04-29 20:23:55.481588	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	7494224991
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-04-29 20:23:55.499993	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	7494224991
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-04-29 20:23:55.519656	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	7494224991
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-04-29 20:23:55.530833	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	7494224991
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-04-29 20:23:55.544378	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	7494224991
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-29 20:23:55.558652	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	7494224991
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-29 20:23:55.561899	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	7494224991
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-04-29 20:23:55.580449	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-04-29 20:23:55.597982	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	7494224991
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-04-29 20:23:55.711465	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	7494224991
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-04-29 20:23:55.717133	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	7494224991
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-04-29 20:23:55.760478	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	7494224991
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-04-29 20:23:55.773818	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	7494224991
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-04-29 20:23:55.79914	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	7494224991
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-04-29 20:23:55.806266	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7494224991
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-29 20:23:55.857972	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	7494224991
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-29 20:23:55.883974	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-04-29 20:23:55.898433	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-29 20:23:55.910552	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	7494224991
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-29 20:23:55.913842	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-04-29 20:23:55.917722	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7494224991
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
ae6d91ea-3c93-4e73-a890-315f220847af	5d282498-e23b-446a-bb2a-8762a123fee1	f
ae6d91ea-3c93-4e73-a890-315f220847af	e52833ca-803d-4cf0-863e-5653d72b6914	t
ae6d91ea-3c93-4e73-a890-315f220847af	1d96c492-2610-4f50-895a-47bb4eaa497a	t
ae6d91ea-3c93-4e73-a890-315f220847af	d85c7381-616b-4e13-b2a6-88447163497e	t
ae6d91ea-3c93-4e73-a890-315f220847af	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315	f
ae6d91ea-3c93-4e73-a890-315f220847af	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8	f
ae6d91ea-3c93-4e73-a890-315f220847af	a128ac5f-a515-47ad-a358-ac4e1875d65c	t
ae6d91ea-3c93-4e73-a890-315f220847af	85e2cbe3-fc11-4693-822f-a1bc476005c3	t
ae6d91ea-3c93-4e73-a890-315f220847af	e80ce24a-5154-4641-b25a-7946accaa355	f
ae6d91ea-3c93-4e73-a890-315f220847af	e5af9ffa-a0b8-4264-990e-9d0e775486da	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	b476d5a5-23fc-41a4-aeeb-25b238feebd7	f
bb68fba0-f9aa-4ada-879f-ab68c527b51b	e9926443-9775-4d3a-b3fd-ec5d4b421c2b	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	40316e2f-4e65-4f3e-9297-1d1b55c9f614	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	67da9fcb-56db-405d-8c0a-ecb4315dad6a	f
bb68fba0-f9aa-4ada-879f-ab68c527b51b	2ba33045-6c73-4108-b9c0-d44c4c7d09ec	f
bb68fba0-f9aa-4ada-879f-ab68c527b51b	e18aa91f-739a-4a21-9baa-d10824062257	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1	t
bb68fba0-f9aa-4ada-879f-ab68c527b51b	cf6c89c1-7006-410e-a19b-809cf10b2d46	f
bb68fba0-f9aa-4ada-879f-ab68c527b51b	ced9d6c0-467f-4799-9232-3be51c6b7755	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
526259fc-a969-4b76-8a00-d60a5814df6a	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777494791486	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
6f7142c2-7e65-4cae-9680-b4c58d2d546d	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	2d8a7e7f-8917-40eb-ad58-af5ddc0b6220	1777495559297	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"8f2784ef-310b-4f43-94c9-8b1df656cefb","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"4d5931e7-e3b8-42e9-af35-a3e370bd5eda","client_auth_method":"client-secret","username":"admin"}
58ebfa20-fc6d-46d0-a2fb-dbf6ec32bac7	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495559768	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
a97d9749-b777-4cf6-9191-03462f5e451f	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495560147	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
d100479b-0dfd-4775-a21c-97648cb3d31e	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495560466	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
1e44fed8-c92f-4e04-97d5-cbe00096fe51	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495560783	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
de3ff087-6c39-47e3-a1c8-eda413407312	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495561110	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
f1276285-5cad-4f11-ad68-4cd984e75ed2	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495561419	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
3c906016-bbd0-40c3-8865-1b8546626fc8	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495561732	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
dacb6a24-f20a-4be3-a06e-3bc4e7fb40e5	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495562045	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
0b295669-c234-46fd-96ff-8d4c7e626594	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495562383	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
df66f565-74c2-4937-a258-3fe2d873e6ce	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495562742	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
2791258e-788f-4e77-b67b-a6c7e26070bb	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495563077	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
e557d93f-4f84-4a87-8865-4a17c149693e	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495563409	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
8a7ef643-8135-467f-a489-09c0110e94fe	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495563729	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
663cb951-2a9d-4a85-9ea6-41855024ce83	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495564068	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
c2f34097-8beb-4413-86da-f79a45ba801e	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495564394	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
3f18827f-55d7-4fd4-967e-54d26309a82b	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495564714	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
dfa45975-2e75-425c-9f7c-837a83360811	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495565041	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
de0e6e7b-5576-4f3f-a0f3-f7ce2ff2ac89	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495565353	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
cd7f0f3a-c904-4f7a-9341-9463f634bcdf	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495565669	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
cb94d3a0-8373-455e-a74a-6c2ac0aa4a1a	admin-cli	\N	invalid_user_credentials	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777495566046	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
937df189-e665-4e3c-bbd2-80c2c810835c	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	c5f7a4d6-e8cc-4b01-a8ee-794c12ecd176	1777496427945	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"f62642e7-782c-4b02-9a11-071f9292955c","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"9a7cfd8d-ef4a-4b94-a1fb-753f7ea4011e","client_auth_method":"client-secret","username":"admin"}
c2d743d4-0daa-4567-ada2-9650334a8667	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	ea10f554-e3ba-4c13-b096-bc64795dd45d	1777496459714	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"1a45d8fb-5efc-4996-aa0a-fb9870434076","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"170fc0e4-a9c9-4af1-9ae9-72f3b3c7c8c9","client_auth_method":"client-secret","username":"admin"}
aa7f9b1b-c345-415b-ac13-f0f570ef54f6	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	fef21807-9cc1-464d-930c-2d62d5e17053	1777593540738	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"4b5fc171-63ac-46f7-a339-0c79cff671c8","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"14896212-a378-4a9b-9f40-c4e516b54aa5","client_auth_method":"client-secret","username":"admin"}
06c72aa4-c1f2-4711-9a8b-d4379b75d4d0	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	675256f4-1082-4377-9f76-6bb3e38dbac6	1777596862280	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"d0210b08-e0ce-42cf-9825-f4dfd1a5386b","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"789e767d-0f4b-4c41-b855-4d0fca1dd073","client_auth_method":"client-secret","username":"admin"}
d56e80f6-d702-43f2-9634-f00c9a9d7035	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	81074a6f-16c8-429c-9c31-bdcb3ad481c8	1777597117423	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"b3641845-1472-4b9c-a37f-e472b96262e3","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"9a763f40-c9ef-467d-81a6-9b25ed9b88ce","client_auth_method":"client-secret","username":"admin"}
3525f200-3e53-469b-a641-658bfd9a1a81	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	ec2f335c-8c53-44e2-a5c4-17926a4086aa	1777598171232	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"f87e100e-ff2b-49de-893e-3acccb5c5abc","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"d3d705ef-3129-4234-bc89-d43f8445df88","client_auth_method":"client-secret","username":"admin"}
5689aa15-a27b-40cb-b756-f0ebd5dfe704	security-admin-console	\N	invalid_request	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777598171316	LOGIN_ERROR	\N	{"response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","response_mode":"query"}
c17bdc35-b003-4269-a3ff-35df752d2490	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	21fb1eee-f422-4fee-ab9f-af1f96121ae6	1777598525694	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"6f8dc774-21f2-4daa-8c67-c2459b93527a","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"6aab3f40-8767-4c91-82bc-60047bb1d91e","client_auth_method":"client-secret","username":"admin"}
d7c4e171-829c-4314-864c-e68a00f63f3a	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	e8b3922f-4ae3-431b-9067-539633d26fdf	1777598551537	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"e8b3922f-4ae3-431b-9067-539633d26fdf","username":"admin"}
c17c6171-b559-41fd-b682-7c71e0398d15	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	e8b3922f-4ae3-431b-9067-539633d26fdf	1777598552052	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"d8eb3db4-2699-4def-bd42-dd7619c6681c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f5f725e4-a9ca-43e4-b12e-c57c5eceeb1e","code_id":"e8b3922f-4ae3-431b-9067-539633d26fdf","client_auth_method":"client-secret"}
ab5e4042-65a9-4db6-8ff6-9d5045625cd8	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	702f1fc2-f93a-4fee-9093-40cf6c5dc5e9	1777600448537	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/#/master","consent":"no_consent_required","code_id":"702f1fc2-f93a-4fee-9093-40cf6c5dc5e9","username":"admin"}
925cdc81-5292-439a-ba19-353e997278e7	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	702f1fc2-f93a-4fee-9093-40cf6c5dc5e9	1777600448942	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"70a70a87-82c3-4acd-ac1b-87e5ef6bf0e3","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"12ecea39-ae9f-4e53-b216-3c019431766e","code_id":"702f1fc2-f93a-4fee-9093-40cf6c5dc5e9","client_auth_method":"client-secret"}
bd956784-9dba-4812-a08f-a0d79a5bdbed	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	16eff175-d6fb-4eae-aecd-121b6edd75d6	1777628571652	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"16eff175-d6fb-4eae-aecd-121b6edd75d6","username":"admin"}
c95aa196-5eb0-451d-81e7-c5d698707dfc	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	16eff175-d6fb-4eae-aecd-121b6edd75d6	1777628572855	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"dec92227-88e1-44bf-a8cb-c30b432b28d1","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"335cadc7-9540-4e27-bf63-469a90e3eef7","code_id":"16eff175-d6fb-4eae-aecd-121b6edd75d6","client_auth_method":"client-secret"}
3167d755-cd3b-4d88-9f73-8d24ff6f2ace	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	15a8898c-bf41-4c6e-9451-b666189437c9	1777630993925	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"15a8898c-bf41-4c6e-9451-b666189437c9","username":"admin"}
5afd9997-fa3b-49a3-9db5-dc04b698975a	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	15a8898c-bf41-4c6e-9451-b666189437c9	1777630994755	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"83cec6fa-c808-433e-8711-c1a2db1d665e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"4185ac3a-cad7-4992-8b38-5b0284289e68","code_id":"15a8898c-bf41-4c6e-9451-b666189437c9","client_auth_method":"client-secret"}
68adca99-3fdc-4b03-a295-6de707ea5556	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	21bc123c-8162-45ca-8a6e-6da127323e16	1777634417371	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/#/pfe","consent":"no_consent_required","code_id":"21bc123c-8162-45ca-8a6e-6da127323e16","username":"admin"}
6ba7ceed-9ebc-42cc-b879-910785abe7f3	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	21bc123c-8162-45ca-8a6e-6da127323e16	1777634417797	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"7564bb39-45b5-4d29-aaf2-d4827bea617e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"c5218e6c-c971-42e9-8199-8db6ee9c3515","code_id":"21bc123c-8162-45ca-8a6e-6da127323e16","client_auth_method":"client-secret"}
1468de5b-4647-4dbe-ab55-536dc370e6de	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	2a42cedf-5ef8-4649-a91e-125fae34a498	1777640088937	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"1b6d0b0e-bc56-4c13-9581-5d51e32f9a92","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"9f657d73-4eb0-47e8-8f71-7c0610395a17","client_auth_method":"client-secret","username":"admin"}
e0aa26f8-5791-433b-a199-eedc5e6cfe66	\N	\N	expired_code	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777643170512	LOGIN_ERROR	\N	{"restart_after_timeout":"true"}
7b70521b-f92d-43a0-a1bf-0927e750f76e	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662333151	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
a67ab7c5-2a47-4ddf-b236-d288f3ecf55e	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662333998	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
b6834279-529d-45a3-bf84-aa74ca581fcc	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662334787	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
83090549-2849-427e-8a98-3174bd0311c8	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662335601	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
f6dfcd94-7d48-455e-9c35-8991e5ec4df5	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662336402	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
ef9028a9-5126-4683-bb15-d236915f6e53	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662337191	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
95f36bd9-dc20-4b38-a650-7e334f78518f	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662337986	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
4b34e64c-79a3-4027-88bd-9a0d74aebae2	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662338768	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
5bf3548e-e812-4e0f-bf4b-9da4b2672ccf	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662339646	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
f6935b0c-45e7-4e8e-aa6c-f263933dd97a	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662340554	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
1dfea8e0-e7e2-421e-85a9-e48ee978a88d	admin-cli	\N	invalid_user_credentials	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662391478	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"admin"}
d00397d5-5efe-4dce-9252-6b302c0c4d6c	admin-cli	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662392018	LOGIN_ERROR	\N	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"alice"}
7b44a870-26fc-4602-9999-0ca91a16a61d	admin-cli	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662392564	LOGIN_ERROR	\N	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"bob"}
27b79435-da05-430d-bce7-1ce0e46785ab	admin-cli	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662393094	LOGIN_ERROR	\N	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"root"}
ed333b64-c6aa-4fd7-a44c-c5e93ed133fe	admin-cli	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777662393626	LOGIN_ERROR	\N	{"auth_method":"openid-connect","grant_type":"password","client_auth_method":"client-secret","username":"test"}
2ee41fcb-a756-4ac1-b3d9-7cb32ede99ba	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	86aeb9cc-0a39-413f-b1bd-df86f9319840	1777670991682	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"86aeb9cc-0a39-413f-b1bd-df86f9319840","username":"admin"}
883f8b43-b3ee-4448-83b2-883442bbc02b	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	86aeb9cc-0a39-413f-b1bd-df86f9319840	1777670992976	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"60f2b9a8-a55a-42ad-8881-7b44aea49444","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"79f27b5d-2b70-491b-9901-efcfa6087a9b","code_id":"86aeb9cc-0a39-413f-b1bd-df86f9319840","client_auth_method":"client-secret"}
615499db-41a9-47ff-a6b5-e2476db8ea06	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	86aeb9cc-0a39-413f-b1bd-df86f9319840	1777671405727	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/#/pfe/roles","consent":"no_consent_required","code_id":"86aeb9cc-0a39-413f-b1bd-df86f9319840","response_mode":"fragment","username":"admin"}
8a0a06aa-12c8-4949-a087-2f31359a7db2	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736352232	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"bob"}
f18c7257-7bf4-4762-ac20-84abdd31b13b	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	86aeb9cc-0a39-413f-b1bd-df86f9319840	1777671406503	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"5acc21cb-40e5-4c0a-a56d-9a42dd381a21","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"80a13b6e-c053-4c2a-a8db-cff613812efc","code_id":"86aeb9cc-0a39-413f-b1bd-df86f9319840","client_auth_method":"client-secret"}
6604eef3-ea91-47ae-a4aa-c340eba861fe	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777672015135	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","username":"admin"}
ffb067ca-ed44-43ce-8a6f-245360da3148	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777672017218	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"25e7fe07-b9fc-43a0-a425-0fe4ac9e3fa0","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"049fa63e-bd52-4d67-b9df-92cd092eb1b6","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
430c4a8b-8e2d-44e8-9247-9192b9c6de81	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777672077766	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
c7030832-e04f-48e7-993a-cb145105c6e3	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777672078268	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"3d7d257a-cebb-409f-a325-f442c6a50a00","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"b3fbe161-91cb-47ad-9601-b4a80fa763db","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
4fcf8735-33e4-4d70-8aa0-318441fa4195	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673560708	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
82858ed6-31f3-4186-9c57-4c391e86c7ef	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673561195	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"acb10d60-f6a8-4e1c-93b1-c030a0e8864d","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"eda8449f-82d0-419b-b821-da485ca74486","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
7c932aaa-b00c-4d3b-a73f-0dfcc82891fc	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673568856	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
db587660-a572-4945-b97a-f99fbfd41591	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673569291	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"233cf381-e6c9-4be8-85eb-f12f02305931","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"431c3675-55ce-4484-bcec-ed5699e0c529","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
09ddd295-5ff9-4107-8747-f08d66dbb2b5	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673584983	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
f39aab8a-5729-493e-9eb8-13cba034a8ef	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673585424	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"68e6fe9f-85ed-44a4-b482-f53ba99b5057","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"a360f293-ef4e-4e43-948f-29e7e344bda1","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
9de28684-49a2-4966-9cb6-8ecd91839387	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673595258	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
f20450d7-c817-4869-b8bf-87d981124482	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777673595642	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"571ffd97-119d-4a4e-8571-2693d5027543","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"96d0a9f4-ee24-4ee7-8021-fbe632c34c0c","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
52934497-a13d-493e-8a25-d2bb6c87acd2	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777674359910	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","response_mode":"fragment","username":"admin"}
ac60f8c9-99d8-43d5-b3a9-d0d9118182cb	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	5b95afb3-24f1-46ac-896b-f529487fdd86	1777674360597	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"cb09cf17-433f-467d-8d94-0dbd5a99fb39","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"be69b5bc-119e-4209-955a-49a0e4bc5d27","code_id":"5b95afb3-24f1-46ac-896b-f529487fdd86","client_auth_method":"client-secret"}
78950687-8056-4eb4-aee7-3677e42fa081	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	647e9f39-737d-461a-b44e-4016e34f3a27	1777711341508	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"647e9f39-737d-461a-b44e-4016e34f3a27","username":"admin"}
59fd0da2-6aed-4042-b941-96aee3744c87	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	647e9f39-737d-461a-b44e-4016e34f3a27	1777711342305	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"2fc92a39-9568-48b8-aa27-749317f371ee","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"cd1378f2-c526-4f75-9e6e-e69cbacd069b","code_id":"647e9f39-737d-461a-b44e-4016e34f3a27","client_auth_method":"client-secret"}
75e89b0f-d34d-42f5-9cec-f9010ea96dae	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	647e9f39-737d-461a-b44e-4016e34f3a27	1777711354951	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"647e9f39-737d-461a-b44e-4016e34f3a27","response_mode":"fragment","username":"admin"}
7df4cc08-8247-41cd-913c-d5730ca9cd4f	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	647e9f39-737d-461a-b44e-4016e34f3a27	1777711371541	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"647e9f39-737d-461a-b44e-4016e34f3a27","response_mode":"fragment","username":"admin"}
f99395c2-49dd-4e0c-8c25-8ce088a0e7df	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	647e9f39-737d-461a-b44e-4016e34f3a27	1777711371883	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"7373538f-38fc-407d-a281-c4eabb79e48f","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"9071b924-c62e-4af4-8b0a-5c0b55b503c5","code_id":"647e9f39-737d-461a-b44e-4016e34f3a27","client_auth_method":"client-secret"}
42b72944-d2ab-41a3-9958-e61e6113377d	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712310173	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","username":"admin"}
24ad9401-b0b2-492c-9c17-f42911618d8d	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712310934	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"2a43e749-3685-402a-ab35-5a5e6ff89eae","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"74b118a7-db77-4a3f-85e9-d42a1d4399c9","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","client_auth_method":"client-secret"}
02ec105d-c1b8-4b8c-a896-68b13b74e458	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712585738	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","response_mode":"fragment","username":"admin"}
d4119beb-6123-4226-b044-634534742abf	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712586299	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"324d7556-7315-44a4-90e4-39e917b4f1cc","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"c1ea8c16-6868-4d78-a091-4f6add51fb93","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","client_auth_method":"client-secret"}
db499ce4-bea5-4a2e-abea-d11aa8a6b465	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712601051	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","response_mode":"fragment","username":"admin"}
9b963c9a-0e60-4565-8d0a-bdb5c8eabfda	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777712601632	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"da12806e-d447-44cd-87a8-83750a3e7d3c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"5988970d-2d1b-4f56-8aec-4d84de16f88c","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","client_auth_method":"client-secret"}
78a25048-c1c3-401e-bc51-5b8793a81729	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f52a7029-1c9e-4d2d-89f6-7f65156c8e32	1777712606224	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"f52a7029-1c9e-4d2d-89f6-7f65156c8e32","response_mode":"query","username":"charlie"}
08f55bb0-f87d-40cf-8466-a112f4c10419	app-ticketing	\N	\N	172.18.0.8	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f52a7029-1c9e-4d2d-89f6-7f65156c8e32	1777712606397	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"e9680804-2590-4b3d-87e7-105236c74f19","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"dcd18674-c918-4f8c-a018-d21a922f73fa","code_id":"f52a7029-1c9e-4d2d-89f6-7f65156c8e32","client_auth_method":"client-secret"}
005f49f7-c37f-4dc0-a36a-36f860d2e92b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f52a7029-1c9e-4d2d-89f6-7f65156c8e32	1777712615035	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"f52a7029-1c9e-4d2d-89f6-7f65156c8e32","response_mode":"query","username":"charlie"}
8dd864c0-d96a-4a84-a014-77393ed9d2fa	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f52a7029-1c9e-4d2d-89f6-7f65156c8e32	1777712615181	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"0e8e337f-d0ae-4d3b-b77e-c1aac538ceac","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"a82b3484-08f6-42a0-a8e4-6fa949231ead","code_id":"f52a7029-1c9e-4d2d-89f6-7f65156c8e32","client_auth_method":"client-secret"}
02856b1b-cdd7-48a7-919a-1c151be14727	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777713845016	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","response_mode":"fragment","username":"admin"}
a5641d56-7384-4f09-a1fe-5f401b8391f2	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777713845480	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"fd0f6b1a-baed-4a88-a98d-a2a9b3d2d886","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"b0b27a11-6932-4ea2-9f87-82cafcfbc67a","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","client_auth_method":"client-secret"}
8489a6e7-30f5-4289-a173-b9862b8c1bd6	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777713848907	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","response_mode":"fragment","username":"admin"}
aca52306-4e52-4796-ac51-0cc669f2be89	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	7119c10b-4b3e-4dd6-9525-020b57b4408b	1777713849311	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"f0fec5e5-63df-4800-87d2-f6bd9da4f8d0","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"5461b8bf-7db8-4f2f-8d96-6b2e97182eb0","code_id":"7119c10b-4b3e-4dd6-9525-020b57b4408b","client_auth_method":"client-secret"}
f2365916-082a-4062-acbe-0eff67a0ae67	\N	\N	expired_code	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777726706981	LOGIN_ERROR	\N	{"restart_after_timeout":"true"}
a4f80863-e9cd-4574-8e48-7190f08423f7	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	21f11967-6f51-4d83-9068-44d5926be856	1777726713171	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"21f11967-6f51-4d83-9068-44d5926be856","username":"admin"}
adcab32c-794e-4d23-9551-aa5544037338	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	21f11967-6f51-4d83-9068-44d5926be856	1777726713615	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"21f11967-6f51-4d83-9068-44d5926be856","response_mode":"fragment","username":"admin"}
5250fe9e-b7f8-435d-bf42-b20a17a36420	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	21f11967-6f51-4d83-9068-44d5926be856	1777726714302	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"6b2c9cbf-a7d8-4dbc-bbb5-b12007a1fa2d","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"a432ca46-690d-4bfa-aa84-d4bd4f108759","code_id":"21f11967-6f51-4d83-9068-44d5926be856","client_auth_method":"client-secret"}
6845a02a-6045-42bd-8abe-6d2853785b19	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	af347742-6762-4935-9c2e-fbc9fe2be2da	1777728400835	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"743c2cee-8d94-40d6-ac2c-4d5798628231","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"8350d171-2905-406f-a7e2-33f854b38bd2","client_auth_method":"client-secret","username":"admin"}
2b6b065b-4fab-4fb9-b173-fe6a3461f571	security-admin-console	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777732044493	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"cfa947f6-4cb9-4715-8c12-e6db8d61be42","username":"alice"}
b3f78c84-794a-4057-90ac-d6e4644ec1ac	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	cfa947f6-4cb9-4715-8c12-e6db8d61be42	1777732053086	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"cfa947f6-4cb9-4715-8c12-e6db8d61be42","username":"admin"}
ad245c9c-1531-49fb-bc67-e225aad4d674	security-admin-console	\N	\N	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	cfa947f6-4cb9-4715-8c12-e6db8d61be42	1777732053981	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"4216c69d-7015-43ff-8974-2a985f929f56","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"94468f05-a062-4c06-a59d-e797aab7a96d","code_id":"cfa947f6-4cb9-4715-8c12-e6db8d61be42","client_auth_method":"client-secret"}
e1c83228-a6d9-4815-8965-23dcf16844f1	app-ticketing	\N	user_not_found	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777733409247	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","username":"admin"}
14f817a2-9e38-432d-94a3-6ddc18d43d61	app-ticketing	\N	user_not_found	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777733414026	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","username":"admin"}
89c57840-b22b-4b69-abb8-0ed58cac15fa	app-ticketing	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e0aebf0f-513a-4ad3-93f4-2bf1cec8892e	1777733425563	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","username":"alice"}
2dd63675-ee3b-4c19-b194-82886bb9fa9d	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e0aebf0f-513a-4ad3-93f4-2bf1cec8892e	1777733425644	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"37158518-ac20-41eb-9d00-24a91032fdaa","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"7cfedb2f-0e11-40a0-8465-d1176e0e603f","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","client_auth_method":"client-secret"}
e4efa02e-d56b-4356-8b48-ecbe1878b7d9	app-audit	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e0aebf0f-513a-4ad3-93f4-2bf1cec8892e	1777733866450	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","response_mode":"query","username":"alice"}
28bbc8e4-be61-41a3-a642-ab10ae5e8255	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e0aebf0f-513a-4ad3-93f4-2bf1cec8892e	1777733866505	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"5aba7572-efe6-41f2-a080-9a29e85de7da","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"9ce1c766-ce42-457b-ae16-bfa34e7dcf26","code_id":"e0aebf0f-513a-4ad3-93f4-2bf1cec8892e","client_auth_method":"client-secret"}
fdc8d0c4-5d44-4205-8e98-6da7360cf6cb	app-ticketing	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e0aebf0f-513a-4ad3-93f4-2bf1cec8892e	1777735146064	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/"}
a099696f-440d-48a3-ab37-e3deaa449e9b	app-ticketing	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d051515b-4588-4457-9fa8-44a1cb46b3ca	1777735470754	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d051515b-4588-4457-9fa8-44a1cb46b3ca","username":"alice"}
b0d8a680-5990-4beb-b002-09fe438544c3	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d051515b-4588-4457-9fa8-44a1cb46b3ca	1777735470799	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"bb1014d4-d985-4ae8-b2a0-c441757dcd91","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"bcddbc69-28e9-40c9-a550-a5f3a73c2d77","code_id":"d051515b-4588-4457-9fa8-44a1cb46b3ca","client_auth_method":"client-secret"}
f007bcb0-5caa-4cbd-86a4-96ac80f6947f	app-ticketing	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d051515b-4588-4457-9fa8-44a1cb46b3ca	1777735479351	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d051515b-4588-4457-9fa8-44a1cb46b3ca","response_mode":"query","username":"alice"}
4871b419-0528-4911-9e8b-7d0af13e4a0b	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d051515b-4588-4457-9fa8-44a1cb46b3ca	1777735479401	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"174b3179-12c8-45f6-98a9-baf8fb47040c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"fa98562d-f22e-4d24-8958-409144ab6318","code_id":"d051515b-4588-4457-9fa8-44a1cb46b3ca","client_auth_method":"client-secret"}
40f8cd08-cd25-4174-a09c-ec377987cbd8	app-iam	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d051515b-4588-4457-9fa8-44a1cb46b3ca	1777735641955	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/"}
418c3101-dee1-4432-b074-822e5c8f8c40	security-admin-console	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777735648892	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"73020fda-1221-452e-a699-03dcdcf20757","username":"alice"}
3b207c62-7f45-4967-859d-c12baf800c7d	security-admin-console	\N	user_not_found	192.168.222.143	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777735655277	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"73020fda-1221-452e-a699-03dcdcf20757","username":"alice"}
1f1edb31-4887-4a1f-b9af-d0e16cfb3edf	app-iam	\N	\N	192.168.222.143	bb68fba0-f9aa-4ada-879f-ab68c527b51b	c9afce76-3bbb-4173-abc8-0a7931ddeec6	1777735674586	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"c9afce76-3bbb-4173-abc8-0a7931ddeec6","username":"charlie"}
a5d405a6-9f58-45ba-a49a-70e896b92545	app-iam	\N	\N	172.18.0.11	bb68fba0-f9aa-4ada-879f-ab68c527b51b	c9afce76-3bbb-4173-abc8-0a7931ddeec6	1777735674710	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"72cffb14-d888-423e-9989-9e159e00a8b8","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"ca6abcbe-4ee8-4254-9381-e5a27089ec55","code_id":"c9afce76-3bbb-4173-abc8-0a7931ddeec6","client_auth_method":"client-secret"}
d25b1fe7-8f48-45fc-8080-041ccea99485	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736186904	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"alice"}
5ff2b953-7ae5-4d1c-bfa6-7a03071965cd	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736195463	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"alice"}
55f6a8b6-c5d8-4693-8882-cac4204e8e2f	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	331cbbcc-ca85-4a09-8e48-81d42433fb12	1777736229412	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"331cbbcc-ca85-4a09-8e48-81d42433fb12","username":"alice"}
a33e8eb5-3a2e-4d29-be3f-0ed6bf83f683	app-iam	\N	\N	172.18.0.11	bb68fba0-f9aa-4ada-879f-ab68c527b51b	331cbbcc-ca85-4a09-8e48-81d42433fb12	1777736229461	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"9624b152-4349-4a41-8667-a734095fd374","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"12e5290e-e947-44ff-b39d-cf5f99149a62","code_id":"331cbbcc-ca85-4a09-8e48-81d42433fb12","client_auth_method":"client-secret"}
cd5e7d83-7ec6-4d89-bc62-267f96fa1cb3	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	331cbbcc-ca85-4a09-8e48-81d42433fb12	1777736241901	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"331cbbcc-ca85-4a09-8e48-81d42433fb12","response_mode":"query","username":"alice"}
919228ac-acc2-4b8b-b011-a52cf1bcf1b0	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	331cbbcc-ca85-4a09-8e48-81d42433fb12	1777736241964	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"4446dab5-8cef-4c5a-bb13-56e3f12e8e92","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"5800cf69-dd00-49ad-b855-a781aa9ec10c","code_id":"331cbbcc-ca85-4a09-8e48-81d42433fb12","client_auth_method":"client-secret"}
b715bcc8-b7c2-41dd-b7da-ecd69e6385be	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	331cbbcc-ca85-4a09-8e48-81d42433fb12	1777736260407	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/"}
cf3e9711-5dff-4eb3-b2ca-0e6a4fb37bcb	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736360137	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"bob"}
6fda4cda-ef90-49a4-aaa9-83ab73167f97	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736369166	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"bob@pfe.local"}
3a5603ef-b36b-4f0a-b62a-d9c4a01963e6	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736397524	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"bob@pfe.local"}
97c5c0cc-e622-4fcb-a571-fdc6bd500594	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736411494	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"bob"}
e18b7e8c-4e89-4894-b842-51234be90b03	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777736421349	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"d74d992e-0544-4ca8-89c0-2c0a1aafdd55","username":"alice"}
a9796ba9-6a40-4d59-b989-e23a3f6f0eb2	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777736445601	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","username":"bob"}
2bfc891a-b55b-45dd-8333-e30d417d5792	app-iam	\N	\N	172.18.0.11	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777736445733	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"5e14dfe2-11b0-4a0a-91b8-f95cfd1b9965","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"dac53561-eabe-4b7b-b91b-21afaa2850c1","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","client_auth_method":"client-secret"}
9a50f2c3-1dc9-454f-b643-514c41a70f2e	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777736460260	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","response_mode":"query","username":"bob"}
5131b6e5-2a0a-49db-83a9-137a43136561	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777736460292	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"7a120bc2-23ae-4f4a-acaf-0ec05b84d171","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"a26f7651-e617-400d-a05c-3fd27581a8c6","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","client_auth_method":"client-secret"}
5e0c2020-11dc-4080-9143-be37336d8d90	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777737120625	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","response_mode":"query","username":"bob"}
8a0d9242-06d2-4cd5-af42-cb1fe8635f11	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	b5c5209c-e13a-4d9c-934f-c8280b6484d4	1777737120663	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"92a16742-66e4-48dd-98ca-09530c293187","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f8a1545a-48da-4d20-a2e0-662ac589f84d","code_id":"b5c5209c-e13a-4d9c-934f-c8280b6484d4","client_auth_method":"client-secret"}
0c816a80-4881-4416-8a98-9afa5198a192	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742193971	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","username":"bob"}
7da534af-06b5-4596-b5e6-3509962b1743	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742194007	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"57a7536c-01ba-42c8-9a2f-b7d03178a7bd","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"a04410a5-3d6b-4fe2-a475-dbdafd9888a7","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
4eb0ef3e-0f6d-4f0e-9e61-bfa91cb23cfd	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742195721	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
e58cf1d0-c726-44eb-a67f-f5e66fc9bf3d	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742196543	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
c6287571-56fd-49c5-b59b-fdef34fc6452	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742196732	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
be863c40-ccd7-4057-80ae-d2b72e7206b0	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742197053	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
7bdbf519-5236-4d1a-9839-ae29053c5931	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742198169	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","response_mode":"query","username":"bob"}
cb0e707d-c2fc-48f9-9d19-b1285241e1d6	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777744472903	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"bba0411a-9fda-49ae-b2e0-5f7bbf4d8a08","username":"alice"}
9a0178bb-4ae6-4564-8726-e39611e164ec	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742198198	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"75b6ee8a-6e3f-4781-a0a1-ee0c71b7670e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"598fb814-557a-468e-95ff-27defcea25f4","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
2f984219-e245-4ccf-a4bd-110d796b9eec	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742199124	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
7795cb35-6853-4577-b19f-f86c8a41a0c2	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742199287	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
2d7bedb0-a12d-433b-8d70-fbc4c1219317	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742199445	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
b4c26255-a615-4283-a717-6d5ffde2d6ae	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742199635	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
e9fb0077-8fb2-44fc-b488-c67c918d69c8	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742244640	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
68ef95e3-4043-43e6-ad4d-6b4d55f2b957	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742252945	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
61b742f2-89cf-434e-87ab-5dc5ffe0220c	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742253125	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
0913038c-8c15-4806-88ff-f55415df97bf	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742253416	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
95b849f7-2a4e-46dc-b01c-65049edf5642	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742253618	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
c4c5f3ac-003b-4e65-9c1f-7e7c45c95f54	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777742253797	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
bfa1e003-ee87-43b1-84b2-3ae653be9d05	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742398327	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","response_mode":"query","username":"bob"}
32106426-2bba-461a-99e5-4a13177a53b5	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742398355	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"65a402b6-59a6-4aaf-9c54-d4c38af75f47","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"6df80eaf-e6e7-4185-b16c-e4e48312507a","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
6498e6ee-4fc2-4d1b-a74e-ca67184f89cf	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742400155	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
e204d39a-6c5c-4082-9b0e-a72b65dea528	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742400769	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
2fccbee3-7e62-4554-af7d-c58b542e74d5	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742400960	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
f41e8c72-6e9d-4d9d-9ca5-652c98706f86	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742401107	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
34b034da-83b3-4081-aed9-064e9528e973	app-audit	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777742401277	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
dfbd0483-85ac-424d-a084-a122027cf2ee	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743085542	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
7e012663-f454-4d5d-a57f-e4a35aa63e16	admin-cli	\N	\N	192.168.222.146	ae6d91ea-3c93-4e73-a890-315f220847af	14fc75bc-3420-4571-b153-ca351c8c4ee7	1777743247741	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"1ec69e6d-a26e-4a89-b607-b422b01b0c32","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"783a8f71-ff42-4b02-acd4-a297feba890d","client_auth_method":"client-secret","username":"admin"}
91bd9e31-ff98-41ff-bf09-257976294815	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743253551	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
729c2d2e-4848-4726-adc0-4a798ef28632	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743260559	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
1352ac02-7374-4fbc-b13c-bbd7774c8925	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743262443	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
0d50fd50-1853-4341-b61a-3e8dba66b173	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743263265	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
e8ddd727-58f9-4add-8207-5946db712786	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777743266984	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","response_mode":"query","username":"bob"}
a7c27853-8f4d-40b2-8c0d-4336ba26837c	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777743267012	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"f3a8857d-1916-4b3f-b940-ef94a3412684","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"820024dd-77a8-4d6d-87b1-39d6c945befa","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
f75fe711-dffa-465b-a87f-a605b27084cb	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743268523	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
18026d4d-4edc-45e3-8bf0-7668869f7270	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743275485	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
4e2c898b-8117-4c55-9838-3ad75c3664ea	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743275707	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
3b37b792-f037-40b6-bd5b-a2535cec999e	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743275891	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
06aac3c3-5b83-4912-a7b9-921a156f0d3b	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743276035	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
17993808-d550-4d5a-b9d7-a35ea98cd31b	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743276220	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
42b9208a-51c7-4e4e-8bed-2b06fe409f14	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777743278471	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","response_mode":"query","username":"bob"}
9326699b-d129-4de0-bb40-96fe16a3508b	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777743278501	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"88be5870-f930-4c0b-9983-2732583483c4","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"986a69a9-0f36-4530-8750-1bd42c931589","code_id":"ed970620-0bbd-435b-80ad-3b7ef7debc43","client_auth_method":"client-secret"}
a3566277-1f3d-4d73-886f-9c61c3c0588e	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743280561	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
196f4dad-6679-4245-82d5-97dc761e9943	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ed970620-0bbd-435b-80ad-3b7ef7debc43	1777743311750	LOGOUT	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"redirect_uri":"https://192.168.222.146/"}
4650a779-6f96-47fa-b377-fe4d75c0e2de	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743340674	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","username":"bob"}
a4678c69-a1ca-4c26-9fa7-96b64e32a323	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743340710	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"24130aef-29ce-45bd-96d6-520f07d95f73","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"c33fdeec-4540-4fc9-b942-bc9867217441","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","client_auth_method":"client-secret"}
4d925ed8-c658-4497-a828-9e72b33861a8	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743342782	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
afba6c5c-bf3c-4370-8501-534a7ceab627	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	b00b173a-5f76-478b-98d7-b0c926ea48a3	1777743636520	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"09785457-4953-4fc9-9a04-5bb279f93fd2","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"78c727cd-f102-4e77-96f8-1b547399ca1c","client_auth_method":"client-secret","username":"admin"}
f0884085-f72c-4710-bac3-d8818cad93a9	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	4d0b25d9-3b84-40d9-afdf-13b625e9370a	1777743787970	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"21b43fde-de8d-40e7-9d4b-68d133ea4ad5","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"6a959ee8-e580-4534-bfd9-17fefd59a204","client_auth_method":"client-secret","username":"admin"}
b21496e1-2b37-44ff-9c65-209f3ed656fb	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743825076	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
5962658b-2d39-4f12-abd2-f2860fba32b8	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743825334	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
23483d35-abb1-425b-bb2d-c62d8d7928e4	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743828843	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","response_mode":"query","username":"bob"}
7460ded6-8a0e-418c-934f-c2151184cae4	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743828877	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"fd8ed565-c78a-4785-9318-d3ee753ec1ef","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"47686681-efe3-4cc8-bfe8-f8e61ea678dd","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","client_auth_method":"client-secret"}
92ea2f4e-ea41-4e5f-8557-493e48cecef2	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743831033	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
2a9b683f-58c4-4393-887d-3cb7264b7c5a	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743833225	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
e7dfd231-3aae-43ba-a0e1-1a884b5a7941	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777743833470	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
139d8eb0-508f-4285-ad7b-63c589593901	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752523350	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
97062ec0-bcbe-4933-8144-839542fd7801	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743835868	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","response_mode":"query","username":"bob"}
d7e43757-6a1a-4f03-98ee-fbd40a911ceb	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777743835901	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"16d9c4e4-69d3-4c9a-b3c6-f689f690326b","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"4376c04e-684f-414d-88bc-e06e29066413","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","client_auth_method":"client-secret"}
0df7786b-40d2-445c-89e9-2a9de6f3bb05	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777744037667	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","response_mode":"query","username":"bob"}
c51e4499-f617-4e20-9681-09c9b3576b7f	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777744037694	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"2d313446-1247-4a0c-8b57-b1bbcc8a971a","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"e1944145-733b-4377-8c4e-9d87865a23dd","code_id":"1c75cf86-aa83-444a-a61b-17f571e2f6c3","client_auth_method":"client-secret"}
efef80d1-08a6-4540-bfce-c2d2506d9b1a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1c75cf86-aa83-444a-a61b-17f571e2f6c3	1777744041715	LOGOUT	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"redirect_uri":"https://192.168.222.146/"}
57cda098-33fc-4b9b-b24c-02e0634dddbc	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744063235	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
e84ea576-b8a3-41c7-b78c-700e1b5a6be0	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744388829	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
c7d4e308-7b14-492f-9afc-ee06b646dadf	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744400450	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","username":"alice"}
0a47166f-2481-4ba4-962b-87c82cf38b4c	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744400484	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"fc247af7-6888-4d31-9e75-ec93b430a744","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"e03bce81-ccb1-43dd-bdea-16ac2aa3cafa","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
0bb1075d-b32d-4822-84da-bc203c354a79	app-iam	\N	invalid_code	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744403278	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
1f1252b4-cae5-42f7-96ea-0f72798a69bb	app-iam	\N	invalid_code	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744403448	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
4fd05a50-472f-4f2f-801e-aad9dfe10f39	app-iam	\N	invalid_code	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744403727	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
a6ffff84-0577-4a28-ac41-b8a0900dd5f1	app-iam	\N	invalid_code	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744404073	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
dc169929-24eb-4c73-a18e-9c39ea615864	app-iam	\N	invalid_code	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744404239	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
80ceacb8-70e5-474b-9a35-b9ca1a63b5ee	\N	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744430948	LOGOUT_ERROR	\N	null
2dc30a61-461b-438c-a9a9-7e3c54a1164d	\N	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744430979	LOGOUT_ERROR	\N	null
788c66e5-301e-41a8-883b-78e1b1d5712e	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744443501	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","response_mode":"query","username":"alice"}
402beb7e-79c8-48e9-922e-36eea962a172	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744443529	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"b870bd33-5772-43d7-904c-8947485841ee","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"8e7c90aa-d365-4572-9dfc-97c55ca79757","code_id":"12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9","client_auth_method":"client-secret"}
01adda81-b392-41ea-b065-681c5f6c3b7d	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	12ad2493-185f-41ac-9e1e-7bcb1a4e4fb9	1777744447349	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/"}
a3050765-27bb-49be-9b5c-8b9f1f50f46b	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777744455427	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"bba0411a-9fda-49ae-b2e0-5f7bbf4d8a08","username":"alice"}
322619e9-8f57-4098-9c12-8b1a6ad740c9	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777744462264	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"bba0411a-9fda-49ae-b2e0-5f7bbf4d8a08","username":"alice"}
1b66e4d3-7c82-4327-92f0-f1ced5fd4f5d	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752523540	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
9c2fbcc1-13f1-4043-849d-034c6000c45f	security-admin-console	\N	user_not_found	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777744479569	LOGIN_ERROR	\N	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"bba0411a-9fda-49ae-b2e0-5f7bbf4d8a08","username":"alice"}
d2f0d459-9171-4f1c-98ae-25e673f6ee14	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744522025	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","username":"alice"}
897d78c0-ae12-47b7-859e-d38774acf2aa	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744522063	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"852f47bc-d97f-418c-9348-a647a4cd5b87","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"4b79e2b1-4369-422b-9aa0-a75240ef9b61","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","client_auth_method":"client-secret"}
8e6303ef-aab7-4fbb-8777-f87848cbfea4	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744522120	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","username":"alice"}
542b3d4f-7ca8-46c2-b539-c2841e6da0eb	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744522161	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"778e5c95-e139-4341-80c0-efe4b749e1a7","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f2e67af4-6199-461c-96f1-b79282d3832a","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","client_auth_method":"client-secret"}
0ed8c218-2dec-4297-918a-61eda10372a6	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744524109	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","username":"alice"}
1b4250a4-bdbd-42f1-9270-39f23178b45b	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744524136	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"784eca00-2e21-4d0b-b402-013b36f127f3","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"59b8cff9-0756-4c6d-b5c2-f7abb27ab5c7","code_id":"28807f93-5bc4-49e9-a402-35e9c2cdfa01","client_auth_method":"client-secret"}
e43d6eec-fab4-42b9-9cb9-0bf80c3c8c0a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	28807f93-5bc4-49e9-a402-35e9c2cdfa01	1777744556645	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/"}
421ed608-fcfb-415e-92d2-cf4b071a3121	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744559665	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
d1f07210-8db9-49fa-970d-c1e26608b358	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	be830496-a075-4944-ace8-17e12744bb3a	1777744594956	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"c3152b34-9b95-4f3b-accf-7d76fc271c9a","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"a2e58abc-b0f0-481f-9d29-a6999fd2cc2d","client_auth_method":"client-secret","username":"admin"}
d849a1f7-e47b-4ff1-9eec-194cc0e3d500	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	86462a9e-bf1e-4d17-b347-836dd6a7edd8	1777744671378	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"86462a9e-bf1e-4d17-b347-836dd6a7edd8","username":"bob"}
6c760ff6-4612-48bf-9e61-ad115aa9b88e	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	86462a9e-bf1e-4d17-b347-836dd6a7edd8	1777744671408	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"795fc8cc-115f-4077-aa87-66edf43bcaa1","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"7713f9dc-91a2-409e-8e6f-512a93df764c","code_id":"86462a9e-bf1e-4d17-b347-836dd6a7edd8","client_auth_method":"client-secret"}
736d44e4-101a-4488-adf3-c6053499a52e	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744816652	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"01512838-6cba-45eb-b595-afefd8440a50","username":"charlie"}
d85bd363-321b-4fb0-a77a-21d6fee95d2a	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744816703	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"5a3ad3c8-0e03-4502-a81f-773885e91f7e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"0205f252-fbcd-4235-ae2d-80b89957fe10","code_id":"01512838-6cba-45eb-b595-afefd8440a50","client_auth_method":"client-secret"}
7d27a602-eb47-4693-bce1-786ea862f4b3	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744825102	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"01512838-6cba-45eb-b595-afefd8440a50","response_mode":"query","username":"charlie"}
c228b48f-4325-4601-8a47-5b8f3ab6c159	app-ticketing	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744825128	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"78295add-8217-4003-9ff8-817d6b3cee8d","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"0e03065a-3319-4c74-a4fc-e75620316d93","code_id":"01512838-6cba-45eb-b595-afefd8440a50","client_auth_method":"client-secret"}
c225404a-c65d-4e81-a983-041fb38b8596	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744829686	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"01512838-6cba-45eb-b595-afefd8440a50","response_mode":"query","username":"charlie"}
b24fdf35-1148-4a9a-87d8-3cc368725b70	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	01512838-6cba-45eb-b595-afefd8440a50	1777744829711	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"616d2948-5eea-459d-a18a-5dac4fc5ece5","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"0001338f-72b1-459f-8b95-092a134e6320","code_id":"01512838-6cba-45eb-b595-afefd8440a50","client_auth_method":"client-secret"}
a2bb7f64-cd93-4479-8354-3e674e906949	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777744863066	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
84112cc1-c37e-4df8-ae30-00fb753711c5	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745017875	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","username":"charlie"}
763a0e16-3ac3-46a7-a6a3-9afcece1d22d	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745017904	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"f3b05928-c6f6-45c6-8526-92534da51b19","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"5aae2afe-6fba-4622-a8d3-3b7a461b85fb","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","client_auth_method":"client-secret"}
c1738779-b9db-46c0-af74-8a10efe32c53	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745051196	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","response_mode":"query","username":"charlie"}
ed16f2f1-6f7f-4d2d-83a1-03f2e5aefca3	app-audit	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745051229	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"aaa958fc-bc66-41a8-8bc1-c6f57f6b6f60","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"d3a171bf-4a48-41db-87a1-7d019a32b81f","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","client_auth_method":"client-secret"}
b1c96bc5-faa8-422b-b86f-2b7d5c9e5bbe	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745074690	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
db7f8766-079f-4747-8c0b-8b62226fda5e	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	fb12e7ac-0051-4bf7-b42e-5ef1f98721d2	1777745247250	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"5276cec0-1334-4717-8933-219818a261cd","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"cc3391ce-acda-4275-85db-eff2c5aab12a","client_auth_method":"client-secret","username":"admin"}
83ea50c3-20eb-45cb-8daf-bcdc78cc82bd	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745295452	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","response_mode":"query","username":"charlie"}
307b68eb-8d20-4fc6-a5cc-831f6d493458	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745295479	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"82e96f45-3b58-4839-8a73-0ded356df62e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"180100de-bf1a-46aa-b173-4ccd2e68f2dd","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","client_auth_method":"client-secret"}
3dd94db0-5155-46f8-a160-29b64a76fb5d	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745303908	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
a94a9730-557c-4926-b935-0690469da3c4	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745307119	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
4af8651c-5fde-472c-ae33-6f142e8d4967	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745309145	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
967d7bc2-c73a-4aa2-8a1a-d35818cfb8bf	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745309494	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
9edc990a-859d-4f48-8da6-33987fe2e216	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745309680	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
27196a1a-3115-4381-8d8f-37952eae5836	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745309851	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
22c63cb4-8440-42a4-b270-81160bdf7dde	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745313899	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","response_mode":"query","username":"charlie"}
f6eb31ea-bd0f-496b-91e8-d6112eeea7f9	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	159c404f-36e1-414d-b1d7-354f9edaf12b	1777745313946	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"6c396ab3-1b8c-45d7-a510-330fd5442f37","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"716df591-fc4e-41d6-8645-762da1a56503","code_id":"159c404f-36e1-414d-b1d7-354f9edaf12b","client_auth_method":"client-secret"}
ddc09486-2f71-4e9e-b252-362152cc2c5a	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777745327279	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
43e08e05-061e-4efc-a277-364918131abd	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	33b9dba2-25ee-4277-9a4b-95e42e07d72b	1777745431442	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"d25df9ba-7ca7-4f7b-a01e-c721c6b95050","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"7541d8ac-4711-473f-bfd7-2bd235fd7d35","client_auth_method":"client-secret","username":"admin"}
92e51929-d4d7-4c92-9922-a5296a0a890e	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	b42b6b4c-5b92-4293-bfb8-f758173a50d2	1777745519957	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"b42b6b4c-5b92-4293-bfb8-f758173a50d2","username":"admin"}
9da360ff-c564-44af-84c6-5e75cb3dae26	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	b42b6b4c-5b92-4293-bfb8-f758173a50d2	1777745520419	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"9cd3d2f5-4fc6-4250-ab74-9c421636e7cb","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"e0c34a92-bdb1-494e-97e7-d5532168c96e","code_id":"b42b6b4c-5b92-4293-bfb8-f758173a50d2","client_auth_method":"client-secret"}
c061c1e7-f2c6-4cd3-afa6-edf567512182	app-ticketing	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752544123	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/ticketing/"}
03e49747-5608-4870-90a9-dca3b00ef8f3	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746336542	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","username":"alice"}
eec9fedd-85a0-4cf9-8771-de252bdb24d6	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746336587	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"4d3bba6f-2c02-458a-96c4-c38301fec6c9","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"128c64fc-9968-464a-86a8-263beaf13725","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","client_auth_method":"client-secret"}
84164194-7e21-412e-bec8-5fce31d66ae8	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746342735	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","response_mode":"query","username":"alice"}
3413a062-a9b4-4b62-9e13-92a02d195974	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777746356310	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
0aac4878-20d5-4a28-90dc-82c7ae6f3a31	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746365223	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","response_mode":"query","username":"alice"}
eb8c8547-5fb6-46cb-8a30-9c358d19aa8e	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746365257	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"a0865002-1f11-41b8-aea4-d7db60d13e4e","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"2d563817-9a57-486d-b445-98620a55cfed","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","client_auth_method":"client-secret"}
fe6b76e7-3a6d-43aa-bf97-274f57180c15	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746368029	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","response_mode":"query","username":"alice"}
34d0e23b-8686-4844-af49-50640fbf2c97	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	fcea4979-460b-4133-b8e3-5a2422209970	1777746373281	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"fcea4979-460b-4133-b8e3-5a2422209970","response_mode":"query","username":"alice"}
a6fffbdd-a4cc-42c8-8ec2-852bc833fe1b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306497	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","username":"charlie"}
49adc2fc-5a10-41fe-96cc-f8b24f95c90d	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306647	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
fea9b729-a745-4ab1-8ab9-3e38059a4bf8	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306838	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
eb9ce3e6-b22c-4709-9ddf-311e7f78de3f	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306875	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c4fa6745-f2e5-4bf8-a582-06fc81787093	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306926	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
97d8530f-c36a-40de-b556-f7a592606790	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747306947	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
406ed3f0-d125-4eb0-acdc-e0a6f8a72232	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307222	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8bbc6f79-fafb-49eb-82c5-40829b8eabf3	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307243	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
5a3267c1-df71-4051-b4ce-5ffa6fa608c7	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307289	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8cb332a4-f2c1-4f4e-81e7-5e8fa17f3fbb	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307312	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
d9189340-08ca-441c-8b24-d802e0f027cc	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307353	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
e1ef3305-97e4-4ef2-90b0-ed73cd305446	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307374	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
1e548b9f-f24e-40a9-99c2-1ca2c188d646	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307528	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
4b557f53-4cff-4ce9-8c4b-2464ce1c07be	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747307548	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
0ecf1c68-2638-4c7d-9d5c-8025c1de381c	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308636	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a129493a-5617-4a08-bfcb-87513a52c6f8	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308797	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
ae84fb05-c012-403d-9448-6b1deb1f9440	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308817	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
f0726657-2fe7-4765-86ff-54af23744b3c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308859	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
9cc6986e-30ce-4590-b460-0976e2d239c1	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308878	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c618fb83-4a47-48b2-bba1-f4486a0d73b3	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308922	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
31a4723c-bfba-49c5-9779-2cf313911ae5	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308941	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a0c927d2-b85a-4c28-8891-6055c5f57dc0	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747308982	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
d87425b5-f6f2-41ab-a65f-62db93be12e6	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747309000	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
7a8c84d5-cd56-4e52-b266-8c47f954f87a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747309040	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
4e4ad062-9cb3-460f-995d-0329458c95f4	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747309058	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
31517506-b3ab-4d50-b8de-79ec31af2693	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747309198	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
75826e1a-6e07-48ce-8b93-aa6d94ae6a64	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747309245	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
aa0f165a-b549-498b-b4fd-53f7fb9a9428	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747311997	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
6bdf8429-2196-4d20-9404-8e1fee2926c5	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752551001	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
cbc83f76-475a-4cce-bf26-92f90f9c0999	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312024	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
9bfbd750-f680-4602-911e-5b70a32ba592	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312074	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
94ecabb7-28de-42e9-ad7e-0f193cd325ab	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312093	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c11bccca-cc96-4345-8bf8-3549a84620f0	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312140	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b0fe9141-6a78-4424-9729-df13cac03157	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312159	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
51ca78f5-74a2-4bbb-8ed5-89a285215bc1	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312199	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
6a6c9563-3bc1-4b51-9982-a9b4694de3f0	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312217	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
ec0729ac-2cea-4bc1-8f31-dccf51210a65	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312378	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b1346d41-201d-418e-bcea-5942b57bcbc3	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312398	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
2b0b0075-98f7-470d-9b2a-b7bb4a8e905a	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312440	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
cd685b02-46a4-4f50-b92f-339a0aa78641	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312459	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
d30a3f76-cf5c-4182-808a-7cdf9a8d29b6	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747312500	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
7b47aeee-084d-4d76-9621-9ed1d6172815	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313623	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8938d3ca-97ea-42e3-bde5-8c2c34ef4312	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313647	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
fb5f219a-27e4-4075-9e24-e44ebbf258cc	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313690	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
d2514789-0cde-4d66-be2d-92991981d21d	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313708	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
fe85d9d9-c0ed-48d3-905b-185678547708	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313763	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
119bb364-ee25-4cc0-93db-6ef39ca561b4	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313785	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
34ffa45d-982b-4b1d-b689-dca158ba310a	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313827	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
f1dc51e5-4444-475f-bce8-49f646f6cb8a	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313847	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
61aa0293-dce1-4c59-b718-61baa25be325	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313888	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
1e35ac6e-0d13-49bb-bf52-9124fa4e7fef	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747313906	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
87e5fd96-affa-4ac0-99ac-36cb541ddab2	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314063	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
388e82aa-2933-4eb6-be3f-7a49c39c01a1	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314081	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
48630a63-3432-4118-827e-23d506e3ba9e	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314126	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
74d347df-dc4c-44db-9a3a-c361276ae0e2	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314145	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
4bdf2e27-626c-4cb7-a569-abc1fc68685b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314195	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
5fe3e25a-65e7-449d-be3c-67cceda67716	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314213	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
aea73e1a-f1fd-40f8-b829-ddebf0aa6ec8	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314253	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b2978dbd-70c2-4f4f-8e02-bdae12e2ae61	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314271	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
8fc75dde-c934-487c-852e-7a2b85a8071e	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314788	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e19aa995-940a-41d9-829d-49dfface996d	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314950	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
c59b7c92-c695-409c-877e-aadf33581e57	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747314968	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
b6b8dc0b-c283-4396-98c5-345524362677	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315014	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8457a588-20da-4246-ba1e-70bc8ad257cc	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315032	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
f006c31a-62e2-450e-bc45-4d0ee7453dce	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315070	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
0a5b735d-0909-4c93-8a8b-fc66f82fb079	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315090	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
0c1e7b59-90d1-4402-884c-2c27033afea5	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315133	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
38180ea5-b0c5-464c-9235-bcc07d003840	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315152	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
23157be5-3d04-4f48-9d09-f1c5e3afb108	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315196	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
9a628adc-e3d2-43de-ad6c-08b2e56f4acc	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315214	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
f5ce2c8f-98fe-4328-b054-2be8ce54b595	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315366	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
40efadf8-b853-42cd-8560-4c4850d33cb0	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747315381	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e81f70f4-785d-4b9e-a72c-d1249ca5fc6a	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316302	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
959da383-f2a6-483d-8a87-403beccd7c39	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316331	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
d1ee9162-1277-4b5a-908b-be6bde5203b4	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316394	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
e943f475-60ae-447a-96de-6f8bd18690fe	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316425	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
726c20c7-ca7e-4981-a18e-3deeb172384c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316480	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b188dd96-fcd5-4172-979e-aac775a2ee1c	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316505	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
4e706282-3f81-4dca-959a-625019f19b44	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316680	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
69d9f055-3afe-4759-91ce-24259a0db0bd	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316702	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
0ea4d472-739f-4516-9c09-3b9071f330fa	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316755	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a22fc2f9-474b-48c5-9aaf-9cea406ecf25	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316781	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a80f0882-39c5-42fb-aea1-7287f12bfa69	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316837	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
00231547-3cbc-4a29-bb56-b361faa119ed	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316861	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
de53da78-7937-4d67-bf25-c52269c6e0b8	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747316938	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a6443de9-2c1e-408a-b04b-d7fe941a8ba8	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318748	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
4756ff01-8a09-44ab-9206-a656bcc56e07	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318768	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
ddd8e045-c698-4c80-b59c-71843e93d22d	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318811	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
5d0b7fd8-8277-4da6-bc8b-16494ca4d21d	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318832	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c37def19-22fe-49a8-8832-59875682482b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318886	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
04038f1f-b4b6-4acb-bed9-131328c103af	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318906	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
010ade18-e0f8-4b3b-8609-05e7c5e78bd8	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318947	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
d2162a80-237f-4795-b0fd-f1df2942d047	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747318966	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
1fd252d3-707b-472c-ab48-82ed7869db6c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319008	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
bad40198-43a5-41e8-b52b-b453d2f5b55c	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319024	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
6d42e082-80a8-4917-8bbf-fac3e21bf14d	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319065	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
7785a240-a9ac-4c9e-989e-71974b6a6638	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319084	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
7d412c0f-e205-4bc3-bbdd-9413dd89a2a4	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319123	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
c6ff05aa-4350-414a-8b7d-335fb3c3cc3b	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319139	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e395ba48-14a2-499a-9438-d75404756006	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319928	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b6afee61-7114-42ef-9734-68f9a9b4ba33	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319945	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
eaf7d8bc-6196-43f5-bff6-b65c60a2b33f	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747319987	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
6033a916-571a-4980-8588-f7f70fcc7960	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320005	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
43c4928f-a50e-44f4-a064-c23c9895336c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320044	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
4ebc97d9-5d16-4a85-a292-86939553390c	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320060	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
7bee8bd0-386c-4e98-bb1f-d55ef9ac27d6	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320101	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
d606df95-5107-4726-ba6e-8097376672de	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320119	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e38c4871-4575-4966-ab12-c69af133db6c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320158	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
0f108402-ddb9-48bf-afb0-041a1be06054	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320176	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
2b10cf65-dbc7-44e8-8f0c-1bf2dbbef0d7	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320215	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
6e435f14-63ef-4269-b053-1b537045863c	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320234	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
91101e1f-d4e7-4a7f-9120-ab57a75cce81	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320272	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
9f4d1d09-22e7-46b0-a2f9-ade12bed8bb2	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747320289	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
909ab990-56d8-47b7-b13c-512f90a9e7d9	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321108	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
591b8532-2d0c-4d3e-bf7c-a902bd5b8be2	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321131	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
8bc9cfd1-1e89-40da-b905-f2e095f414a9	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321173	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
984db544-f37e-490e-aa0a-0eb418fb4b11	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321193	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
0321355b-7ef3-4ffb-ad7e-0958740cd915	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321239	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
7325f925-6f95-45b9-8cda-cc76276b27ef	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321256	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e593e395-6528-446a-abd0-fec5dcd57c88	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321305	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
06fa8e77-ed01-47f6-b1d3-3b6b0ebce18e	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321328	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
06beaf80-153f-4e0d-9e4e-327538f687bc	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321368	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
1ed6dcff-25a7-4330-be65-b6b3effacd2a	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321384	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a80513ae-a949-4864-b928-54f7a6ca583a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321427	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
e7caba5e-8f75-41d0-b518-1768b0d9fcc8	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321552	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c90fabd5-db9c-40a1-a8a3-7f85aed6d93e	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321592	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b8c8fdaf-86a2-4995-bc74-31723582f972	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321609	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
390de4eb-ddb0-4392-a1b3-a476a289558b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321768	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
4d059cb5-a239-4303-9250-59be49ae493f	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321786	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
d8695577-dc34-4436-b3f6-5710962cdfb3	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321828	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
23850b95-097e-47b2-9165-5d966b4b3293	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747321845	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
4b7b06fa-56e1-4785-be60-4535409f3447	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747322008	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
87f83dfc-509a-4548-84b1-b8de03fdfbcd	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747322025	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
75ad3574-6213-4ce6-b33a-abf8c4da6dec	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747322068	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
862b890a-fb35-468a-b24d-37fd64bd4fd3	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747322088	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
2efa1219-860b-473b-942b-81dfe8404f28	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747323895	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
416122ca-e60c-4bb0-b057-aff308127931	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747323913	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
4e0dd67a-3993-4a55-badf-4778f4f11db4	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747323959	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
952666ac-52b0-4890-a3c9-9c897135cdda	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747323976	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c5968c7b-10f9-4157-84a4-cc8ed0aa0d22	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324124	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
9260202a-c9a1-4797-8326-80d3394b1b48	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324142	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
78a0cbbd-93c2-47c3-bfa4-b8e51fab11f2	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324180	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
e8575c1a-488b-4262-985f-3342b290437e	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324200	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
644b5d4e-980e-4d17-adc3-f46b81ad56a7	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324238	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
229c86d4-94a2-4b63-96ae-5e479274bf21	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324259	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
399e120a-0c99-4418-ad57-687f89ca947f	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324300	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
9f61082b-6bbc-46fa-b736-c040eaad8d6e	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747324319	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
d883f267-0ef8-473c-a56a-c5a25eb44673	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325437	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
006b8d65-92a1-4998-a73f-365b7b5c3bbc	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325456	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
88a0fbe9-2aab-4043-abc6-90987f06bf12	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325498	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
ae084b00-1853-4204-92f8-5223bb80219b	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325514	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
7b813126-d3dc-4308-8da0-4c6bf69197c9	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325554	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
75442efc-22ac-48a1-93ff-5b27ac7cba58	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325573	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
f11f24eb-53a6-477c-ae0a-a17891ba36f4	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325730	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
1a324728-4a22-4794-bfca-9babb7762251	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325747	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
57dae6ce-a791-45ca-b184-22023d6e4a2e	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325790	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
20a84db9-eaaf-4aae-90ae-ff764c74bd6a	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325807	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
fe53bd1c-e1a0-4d43-9c79-aa80efcb6018	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325853	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
33845519-3218-4335-81f8-c12caa95d342	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325871	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
80c61b04-a142-43d4-9efc-58729f43cda9	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747325914	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8f903cf6-e4fa-4773-b21b-844179f7d933	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747332522	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
fcde2499-7cff-46bd-ba63-88582cdcab12	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747337042	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
d5b455a0-dd7d-4875-8e37-fc8547547ebb	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747337339	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
513227df-7f61-4f07-bbed-4b7bb4ad1f73	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747337588	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
73ead9c8-06b4-4fec-b0e8-a87899d7d3da	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747337798	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
61f7baf6-7d0f-4e38-bfad-454ac045f8e1	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747337959	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
437866de-f9bc-414e-825f-1f64a625e51c	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747338303	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
4117d65a-f552-46a3-b70f-13e980bfc914	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747338551	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
04af59e8-7c41-4c5d-b856-118c4f2362e9	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747338784	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
d823fa10-2508-4c1e-a12b-0a7e41de9575	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747338912	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
189b322e-e273-4996-ac60-05684567eeb9	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747339131	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
df5ef8fa-18c8-47c1-809f-27519dd4a2d8	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747339267	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
141dafda-3faf-43f0-9aea-709b1c04a20e	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747339538	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
12204c1b-8fd7-4d38-8399-eb30102f6cac	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777747339967	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
196f1951-a335-4cec-9cfb-5b709c03185c	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383408	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
581baee7-9038-4507-9d37-57fdc1f0a245	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383426	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
f8fe7588-affd-42d0-ad38-cd2a0131fcd1	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383468	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
2bbaf102-0e67-452f-b9a6-7e2e216949b7	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383486	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
0fa4877b-732e-4711-b12c-79526f1c55fd	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383528	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
03370eec-afdc-44cc-9be4-4c3cadcc767f	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383546	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
134db435-74b8-413f-995f-3cfd1f0c52bf	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383587	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
232b0841-6162-41c1-b08d-02e78c17a74f	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383604	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a3cf2852-11c6-482c-9666-c56be8692876	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383645	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a027d575-98ae-474a-abd7-84baa418449b	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383662	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c470ceef-3239-4d66-9440-2b677e4feca2	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383806	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
91becbd8-b851-477a-af68-5076c9d5b481	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747383825	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
36598e97-6d91-4478-a8a0-3c11c86d44fa	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385051	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
b9ec1ba5-e9c5-49ec-9058-482991545dad	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385066	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
5971c973-759b-4bdc-88a8-3b95e6add69a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385104	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
8c8aecc6-29ca-492a-87ed-722c225ab012	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385123	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
a2d98dbe-9526-44be-9157-a701445ecce2	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385161	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
41f6999e-ca97-4bdd-bf81-e2af45dbe6f8	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385179	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
08d100f4-7819-43bf-a289-22f3b50e02f6	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385222	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
75b76365-146f-413a-ad4e-e9a40d1c8803	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385240	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
5a23bf4d-9dc5-4d29-bbc5-22ddd0834a6b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385281	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
1080e863-96a9-4bcc-ae3d-c6e2b7f3a11e	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385300	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
eebff1f0-6a2a-4651-beac-85b84fea870d	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385458	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a55b59af-fc00-4fe5-b651-bc8513997302	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385475	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
af3d4caa-d154-4fa2-af52-a4c2fdcfc152	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747385517	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
0b7a92ad-b59d-463a-a5a3-7d624714e612	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390682	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
6fab7c0e-1bd3-41c8-9f1b-a9755c59d23b	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390706	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
858ced7c-ed59-4683-a23f-dc54c06c388d	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390749	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
d98505a3-9b34-4225-b2d6-bf3829b29b94	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390767	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
de27ad3e-e394-4c51-883f-edbc4e797fca	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390814	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
fcedb5aa-d378-464e-aa70-7339844c72f1	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390836	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c52e7f57-0167-4731-923a-ad598872a771	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390880	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a9a2cfa9-09e7-4c78-8502-f9a0246a7897	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390901	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
2461dde9-597f-44a0-a9d8-7f3747304c53	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747390966	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
032a383d-a160-4a38-8cd6-f994b5779bd6	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391142	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
ada5b616-c211-409e-9729-afd0e8f9be75	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391254	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
c45f1a6e-82ea-4393-9a43-495c5cdb08a2	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391279	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
16a599fe-7d28-4a1f-8bfd-a140cd30562b	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391341	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
df224f4c-25b6-42b3-aa93-12650d059528	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391359	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
4818f410-498c-4964-b01f-54fcc6bfdaff	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391902	CODE_TO_TOKEN_ERROR	\N	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
e65d767e-c7df-4f49-9099-34abf88a8a33	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391946	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
5f0f4c88-c365-4aa6-a58c-e836a846632d	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747391962	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
324dcda9-50fa-4237-a9b0-4510b31a8be2	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392002	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
5385ea06-673a-427c-9a06-e1e3752be11a	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392021	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
1cc83de0-9328-4d26-9bf9-e50b97ad77e5	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392061	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a65de10b-492c-424b-9029-17a3e09dfb98	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392081	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
05c27417-a1ad-42d6-863c-fdb39a782fd8	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392138	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
a75b6855-847d-4fa2-906a-2a5571900be0	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392178	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
828cd4c9-094d-4456-a7b0-6a94ffd7573a	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392254	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
df604b24-f2a7-4275-9820-a7ce1b1ae064	app-audit	\N	invalid_code	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392289	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
c8959f5b-6936-44a9-9159-cb9b987ba745	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392371	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d48475bc-520b-444a-9844-d345762e5a26","response_mode":"query","username":"charlie"}
762ce050-f693-4bb6-b69e-99b766377587	app-ticketing	\N	invalid_code	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d48475bc-520b-444a-9844-d345762e5a26	1777747392404	CODE_TO_TOKEN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"grant_type":"authorization_code","code_id":"d48475bc-520b-444a-9844-d345762e5a26","client_auth_method":"client-secret"}
838e480b-a821-4527-b3e4-e752252f7ef8	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749567355	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","username":"alice"}
f5373879-8a9e-4402-97cf-f3b637bb493f	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749567384	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"67cc34ea-357f-4f1f-8792-eac0096cdb05","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"9ee39904-aa9b-4da9-aec5-b249cba1d96e","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","client_auth_method":"client-secret"}
aae6e7c3-6cf1-46b5-85cd-29b9d51d69f1	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749577645	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","response_mode":"query","username":"alice"}
b4509b8a-2eb1-4e1b-a522-a81619256041	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749577681	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"a559cc72-eccf-4919-8a1f-9e5da631374c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"d2641faa-87dc-41db-9b44-97dcad0d5dde","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","client_auth_method":"client-secret"}
1008b99b-5c17-421a-b1d1-04e6da18feec	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749581154	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","response_mode":"query","username":"alice"}
a0615e7b-67e3-4610-9c32-103f7aa2c43d	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749581180	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"fbcd4bff-96b7-4824-9342-24337a1d05ce","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"b6822ab3-0fba-4786-9265-0ca4f6f94458","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","client_auth_method":"client-secret"}
e303fa67-47e7-409a-928e-1f9e439b5ae3	app-audit	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777749599654	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/audit/"}
2f200ad3-a3d1-41d7-990e-59b52e1c346d	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749606190	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","response_mode":"query","username":"alice"}
846c2b8c-de98-48d4-91fc-264af3d26324	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc09033-29f3-48c3-81c1-a3acf5d1ceed	1777749606227	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"b8d9b004-9907-4913-915c-8660f652ecda","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"d4393c0a-7835-453b-b13a-8332189d9e4a","code_id":"8bc09033-29f3-48c3-81c1-a3acf5d1ceed","client_auth_method":"client-secret"}
68c3fccc-4674-4e10-9cc6-12a843e30958	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777749647929	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
8cea1100-95b0-4a62-932e-aaed9681655c	security-admin-console	\N	invalid_user_credentials	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	\N	1777749809486	LOGIN_ERROR	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","code_id":"e5ea91e0-a111-47e3-888b-617ecff6846a","username":"admin"}
95542151-d8ef-43fb-ba7e-215bed54d5b2	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	e5ea91e0-a111-47e3-888b-617ecff6846a	1777749813239	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/auth/admin/master/console/","consent":"no_consent_required","code_id":"e5ea91e0-a111-47e3-888b-617ecff6846a","username":"admin"}
85897305-1fab-49e6-8aac-e21529aeca54	security-admin-console	\N	\N	192.168.222.1	ae6d91ea-3c93-4e73-a890-315f220847af	e5ea91e0-a111-47e3-888b-617ecff6846a	1777749813844	CODE_TO_TOKEN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"token_id":"98813be8-1330-441f-ae8e-d8430fed2e78","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f0f3775d-c43f-4dea-afe3-365e0f6b609c","code_id":"e5ea91e0-a111-47e3-888b-617ecff6846a","client_auth_method":"client-secret"}
b5d9124f-4fd2-46ae-bf97-f81e2b8f9adc	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777749835548	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
dd9584e6-b4dc-4c9c-8d4e-ff9b0282be83	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	9ec5489e-e7f3-428a-a745-8f9a90b3f28b	1777749850011	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"9ec5489e-e7f3-428a-a745-8f9a90b3f28b","username":"alice"}
6e677ccf-586b-4d6c-920c-62e48733aab2	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	9ec5489e-e7f3-428a-a745-8f9a90b3f28b	1777749850032	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"d565f475-4348-43ba-8878-54d17c3702b0","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"1d451e0e-80a8-4a8e-ae2e-fe49f498de10","code_id":"9ec5489e-e7f3-428a-a745-8f9a90b3f28b","client_auth_method":"client-secret"}
a22c6b43-4ec1-4b55-bb34-aa4fff04595a	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	93abec5c-f4fb-4602-99cf-0902578dae85	1777752251934	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"908d5ef7-95ec-46b2-8592-45f6b059edbc","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"85d39401-b56a-4b2c-9d34-a4d3dc31c8bd","client_auth_method":"client-secret","username":"admin"}
fbf40e95-9e6f-40b4-9998-41150ce47089	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	15a9b280-d213-4607-930b-c031391bde75	1777752406695	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"ba5deb9d-7599-49d4-8ae6-f3a78e96f6e3","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"43bc7fba-e0e8-4ff8-85a9-0ef4be841efc","client_auth_method":"client-secret","username":"admin"}
f5ab3984-626f-4015-a4cc-913933893ab6	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752484879	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","username":"charlie"}
015cb172-d142-45c0-913b-fc5bf2a8a560	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752484909	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"6d589bf2-9b69-47df-b019-e009c9aabc14","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"6ccac32f-de27-4ebe-a39b-506b907a4cf7","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","client_auth_method":"client-secret"}
ff5298fe-4268-408f-b54d-7cff00ec844e	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752499605	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","response_mode":"query","username":"charlie"}
7da496eb-8eb6-4cb1-b932-25fbcd8ea330	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752499631	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"167c9fda-3d01-4638-8f6a-b6cc6565c0d6","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"e9553734-a6f0-4e69-89d2-56b27c083bbf","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","client_auth_method":"client-secret"}
34272313-8273-4c49-ad66-b04d8e9c2bd3	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752503510	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","response_mode":"query","username":"charlie"}
63b0f958-6daa-443b-8bde-0b54b1865420	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f05e8856-9456-4edd-9c26-07d95643505a	1777752503531	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"7eab39fb-1ad4-474b-814f-cbe46bf2a6a0","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"0cd544e7-1f39-440a-81d9-a13adb4b6778","code_id":"f05e8856-9456-4edd-9c26-07d95643505a","client_auth_method":"client-secret"}
e0cfca7a-891e-4bb5-8585-bb274d79bcf3	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752518981	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
8855e9b9-c97f-42e5-96a2-525d84b37ac2	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752522187	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
ccd806c3-cb67-458d-ad06-c6a5807225ac	app-iam	\N	invalid_redirect_uri	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752523126	LOGOUT_ERROR	\N	{"redirect_uri":"https://192.168.222.146/iam/"}
11839060-9e59-494c-b4f3-fb7f039fcdb9	admin-cli	\N	\N	172.18.0.1	ae6d91ea-3c93-4e73-a890-315f220847af	1e06bc96-e8f4-407d-aae5-aded3e111166	1777752628774	LOGIN	20bb810c-509c-48ac-be27-ec55ff54af6d	{"auth_method":"openid-connect","token_id":"98c69423-b9c8-4a7d-a297-9ffe877a524e","grant_type":"password","refresh_token_type":"Refresh","scope":"profile email","refresh_token_id":"11947efb-72c9-4962-a985-59d4a15e4920","client_auth_method":"client-secret","username":"admin"}
10780dd8-065d-4a55-87f1-78eb013e7202	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	da5f0260-458f-44d0-ad70-acf77f035b08	1777752698294	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"da5f0260-458f-44d0-ad70-acf77f035b08","username":"alice"}
5c834bf9-b139-4128-8b49-cd81a02aa13a	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	da5f0260-458f-44d0-ad70-acf77f035b08	1777752698319	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"34a28206-5f90-44fe-a188-f447c9447707","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"fb80e9e0-d5e1-4548-941d-735428a58c90","code_id":"da5f0260-458f-44d0-ad70-acf77f035b08","client_auth_method":"client-secret"}
c739429f-084a-4c4e-a719-c6c770c3af6d	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	da5f0260-458f-44d0-ad70-acf77f035b08	1777752702926	LOGIN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"da5f0260-458f-44d0-ad70-acf77f035b08","response_mode":"query","username":"alice"}
417cbc6f-703e-4899-8a61-7e31b15375ae	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	da5f0260-458f-44d0-ad70-acf77f035b08	1777752702951	CODE_TO_TOKEN	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"token_id":"52c304f3-b3ab-480a-b0a1-afc2eb1dba87","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"c3e90489-2217-45b9-a9a7-be3a009e0473","code_id":"da5f0260-458f-44d0-ad70-acf77f035b08","client_auth_method":"client-secret"}
8e3cfd92-f2b2-48a6-93a9-95380674afd4	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	da5f0260-458f-44d0-ad70-acf77f035b08	1777752711103	LOGOUT	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	{"redirect_uri":"https://192.168.222.146/iam/"}
3427502b-754a-47e8-acaa-706c98e21a4a	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	086ecfee-deb0-48c0-b734-a557af3002a4	1777752720797	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"086ecfee-deb0-48c0-b734-a557af3002a4","username":"charlie"}
9743085a-076b-4f28-a7ef-20e40cea0037	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	086ecfee-deb0-48c0-b734-a557af3002a4	1777752720820	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"8164ccc2-511a-4da7-ba2d-ba1364d377b0","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"8c7b4107-5546-4d79-b6a0-15421bfad227","code_id":"086ecfee-deb0-48c0-b734-a557af3002a4","client_auth_method":"client-secret"}
964602ed-35f2-4120-a007-d71697a1b8dc	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	086ecfee-deb0-48c0-b734-a557af3002a4	1777752722764	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"086ecfee-deb0-48c0-b734-a557af3002a4","response_mode":"query","username":"charlie"}
c4bba983-b4b0-4de4-95cc-a60cbfa7eecc	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	086ecfee-deb0-48c0-b734-a557af3002a4	1777752722794	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"00abd2ae-caef-4489-afb7-8cf87b477a18","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"7e4c27e8-3387-4a0a-9d71-abac1974d63a","code_id":"086ecfee-deb0-48c0-b734-a557af3002a4","client_auth_method":"client-secret"}
50ea93c5-c50e-44f2-852b-3510c2cc70be	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	086ecfee-deb0-48c0-b734-a557af3002a4	1777752724374	LOGOUT	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"redirect_uri":"https://192.168.222.146/ticketing/"}
813e8f9a-1b5b-4182-841c-4038979c39e1	app-ticketing	\N	invalid_user_credentials	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752735186	LOGIN_ERROR	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","code_id":"d871255e-e215-4613-95ed-8562eb80150b","username":"charlie"}
96f0b58c-380a-4193-8a65-9baa58d510b9	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d871255e-e215-4613-95ed-8562eb80150b	1777752739707	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d871255e-e215-4613-95ed-8562eb80150b","username":"charlie"}
381089ad-9e9e-4c54-a929-b7b96d306d3b	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d871255e-e215-4613-95ed-8562eb80150b	1777752739729	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"e2a4b26d-dd9b-47f1-b9bd-683648cea21f","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"3ee6310e-a010-46c7-98b5-1aeb3afa604a","code_id":"d871255e-e215-4613-95ed-8562eb80150b","client_auth_method":"client-secret"}
98804114-1024-498a-8d47-1ba61bac62ad	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d871255e-e215-4613-95ed-8562eb80150b	1777752741776	LOGOUT	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"redirect_uri":"https://192.168.222.146/ticketing/"}
81d5470e-5235-40a1-995d-7b640e9f29bb	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	75a43a41-a430-44da-b5fb-d430db150c25	1777752750707	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"75a43a41-a430-44da-b5fb-d430db150c25","username":"charlie"}
ffcdc436-33f0-4c0c-b083-d0795274b747	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	75a43a41-a430-44da-b5fb-d430db150c25	1777752750740	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"7199e56e-5467-4951-b53c-a5856724f545","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"85e03a6e-94ac-4c98-bec3-4bcbf631a104","code_id":"75a43a41-a430-44da-b5fb-d430db150c25","client_auth_method":"client-secret"}
7a82f449-fda0-44e0-8bff-ab856092ab81	\N	\N	cookie_not_found	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752758020	LOGIN_ERROR	\N	null
e17998be-f5b2-495f-8d0d-86ae7cb1e1cb	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	75a43a41-a430-44da-b5fb-d430db150c25	1777752758896	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"75a43a41-a430-44da-b5fb-d430db150c25","response_mode":"query","username":"charlie"}
7eb23274-3e08-4189-870f-2bdbb47cabef	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	75a43a41-a430-44da-b5fb-d430db150c25	1777752758919	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"69ea9ac7-4397-462a-bf93-5e821cfe94f3","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"61f27d28-517e-4fea-9efa-d94f41cc72b7","code_id":"75a43a41-a430-44da-b5fb-d430db150c25","client_auth_method":"client-secret"}
fe3ece51-79dd-42dc-a004-9c533324b804	\N	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752772961	LOGOUT_ERROR	\N	{"code_id":"7f3b2d29-7e09-4ab9-bea4-ca21e4a597c2"}
bd50468c-0377-41a6-b5d3-bd681e3c9f5d	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	75a43a41-a430-44da-b5fb-d430db150c25	1777752772966	LOGOUT	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"redirect_uri":"https://192.168.222.146/iam/"}
68cd9d5e-cfdf-4424-92e0-42a7a9160c6f	app-audit	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752782241	LOGOUT_ERROR	\N	null
f78ef9d8-bcbc-4480-ae23-32358213e433	app-ticketing	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777752794583	LOGOUT_ERROR	\N	null
7e4581b2-5900-48dc-8fdc-052e2e719a6e	app-iam	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	61334955-ffb5-40a2-b7eb-3472872de1e5	1777754197362	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/iam/callback","consent":"no_consent_required","code_id":"61334955-ffb5-40a2-b7eb-3472872de1e5","username":"bob"}
f84545f5-0e3c-41a4-b548-51eb9c5bb79a	app-iam	\N	\N	172.18.0.10	bb68fba0-f9aa-4ada-879f-ab68c527b51b	61334955-ffb5-40a2-b7eb-3472872de1e5	1777754197392	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"58b49b39-3a87-489b-8cb1-f77ccd76ae8c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"5953524b-4216-474a-8453-bd46a00d7f7d","code_id":"61334955-ffb5-40a2-b7eb-3472872de1e5","client_auth_method":"client-secret"}
23a8ac40-fda0-4ba4-a029-d3e3b2a8c7e8	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	61334955-ffb5-40a2-b7eb-3472872de1e5	1777754204724	LOGIN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"auth_method":"openid-connect","auth_type":"code","response_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"61334955-ffb5-40a2-b7eb-3472872de1e5","response_mode":"query","username":"bob"}
3647acfb-1ffa-4c3a-b655-6dd4c4fbb8a3	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	61334955-ffb5-40a2-b7eb-3472872de1e5	1777754204748	CODE_TO_TOKEN	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"token_id":"a39b818b-c5b2-4c40-a9e7-64f916da10e6","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"245cacba-b895-4e5e-9805-d5db9465ff76","code_id":"61334955-ffb5-40a2-b7eb-3472872de1e5","client_auth_method":"client-secret"}
3041b92c-e49a-49a7-ba74-41bbbb5de6d7	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	61334955-ffb5-40a2-b7eb-3472872de1e5	1777754229689	LOGOUT	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	{"redirect_uri":"https://192.168.222.146/ticketing/"}
ef10ab78-479a-436b-b19a-3d285c8d1f3f	app-audit	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777754238625	LOGOUT_ERROR	\N	null
0879c0d1-0e1b-4cf8-897c-74123c7bfc8d	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d4241857-3aeb-4ae9-87ed-ae8da549ffb4	1777754628279	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"d4241857-3aeb-4ae9-87ed-ae8da549ffb4","username":"charlie"}
70ab4b95-defc-4e31-b620-9bae5b250866	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d4241857-3aeb-4ae9-87ed-ae8da549ffb4	1777754628305	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"c75d08e6-7577-42b4-87fc-af912fe8d8b6","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"47434481-70ba-48b7-b795-c998cb56714a","code_id":"d4241857-3aeb-4ae9-87ed-ae8da549ffb4","client_auth_method":"client-secret"}
233caebd-9092-4258-b174-680c98a156a0	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d4241857-3aeb-4ae9-87ed-ae8da549ffb4	1777754641897	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"d4241857-3aeb-4ae9-87ed-ae8da549ffb4","username":"charlie"}
69a9dfc2-9557-4a4f-947c-04a2c728e7e3	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d4241857-3aeb-4ae9-87ed-ae8da549ffb4	1777754641925	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"529a5446-2d4c-49d0-87d1-1d632a1b4fe1","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f586e157-19ad-4180-b595-7c80c8a03970","code_id":"d4241857-3aeb-4ae9-87ed-ae8da549ffb4","client_auth_method":"client-secret"}
783f0241-c01b-4e2f-a8fc-b5d5a3ae0b3f	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	d4241857-3aeb-4ae9-87ed-ae8da549ffb4	1777754644514	LOGOUT	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"redirect_uri":"https://192.168.222.146/ticketing/"}
7e0ad2b6-586b-43d6-9ca4-8b1f88c33d62	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ecd728ec-a27d-4faa-aa6c-cd92587e7cfe	1777754896843	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"ecd728ec-a27d-4faa-aa6c-cd92587e7cfe","username":"charlie"}
f096e7ba-be58-4608-8270-04d722ffec95	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ecd728ec-a27d-4faa-aa6c-cd92587e7cfe	1777754896865	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"25140915-798e-48ed-8da0-904c483c2e5b","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"e8bde3c7-9d7b-482e-a40a-fbd8d5f99e18","code_id":"ecd728ec-a27d-4faa-aa6c-cd92587e7cfe","client_auth_method":"client-secret"}
cded8993-569a-4dde-a240-d0af51417dea	app-audit	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777757676216	LOGOUT_ERROR	\N	null
7663593e-7bd6-471a-8396-99af63ce58e0	app-ticketing	\N	session_expired	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	1777757681978	LOGOUT_ERROR	\N	null
c6cf3539-7d74-4c5c-84eb-5c4859d84083	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757695021	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","auth_type":"code","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"722470cd-fd92-4165-bac3-154182211b3e","username":"charlie"}
9fd92cb7-82ce-4123-b950-8f0c2644c5a0	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757695050	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"e34fbbb9-5ce7-4091-9299-60d60dcc8308","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"f0b61e48-676e-4dc4-888c-9fedb4401e25","code_id":"722470cd-fd92-4165-bac3-154182211b3e","client_auth_method":"client-secret"}
12b4c51f-12c7-4808-a633-a548f0fee21f	app-ticketing	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757696168	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/ticketing/callback","consent":"no_consent_required","code_id":"722470cd-fd92-4165-bac3-154182211b3e","username":"charlie"}
9cdfc334-5eb3-4474-8f5d-492e4773bdad	app-ticketing	\N	\N	172.18.0.12	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757696192	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"d71c3cbe-d5c2-47f3-a9dd-0da6a1630cd5","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"fbfa3f27-27b8-487f-83ba-860d6085d6ed","code_id":"722470cd-fd92-4165-bac3-154182211b3e","client_auth_method":"client-secret"}
bd45f322-83ef-4ebc-b436-d9392e365ce8	app-audit	\N	\N	192.168.222.1	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757697182	LOGIN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"auth_method":"openid-connect","redirect_uri":"https://192.168.222.146/audit/callback","consent":"no_consent_required","code_id":"722470cd-fd92-4165-bac3-154182211b3e","username":"charlie"}
0066ea10-a565-466a-a305-f1328794c292	app-audit	\N	\N	172.18.0.14	bb68fba0-f9aa-4ada-879f-ab68c527b51b	722470cd-fd92-4165-bac3-154182211b3e	1777757697218	CODE_TO_TOKEN	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	{"token_id":"b2b2d266-063b-4926-8a4c-b9e67800317c","grant_type":"authorization_code","refresh_token_type":"Refresh","scope":"openid profile email","refresh_token_id":"9fa08c23-0806-4aee-83f7-19f7dafbe25f","code_id":"722470cd-fd92-4165-bac3-154182211b3e","client_auth_method":"client-secret"}
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
c277df1c-ed33-4f5c-a640-c51766d8a67e	ae6d91ea-3c93-4e73-a890-315f220847af	f	${role_default-roles}	default-roles-master	ae6d91ea-3c93-4e73-a890-315f220847af	\N	\N
04b88942-f33e-495f-b8d3-7a7050554b9c	ae6d91ea-3c93-4e73-a890-315f220847af	f	${role_admin}	admin	ae6d91ea-3c93-4e73-a890-315f220847af	\N	\N
24aa8963-c4ba-4171-b5c1-04ba6cbb43d5	ae6d91ea-3c93-4e73-a890-315f220847af	f	${role_create-realm}	create-realm	ae6d91ea-3c93-4e73-a890-315f220847af	\N	\N
52612d6b-bfc1-4261-a5c8-5db5e55a5d3a	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_create-client}	create-client	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
25d87257-5840-44cc-8f27-7ae28cb316f3	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-realm}	view-realm	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
49a0a88b-718a-4fca-8bdd-a1363ccb9eaa	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-users}	view-users	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
92633045-6dc1-4305-92e9-0583ca92548e	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-clients}	view-clients	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
eb8511b0-b082-4401-a1ee-f98ee028de86	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-events}	view-events	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
a97451ae-b253-4cd6-abe6-988417503874	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-identity-providers}	view-identity-providers	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
36c9e0c4-b0a8-4122-af31-b0a0e25e8aa7	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_view-authorization}	view-authorization	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
c0b1a8be-e067-4243-8113-ef09fbe8c07f	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-realm}	manage-realm	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
5b1e4565-d8a4-46c7-b4ba-dae4f90f5617	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-users}	manage-users	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
7230b80c-c40a-4c3f-bd47-b3dcfa246945	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-clients}	manage-clients	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
ced38682-59ab-471f-a9ab-567e0b67f020	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-events}	manage-events	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
aea2dda9-f5be-4932-b0ca-519aaac7b669	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-identity-providers}	manage-identity-providers	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
ba48bd5f-cdde-4b65-a9f3-3c0726ac9a3a	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_manage-authorization}	manage-authorization	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
415534d2-f4df-4083-87f9-7afa613234c6	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_query-users}	query-users	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
e46f9035-ed6f-46cd-9231-99fecf2f9090	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_query-clients}	query-clients	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
3cd76ce5-bb81-4ef1-9c16-417161a5a088	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_query-realms}	query-realms	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
bcf1feef-46ee-4673-b2e7-2b1f972c0854	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_query-groups}	query-groups	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
ad5955a0-b400-4d51-8fef-87a589fb6dcb	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_view-profile}	view-profile	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
ee4bef42-94f6-4f11-a0f7-48f9e5a505aa	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_manage-account}	manage-account	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
01c0824a-7bcf-491f-bb8c-dbd935e15e84	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_manage-account-links}	manage-account-links	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
9cb16591-b649-4cf4-b63a-33619a35d167	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_view-applications}	view-applications	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
a26a2a09-4a31-4bc4-95d9-d27174957d3e	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_view-consent}	view-consent	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
b5cdc5e1-a48d-447f-9746-5cda51c176a4	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_manage-consent}	manage-consent	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
60102683-778e-4e02-9784-24a3fb08f744	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_view-groups}	view-groups	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
b742927a-79fb-4734-a486-0be6470f5755	668b3405-4a1b-4c81-9cbc-ecd724f328b1	t	${role_delete-account}	delete-account	ae6d91ea-3c93-4e73-a890-315f220847af	668b3405-4a1b-4c81-9cbc-ecd724f328b1	\N
442055a2-e787-4db0-824b-2d04eda42c45	1e524d5a-f671-4a96-b877-518e0f11369d	t	${role_read-token}	read-token	ae6d91ea-3c93-4e73-a890-315f220847af	1e524d5a-f671-4a96-b877-518e0f11369d	\N
0403d83c-9b1c-4557-b29b-7ed679b74b91	50c8ef45-e2ba-4681-a4be-40a3e99963ee	t	${role_impersonation}	impersonation	ae6d91ea-3c93-4e73-a890-315f220847af	50c8ef45-e2ba-4681-a4be-40a3e99963ee	\N
73864e8e-6ccc-455c-a9f7-9998000a37aa	ae6d91ea-3c93-4e73-a890-315f220847af	f	${role_offline-access}	offline_access	ae6d91ea-3c93-4e73-a890-315f220847af	\N	\N
124b6ea2-2061-453d-90b6-d800283fda1c	ae6d91ea-3c93-4e73-a890-315f220847af	f	${role_uma_authorization}	uma_authorization	ae6d91ea-3c93-4e73-a890-315f220847af	\N	\N
ac1849e3-73ba-4266-8b76-242b16a0bc86	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	${role_default-roles}	default-roles-pfe	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
aa0961dd-8479-4c7e-ac09-411d7802b4fa	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_create-client}	create-client	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
62890115-3874-4f7c-9fd7-a2238879bd6c	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-realm}	view-realm	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
61e1caeb-9c59-49fd-a429-bb67b431ea6e	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-users}	view-users	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
507b47cc-e4dd-4013-8325-25bea7f48083	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-clients}	view-clients	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
f0421d9a-d77c-433f-8e4e-f825bc0c36bf	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-events}	view-events	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
3da387b9-542a-4edc-9c5f-2545ffc1df00	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-identity-providers}	view-identity-providers	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
b49d5a33-2dc7-435c-8a02-1723990ba417	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_view-authorization}	view-authorization	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
7df39605-97df-49cf-814d-3fed8b30eaee	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-realm}	manage-realm	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
d1918b80-a57d-406d-a871-9ea7c4e0447b	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-users}	manage-users	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
85d28c23-23be-4531-a4a3-6cfb9bfd063b	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-clients}	manage-clients	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
b58a09ab-fd27-4681-8ada-80ef533189e1	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-events}	manage-events	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
1c247db8-655e-45f2-9d78-905993e0fdb8	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-identity-providers}	manage-identity-providers	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
2609cea6-4150-4c0a-812f-2638fcfabb47	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_manage-authorization}	manage-authorization	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
043997aa-657a-4c97-bfee-8cba1432cf27	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_query-users}	query-users	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
1a8ff3fe-c3e9-4197-8603-b59019384a00	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_query-clients}	query-clients	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
d820d268-a16b-4112-9980-71aedf696315	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_query-realms}	query-realms	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
e6248379-54f7-4194-9000-6d60f183c071	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_query-groups}	query-groups	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
95afd97a-920b-421d-b9c3-41b893fa53fb	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_realm-admin}	realm-admin	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
21a6845c-2aff-461e-9ed4-d770f4201115	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_create-client}	create-client	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
d1b7c582-b9d6-4113-a659-51762ae1a38b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-realm}	view-realm	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
474b501b-a527-4b31-a412-dc4aa2112944	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-users}	view-users	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
b44b0ba1-18d5-4338-bad7-657bac3d740a	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-clients}	view-clients	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
a6c589b8-0c4f-45c5-a8a1-f989abcbdb35	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-events}	view-events	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
5f66ecc3-a73e-4cb2-b640-2b90ae88a890	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-identity-providers}	view-identity-providers	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
7f1c8611-e898-4e95-8713-cdfeddae0dbe	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_view-authorization}	view-authorization	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
67b0be5f-a35d-410e-b164-4bae7089f025	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-realm}	manage-realm	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
b7b2892d-756c-44ce-8406-893550f49cb5	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-users}	manage-users	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
7ffe81f1-7e4b-4dba-aef3-7f84903bee52	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-clients}	manage-clients	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
d2b443ba-1ecf-46ff-9f57-ff58d95fa9b2	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-events}	manage-events	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
be474849-f2e4-48e9-b267-aff32bb344af	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-identity-providers}	manage-identity-providers	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
8df67668-fbeb-45c6-84e1-a82f433d74d6	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_manage-authorization}	manage-authorization	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
25ba4f8b-d52b-4647-9de2-6df39dbfa1a0	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_query-users}	query-users	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
c84a6e45-12e8-4cfe-96ac-de7d53545f8a	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_query-clients}	query-clients	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
d82dff5f-410f-4cf5-a5d1-b8271c8ef09d	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_query-realms}	query-realms	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
47c8159a-87df-428a-aae9-3e0db14fcf96	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_query-groups}	query-groups	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
0c63c4e2-2977-4099-97bf-2a805e0e7c5f	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_view-profile}	view-profile	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
09a3614f-067f-4d65-bc13-78e052cf5d10	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_manage-account}	manage-account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
28572276-49cb-41c9-9689-713926f76b76	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_manage-account-links}	manage-account-links	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
4ff71068-b1fa-4a79-9e9b-bc5a2c47ce59	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_view-applications}	view-applications	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
89755dad-2edb-48b1-95d3-a4acf73770e6	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_view-consent}	view-consent	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
6b2f57f1-de0e-4bf6-9525-29b5544aaf97	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_manage-consent}	manage-consent	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
31cc64dc-2fd6-4d72-bf61-cf1ca77e1d2c	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_view-groups}	view-groups	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
b06222dd-d7af-4533-8c49-1100ccad2d7c	f0275901-ed04-4b9d-ae28-d66de424b069	t	${role_delete-account}	delete-account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f0275901-ed04-4b9d-ae28-d66de424b069	\N
d8e33bfe-a4d0-4672-8f1f-59ac95a8e060	fab40a15-e55c-40e6-843a-308eb6e53b13	t	${role_impersonation}	impersonation	ae6d91ea-3c93-4e73-a890-315f220847af	fab40a15-e55c-40e6-843a-308eb6e53b13	\N
7c335b26-408e-4bac-9c29-85917b40694c	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	t	${role_impersonation}	impersonation	bb68fba0-f9aa-4ada-879f-ab68c527b51b	8bc7be32-6c84-4bcf-9cd8-689aec0e617f	\N
9f419294-0d86-46ff-b84f-cf3c0f16258d	e34ac089-905a-478a-8f29-5e68e5f0205a	t	${role_read-token}	read-token	bb68fba0-f9aa-4ada-879f-ab68c527b51b	e34ac089-905a-478a-8f29-5e68e5f0205a	\N
24995697-a0f6-4175-8adb-a6ae05d41c8f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	${role_offline-access}	offline_access	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
7d9bd86c-6fca-4018-96ac-6cc0ca5d219f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	\N	admin	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
c9a443e0-9de0-4b49-9241-d7aca6de2e72	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	\N	manager	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
e17b25fc-4b72-46d3-8fed-e3df2d6dd16f	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	\N	user	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
6c72cac0-c823-483e-967c-330ee01a5f3d	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	${role_uma_authorization}	uma_authorization	bb68fba0-f9aa-4ada-879f-ab68c527b51b	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ypvqr	24.0.5	1777494236
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
504f3ce5-f3f9-4017-9d88-bbc3b5be4af7	audience resolve	openid-connect	oidc-audience-resolve-mapper	1781e806-776d-48a5-95ba-839e0a57cd02	\N
a4891c25-0d15-4c56-8c5f-7e31a8170851	locale	openid-connect	oidc-usermodel-attribute-mapper	2740f411-4a45-46bc-b875-ffda2b4a420c	\N
ff11ed61-3c8a-4824-b57b-d426019032ad	role list	saml	saml-role-list-mapper	\N	e52833ca-803d-4cf0-863e-5653d72b6914
05385aff-20b5-4432-953a-c87344216145	full name	openid-connect	oidc-full-name-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
55e2b6fa-c9f8-498d-b983-1d606dc84121	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
1f459ec3-27f8-44a4-8de4-5f835d39e69d	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
9b095f22-262b-4f5f-a3f1-a986e95dd43e	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
df1a769a-e4d8-47db-84f6-5d73a14558d3	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	username	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
351d9584-0bb3-4828-a9c3-4de96806221d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
677d3517-395a-4568-a05e-8a0dfc61e6e4	website	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
1bf86bb3-8467-4d61-a236-9a58635ef5b2	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
85423ab6-877e-434f-b80b-f5c8b998e62e	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
ff87cb31-fa55-4541-82cd-f219f7efa648	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	1d96c492-2610-4f50-895a-47bb4eaa497a
b4db4061-9d5e-4360-a1c2-ca05fff56f37	email	openid-connect	oidc-usermodel-attribute-mapper	\N	d85c7381-616b-4e13-b2a6-88447163497e
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	email verified	openid-connect	oidc-usermodel-property-mapper	\N	d85c7381-616b-4e13-b2a6-88447163497e
0d9f679d-989a-4099-9114-e849eb3ad5b0	address	openid-connect	oidc-address-mapper	\N	20a0d3b2-b6da-4aa8-81cf-19a38f3d0315
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8
b791477b-5757-470a-982e-aeacb218d162	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	06e38719-b3b2-40c2-a1e4-f242d3e4d3d8
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a128ac5f-a515-47ad-a358-ac4e1875d65c
b9ac2df4-56a7-44ca-9995-c169634e52be	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a128ac5f-a515-47ad-a358-ac4e1875d65c
22be845e-a766-4052-9400-c4b0c544c7f1	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a128ac5f-a515-47ad-a358-ac4e1875d65c
4835efad-9d98-4f8e-a71b-9fccdb2bc581	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	85e2cbe3-fc11-4693-822f-a1bc476005c3
04643dce-3617-4fce-980e-a9b901d2e20f	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	e80ce24a-5154-4641-b25a-7946accaa355
aec5557c-77f1-49df-a230-c97323f7a961	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e80ce24a-5154-4641-b25a-7946accaa355
d34607f0-44d6-4f49-8c10-3d36812856cc	acr loa level	openid-connect	oidc-acr-mapper	\N	e5af9ffa-a0b8-4264-990e-9d0e775486da
cf4c4754-0577-447f-9dce-cd8128f5dad3	audience resolve	openid-connect	oidc-audience-resolve-mapper	9a4d6b4c-8860-4227-8bc0-4d9d266adc01	\N
8cce82b5-0f35-49b7-9338-720124e0681a	role list	saml	saml-role-list-mapper	\N	e9926443-9775-4d3a-b3fd-ec5d4b421c2b
08f17640-3e6f-4a15-bdb4-01784fee44ae	full name	openid-connect	oidc-full-name-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
5f23a42a-a504-420d-a1cb-810c8499310b	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
a65054d2-a3ae-4136-aeb7-8131959073b8	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
28b68804-836d-49e8-8ce3-32c877ab9af9	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
ee60f3c6-7069-4cb8-8631-ec7436bd3800	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
77afbd6d-4c54-44d2-9431-2559003faf04	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
09064225-45b3-4f2e-acb5-fcb5ba9b454b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
7094c00f-cd08-467f-9905-3791b0ad2aff	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
3a1d79c1-e626-4e46-be58-792da790d934	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
11a876f1-79e5-42fa-a014-d6aa1249a0dc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b4392b53-9ed2-4ce8-9b1f-b5dfca72af17
d445767b-96d1-4ab4-bf53-2a5ff329d563	email	openid-connect	oidc-usermodel-attribute-mapper	\N	40316e2f-4e65-4f3e-9297-1d1b55c9f614
55081994-2d70-4912-9ad1-b7a0adffaad2	email verified	openid-connect	oidc-usermodel-property-mapper	\N	40316e2f-4e65-4f3e-9297-1d1b55c9f614
3a75ef5a-638b-460a-9ead-11c300b04afa	address	openid-connect	oidc-address-mapper	\N	67da9fcb-56db-405d-8c0a-ecb4315dad6a
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	2ba33045-6c73-4108-b9c0-d44c4c7d09ec
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	2ba33045-6c73-4108-b9c0-d44c4c7d09ec
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e18aa91f-739a-4a21-9baa-d10824062257
cb7687bd-50f4-4fe7-ba58-53f2de039c12	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e18aa91f-739a-4a21-9baa-d10824062257
40a29835-867a-4f23-9ed1-e8b03fb65688	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e18aa91f-739a-4a21-9baa-d10824062257
8151606c-3a87-4c77-b68c-e0b79ade2fc2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5f5fcd7f-5fe3-4cf3-9367-f1a37ccce7a1
c1574c2c-b639-4494-9fd4-8f548e4204eb	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	cf6c89c1-7006-410e-a19b-809cf10b2d46
cecf2a94-4655-412b-9e63-d02d1fd5f25f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	cf6c89c1-7006-410e-a19b-809cf10b2d46
ee37dbda-7ab6-4dc8-b5f8-ef1c9eefa536	acr loa level	openid-connect	oidc-acr-mapper	\N	ced9d6c0-467f-4799-9232-3be51c6b7755
ba2a06d7-742c-4b30-8d5c-82954df22ed2	realm-roles-mapper	openid-connect	oidc-usermodel-realm-role-mapper	f79db544-11eb-44c3-a37a-bf20fdf4020d	\N
db6ce5c9-5521-410e-af13-b5ad844dbf16	realm-roles-mapper	openid-connect	oidc-usermodel-realm-role-mapper	2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	\N
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	realm-roles-mapper	openid-connect	oidc-usermodel-realm-role-mapper	9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	\N
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	locale	openid-connect	oidc-usermodel-attribute-mapper	71700017-4f1b-4b6a-9db9-f4a1e50c1202	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
a4891c25-0d15-4c56-8c5f-7e31a8170851	true	introspection.token.claim
a4891c25-0d15-4c56-8c5f-7e31a8170851	true	userinfo.token.claim
a4891c25-0d15-4c56-8c5f-7e31a8170851	locale	user.attribute
a4891c25-0d15-4c56-8c5f-7e31a8170851	true	id.token.claim
a4891c25-0d15-4c56-8c5f-7e31a8170851	true	access.token.claim
a4891c25-0d15-4c56-8c5f-7e31a8170851	locale	claim.name
a4891c25-0d15-4c56-8c5f-7e31a8170851	String	jsonType.label
ff11ed61-3c8a-4824-b57b-d426019032ad	false	single
ff11ed61-3c8a-4824-b57b-d426019032ad	Basic	attribute.nameformat
ff11ed61-3c8a-4824-b57b-d426019032ad	Role	attribute.name
05385aff-20b5-4432-953a-c87344216145	true	introspection.token.claim
05385aff-20b5-4432-953a-c87344216145	true	userinfo.token.claim
05385aff-20b5-4432-953a-c87344216145	true	id.token.claim
05385aff-20b5-4432-953a-c87344216145	true	access.token.claim
1bf86bb3-8467-4d61-a236-9a58635ef5b2	true	introspection.token.claim
1bf86bb3-8467-4d61-a236-9a58635ef5b2	true	userinfo.token.claim
1bf86bb3-8467-4d61-a236-9a58635ef5b2	birthdate	user.attribute
1bf86bb3-8467-4d61-a236-9a58635ef5b2	true	id.token.claim
1bf86bb3-8467-4d61-a236-9a58635ef5b2	true	access.token.claim
1bf86bb3-8467-4d61-a236-9a58635ef5b2	birthdate	claim.name
1bf86bb3-8467-4d61-a236-9a58635ef5b2	String	jsonType.label
1f459ec3-27f8-44a4-8de4-5f835d39e69d	true	introspection.token.claim
1f459ec3-27f8-44a4-8de4-5f835d39e69d	true	userinfo.token.claim
1f459ec3-27f8-44a4-8de4-5f835d39e69d	firstName	user.attribute
1f459ec3-27f8-44a4-8de4-5f835d39e69d	true	id.token.claim
1f459ec3-27f8-44a4-8de4-5f835d39e69d	true	access.token.claim
1f459ec3-27f8-44a4-8de4-5f835d39e69d	given_name	claim.name
1f459ec3-27f8-44a4-8de4-5f835d39e69d	String	jsonType.label
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	true	introspection.token.claim
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	true	userinfo.token.claim
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	gender	user.attribute
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	true	id.token.claim
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	true	access.token.claim
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	gender	claim.name
2b1f9bb4-1fd4-49bd-8ee5-c4f251ca1843	String	jsonType.label
351d9584-0bb3-4828-a9c3-4de96806221d	true	introspection.token.claim
351d9584-0bb3-4828-a9c3-4de96806221d	true	userinfo.token.claim
351d9584-0bb3-4828-a9c3-4de96806221d	profile	user.attribute
351d9584-0bb3-4828-a9c3-4de96806221d	true	id.token.claim
351d9584-0bb3-4828-a9c3-4de96806221d	true	access.token.claim
351d9584-0bb3-4828-a9c3-4de96806221d	profile	claim.name
351d9584-0bb3-4828-a9c3-4de96806221d	String	jsonType.label
55e2b6fa-c9f8-498d-b983-1d606dc84121	true	introspection.token.claim
55e2b6fa-c9f8-498d-b983-1d606dc84121	true	userinfo.token.claim
55e2b6fa-c9f8-498d-b983-1d606dc84121	lastName	user.attribute
55e2b6fa-c9f8-498d-b983-1d606dc84121	true	id.token.claim
55e2b6fa-c9f8-498d-b983-1d606dc84121	true	access.token.claim
55e2b6fa-c9f8-498d-b983-1d606dc84121	family_name	claim.name
55e2b6fa-c9f8-498d-b983-1d606dc84121	String	jsonType.label
677d3517-395a-4568-a05e-8a0dfc61e6e4	true	introspection.token.claim
677d3517-395a-4568-a05e-8a0dfc61e6e4	true	userinfo.token.claim
677d3517-395a-4568-a05e-8a0dfc61e6e4	website	user.attribute
677d3517-395a-4568-a05e-8a0dfc61e6e4	true	id.token.claim
677d3517-395a-4568-a05e-8a0dfc61e6e4	true	access.token.claim
677d3517-395a-4568-a05e-8a0dfc61e6e4	website	claim.name
677d3517-395a-4568-a05e-8a0dfc61e6e4	String	jsonType.label
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	true	introspection.token.claim
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	true	userinfo.token.claim
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	zoneinfo	user.attribute
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	true	id.token.claim
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	true	access.token.claim
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	zoneinfo	claim.name
81ca81a3-b44b-4a7e-9432-b6ecd9e7e42f	String	jsonType.label
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	true	introspection.token.claim
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	true	userinfo.token.claim
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	username	user.attribute
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	true	id.token.claim
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	true	access.token.claim
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	preferred_username	claim.name
81f8ecc0-4b16-431d-a7b1-7663c4d148c9	String	jsonType.label
85423ab6-877e-434f-b80b-f5c8b998e62e	true	introspection.token.claim
85423ab6-877e-434f-b80b-f5c8b998e62e	true	userinfo.token.claim
85423ab6-877e-434f-b80b-f5c8b998e62e	locale	user.attribute
85423ab6-877e-434f-b80b-f5c8b998e62e	true	id.token.claim
85423ab6-877e-434f-b80b-f5c8b998e62e	true	access.token.claim
85423ab6-877e-434f-b80b-f5c8b998e62e	locale	claim.name
85423ab6-877e-434f-b80b-f5c8b998e62e	String	jsonType.label
9b095f22-262b-4f5f-a3f1-a986e95dd43e	true	introspection.token.claim
9b095f22-262b-4f5f-a3f1-a986e95dd43e	true	userinfo.token.claim
9b095f22-262b-4f5f-a3f1-a986e95dd43e	middleName	user.attribute
9b095f22-262b-4f5f-a3f1-a986e95dd43e	true	id.token.claim
9b095f22-262b-4f5f-a3f1-a986e95dd43e	true	access.token.claim
9b095f22-262b-4f5f-a3f1-a986e95dd43e	middle_name	claim.name
9b095f22-262b-4f5f-a3f1-a986e95dd43e	String	jsonType.label
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	true	introspection.token.claim
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	true	userinfo.token.claim
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	picture	user.attribute
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	true	id.token.claim
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	true	access.token.claim
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	picture	claim.name
d0fdbb99-9b1c-4902-aff4-b0f8b68d8d9b	String	jsonType.label
df1a769a-e4d8-47db-84f6-5d73a14558d3	true	introspection.token.claim
df1a769a-e4d8-47db-84f6-5d73a14558d3	true	userinfo.token.claim
df1a769a-e4d8-47db-84f6-5d73a14558d3	nickname	user.attribute
df1a769a-e4d8-47db-84f6-5d73a14558d3	true	id.token.claim
df1a769a-e4d8-47db-84f6-5d73a14558d3	true	access.token.claim
df1a769a-e4d8-47db-84f6-5d73a14558d3	nickname	claim.name
df1a769a-e4d8-47db-84f6-5d73a14558d3	String	jsonType.label
ff87cb31-fa55-4541-82cd-f219f7efa648	true	introspection.token.claim
ff87cb31-fa55-4541-82cd-f219f7efa648	true	userinfo.token.claim
ff87cb31-fa55-4541-82cd-f219f7efa648	updatedAt	user.attribute
ff87cb31-fa55-4541-82cd-f219f7efa648	true	id.token.claim
ff87cb31-fa55-4541-82cd-f219f7efa648	true	access.token.claim
ff87cb31-fa55-4541-82cd-f219f7efa648	updated_at	claim.name
ff87cb31-fa55-4541-82cd-f219f7efa648	long	jsonType.label
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	true	introspection.token.claim
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	true	userinfo.token.claim
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	emailVerified	user.attribute
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	true	id.token.claim
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	true	access.token.claim
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	email_verified	claim.name
1e6007b6-f90b-4a3b-9e8f-380dd0f15f51	boolean	jsonType.label
b4db4061-9d5e-4360-a1c2-ca05fff56f37	true	introspection.token.claim
b4db4061-9d5e-4360-a1c2-ca05fff56f37	true	userinfo.token.claim
b4db4061-9d5e-4360-a1c2-ca05fff56f37	email	user.attribute
b4db4061-9d5e-4360-a1c2-ca05fff56f37	true	id.token.claim
b4db4061-9d5e-4360-a1c2-ca05fff56f37	true	access.token.claim
b4db4061-9d5e-4360-a1c2-ca05fff56f37	email	claim.name
b4db4061-9d5e-4360-a1c2-ca05fff56f37	String	jsonType.label
0d9f679d-989a-4099-9114-e849eb3ad5b0	formatted	user.attribute.formatted
0d9f679d-989a-4099-9114-e849eb3ad5b0	country	user.attribute.country
0d9f679d-989a-4099-9114-e849eb3ad5b0	true	introspection.token.claim
0d9f679d-989a-4099-9114-e849eb3ad5b0	postal_code	user.attribute.postal_code
0d9f679d-989a-4099-9114-e849eb3ad5b0	true	userinfo.token.claim
0d9f679d-989a-4099-9114-e849eb3ad5b0	street	user.attribute.street
0d9f679d-989a-4099-9114-e849eb3ad5b0	true	id.token.claim
0d9f679d-989a-4099-9114-e849eb3ad5b0	region	user.attribute.region
0d9f679d-989a-4099-9114-e849eb3ad5b0	true	access.token.claim
0d9f679d-989a-4099-9114-e849eb3ad5b0	locality	user.attribute.locality
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	true	introspection.token.claim
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	true	userinfo.token.claim
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	phoneNumber	user.attribute
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	true	id.token.claim
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	true	access.token.claim
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	phone_number	claim.name
1667617b-eea4-4e6a-a8b5-2ada3f8e5fea	String	jsonType.label
b791477b-5757-470a-982e-aeacb218d162	true	introspection.token.claim
b791477b-5757-470a-982e-aeacb218d162	true	userinfo.token.claim
b791477b-5757-470a-982e-aeacb218d162	phoneNumberVerified	user.attribute
b791477b-5757-470a-982e-aeacb218d162	true	id.token.claim
b791477b-5757-470a-982e-aeacb218d162	true	access.token.claim
b791477b-5757-470a-982e-aeacb218d162	phone_number_verified	claim.name
b791477b-5757-470a-982e-aeacb218d162	boolean	jsonType.label
22be845e-a766-4052-9400-c4b0c544c7f1	true	introspection.token.claim
22be845e-a766-4052-9400-c4b0c544c7f1	true	access.token.claim
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	true	introspection.token.claim
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	true	multivalued
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	foo	user.attribute
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	true	access.token.claim
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	realm_access.roles	claim.name
8cc964d2-ce2d-4150-b81f-eebdf2b4aa8f	String	jsonType.label
b9ac2df4-56a7-44ca-9995-c169634e52be	true	introspection.token.claim
b9ac2df4-56a7-44ca-9995-c169634e52be	true	multivalued
b9ac2df4-56a7-44ca-9995-c169634e52be	foo	user.attribute
b9ac2df4-56a7-44ca-9995-c169634e52be	true	access.token.claim
b9ac2df4-56a7-44ca-9995-c169634e52be	resource_access.${client_id}.roles	claim.name
b9ac2df4-56a7-44ca-9995-c169634e52be	String	jsonType.label
4835efad-9d98-4f8e-a71b-9fccdb2bc581	true	introspection.token.claim
4835efad-9d98-4f8e-a71b-9fccdb2bc581	true	access.token.claim
04643dce-3617-4fce-980e-a9b901d2e20f	true	introspection.token.claim
04643dce-3617-4fce-980e-a9b901d2e20f	true	userinfo.token.claim
04643dce-3617-4fce-980e-a9b901d2e20f	username	user.attribute
04643dce-3617-4fce-980e-a9b901d2e20f	true	id.token.claim
04643dce-3617-4fce-980e-a9b901d2e20f	true	access.token.claim
04643dce-3617-4fce-980e-a9b901d2e20f	upn	claim.name
04643dce-3617-4fce-980e-a9b901d2e20f	String	jsonType.label
aec5557c-77f1-49df-a230-c97323f7a961	true	introspection.token.claim
aec5557c-77f1-49df-a230-c97323f7a961	true	multivalued
aec5557c-77f1-49df-a230-c97323f7a961	foo	user.attribute
aec5557c-77f1-49df-a230-c97323f7a961	true	id.token.claim
aec5557c-77f1-49df-a230-c97323f7a961	true	access.token.claim
aec5557c-77f1-49df-a230-c97323f7a961	groups	claim.name
aec5557c-77f1-49df-a230-c97323f7a961	String	jsonType.label
d34607f0-44d6-4f49-8c10-3d36812856cc	true	introspection.token.claim
d34607f0-44d6-4f49-8c10-3d36812856cc	true	id.token.claim
d34607f0-44d6-4f49-8c10-3d36812856cc	true	access.token.claim
8cce82b5-0f35-49b7-9338-720124e0681a	false	single
8cce82b5-0f35-49b7-9338-720124e0681a	Basic	attribute.nameformat
8cce82b5-0f35-49b7-9338-720124e0681a	Role	attribute.name
08f17640-3e6f-4a15-bdb4-01784fee44ae	true	introspection.token.claim
08f17640-3e6f-4a15-bdb4-01784fee44ae	true	userinfo.token.claim
08f17640-3e6f-4a15-bdb4-01784fee44ae	true	id.token.claim
08f17640-3e6f-4a15-bdb4-01784fee44ae	true	access.token.claim
09064225-45b3-4f2e-acb5-fcb5ba9b454b	true	introspection.token.claim
09064225-45b3-4f2e-acb5-fcb5ba9b454b	true	userinfo.token.claim
09064225-45b3-4f2e-acb5-fcb5ba9b454b	website	user.attribute
09064225-45b3-4f2e-acb5-fcb5ba9b454b	true	id.token.claim
09064225-45b3-4f2e-acb5-fcb5ba9b454b	true	access.token.claim
09064225-45b3-4f2e-acb5-fcb5ba9b454b	website	claim.name
09064225-45b3-4f2e-acb5-fcb5ba9b454b	String	jsonType.label
11a876f1-79e5-42fa-a014-d6aa1249a0dc	true	introspection.token.claim
11a876f1-79e5-42fa-a014-d6aa1249a0dc	true	userinfo.token.claim
11a876f1-79e5-42fa-a014-d6aa1249a0dc	updatedAt	user.attribute
11a876f1-79e5-42fa-a014-d6aa1249a0dc	true	id.token.claim
11a876f1-79e5-42fa-a014-d6aa1249a0dc	true	access.token.claim
11a876f1-79e5-42fa-a014-d6aa1249a0dc	updated_at	claim.name
11a876f1-79e5-42fa-a014-d6aa1249a0dc	long	jsonType.label
28b68804-836d-49e8-8ce3-32c877ab9af9	true	introspection.token.claim
28b68804-836d-49e8-8ce3-32c877ab9af9	true	userinfo.token.claim
28b68804-836d-49e8-8ce3-32c877ab9af9	nickname	user.attribute
28b68804-836d-49e8-8ce3-32c877ab9af9	true	id.token.claim
28b68804-836d-49e8-8ce3-32c877ab9af9	true	access.token.claim
28b68804-836d-49e8-8ce3-32c877ab9af9	nickname	claim.name
28b68804-836d-49e8-8ce3-32c877ab9af9	String	jsonType.label
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	true	introspection.token.claim
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	true	userinfo.token.claim
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	birthdate	user.attribute
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	true	id.token.claim
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	true	access.token.claim
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	birthdate	claim.name
2e6ce74a-93ac-4bc3-b084-e0a919f2780b	String	jsonType.label
3a1d79c1-e626-4e46-be58-792da790d934	true	introspection.token.claim
3a1d79c1-e626-4e46-be58-792da790d934	true	userinfo.token.claim
3a1d79c1-e626-4e46-be58-792da790d934	locale	user.attribute
3a1d79c1-e626-4e46-be58-792da790d934	true	id.token.claim
3a1d79c1-e626-4e46-be58-792da790d934	true	access.token.claim
3a1d79c1-e626-4e46-be58-792da790d934	locale	claim.name
3a1d79c1-e626-4e46-be58-792da790d934	String	jsonType.label
5f23a42a-a504-420d-a1cb-810c8499310b	true	introspection.token.claim
5f23a42a-a504-420d-a1cb-810c8499310b	true	userinfo.token.claim
5f23a42a-a504-420d-a1cb-810c8499310b	firstName	user.attribute
5f23a42a-a504-420d-a1cb-810c8499310b	true	id.token.claim
5f23a42a-a504-420d-a1cb-810c8499310b	true	access.token.claim
5f23a42a-a504-420d-a1cb-810c8499310b	given_name	claim.name
5f23a42a-a504-420d-a1cb-810c8499310b	String	jsonType.label
7094c00f-cd08-467f-9905-3791b0ad2aff	true	introspection.token.claim
7094c00f-cd08-467f-9905-3791b0ad2aff	true	userinfo.token.claim
7094c00f-cd08-467f-9905-3791b0ad2aff	gender	user.attribute
7094c00f-cd08-467f-9905-3791b0ad2aff	true	id.token.claim
7094c00f-cd08-467f-9905-3791b0ad2aff	true	access.token.claim
7094c00f-cd08-467f-9905-3791b0ad2aff	gender	claim.name
7094c00f-cd08-467f-9905-3791b0ad2aff	String	jsonType.label
77afbd6d-4c54-44d2-9431-2559003faf04	true	introspection.token.claim
77afbd6d-4c54-44d2-9431-2559003faf04	true	userinfo.token.claim
77afbd6d-4c54-44d2-9431-2559003faf04	profile	user.attribute
77afbd6d-4c54-44d2-9431-2559003faf04	true	id.token.claim
77afbd6d-4c54-44d2-9431-2559003faf04	true	access.token.claim
77afbd6d-4c54-44d2-9431-2559003faf04	profile	claim.name
77afbd6d-4c54-44d2-9431-2559003faf04	String	jsonType.label
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	true	introspection.token.claim
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	true	userinfo.token.claim
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	zoneinfo	user.attribute
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	true	id.token.claim
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	true	access.token.claim
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	zoneinfo	claim.name
9031cf4d-08ca-45ed-bfa8-a796f3b7d5e2	String	jsonType.label
a65054d2-a3ae-4136-aeb7-8131959073b8	true	introspection.token.claim
a65054d2-a3ae-4136-aeb7-8131959073b8	true	userinfo.token.claim
a65054d2-a3ae-4136-aeb7-8131959073b8	middleName	user.attribute
a65054d2-a3ae-4136-aeb7-8131959073b8	true	id.token.claim
a65054d2-a3ae-4136-aeb7-8131959073b8	true	access.token.claim
a65054d2-a3ae-4136-aeb7-8131959073b8	middle_name	claim.name
a65054d2-a3ae-4136-aeb7-8131959073b8	String	jsonType.label
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	true	introspection.token.claim
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	true	userinfo.token.claim
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	picture	user.attribute
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	true	id.token.claim
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	true	access.token.claim
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	picture	claim.name
c55cea2b-80bd-4858-8ea2-1a8c71529ba1	String	jsonType.label
ee60f3c6-7069-4cb8-8631-ec7436bd3800	true	introspection.token.claim
ee60f3c6-7069-4cb8-8631-ec7436bd3800	true	userinfo.token.claim
ee60f3c6-7069-4cb8-8631-ec7436bd3800	username	user.attribute
ee60f3c6-7069-4cb8-8631-ec7436bd3800	true	id.token.claim
ee60f3c6-7069-4cb8-8631-ec7436bd3800	true	access.token.claim
ee60f3c6-7069-4cb8-8631-ec7436bd3800	preferred_username	claim.name
ee60f3c6-7069-4cb8-8631-ec7436bd3800	String	jsonType.label
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	true	introspection.token.claim
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	true	userinfo.token.claim
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	lastName	user.attribute
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	true	id.token.claim
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	true	access.token.claim
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	family_name	claim.name
f9d344e3-e3c7-4d30-a35b-4190c33c2ac2	String	jsonType.label
55081994-2d70-4912-9ad1-b7a0adffaad2	true	introspection.token.claim
55081994-2d70-4912-9ad1-b7a0adffaad2	true	userinfo.token.claim
55081994-2d70-4912-9ad1-b7a0adffaad2	emailVerified	user.attribute
55081994-2d70-4912-9ad1-b7a0adffaad2	true	id.token.claim
55081994-2d70-4912-9ad1-b7a0adffaad2	true	access.token.claim
55081994-2d70-4912-9ad1-b7a0adffaad2	email_verified	claim.name
55081994-2d70-4912-9ad1-b7a0adffaad2	boolean	jsonType.label
d445767b-96d1-4ab4-bf53-2a5ff329d563	true	introspection.token.claim
d445767b-96d1-4ab4-bf53-2a5ff329d563	true	userinfo.token.claim
d445767b-96d1-4ab4-bf53-2a5ff329d563	email	user.attribute
d445767b-96d1-4ab4-bf53-2a5ff329d563	true	id.token.claim
d445767b-96d1-4ab4-bf53-2a5ff329d563	true	access.token.claim
d445767b-96d1-4ab4-bf53-2a5ff329d563	email	claim.name
d445767b-96d1-4ab4-bf53-2a5ff329d563	String	jsonType.label
3a75ef5a-638b-460a-9ead-11c300b04afa	formatted	user.attribute.formatted
3a75ef5a-638b-460a-9ead-11c300b04afa	country	user.attribute.country
3a75ef5a-638b-460a-9ead-11c300b04afa	true	introspection.token.claim
3a75ef5a-638b-460a-9ead-11c300b04afa	postal_code	user.attribute.postal_code
3a75ef5a-638b-460a-9ead-11c300b04afa	true	userinfo.token.claim
3a75ef5a-638b-460a-9ead-11c300b04afa	street	user.attribute.street
3a75ef5a-638b-460a-9ead-11c300b04afa	true	id.token.claim
3a75ef5a-638b-460a-9ead-11c300b04afa	region	user.attribute.region
3a75ef5a-638b-460a-9ead-11c300b04afa	true	access.token.claim
3a75ef5a-638b-460a-9ead-11c300b04afa	locality	user.attribute.locality
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	true	introspection.token.claim
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	true	userinfo.token.claim
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	phoneNumber	user.attribute
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	true	id.token.claim
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	true	access.token.claim
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	phone_number	claim.name
6e924fe0-ba5c-4daa-aac2-72d73d66cd1f	String	jsonType.label
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	true	introspection.token.claim
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	true	userinfo.token.claim
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	phoneNumberVerified	user.attribute
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	true	id.token.claim
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	true	access.token.claim
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	phone_number_verified	claim.name
800ff0bb-2fa4-49fd-9b81-5b830f2f194b	boolean	jsonType.label
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	true	introspection.token.claim
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	true	multivalued
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	foo	user.attribute
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	true	access.token.claim
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	realm_access.roles	claim.name
3ab2e3c9-765f-4c47-9a17-adfe7677ea5e	String	jsonType.label
40a29835-867a-4f23-9ed1-e8b03fb65688	true	introspection.token.claim
40a29835-867a-4f23-9ed1-e8b03fb65688	true	access.token.claim
cb7687bd-50f4-4fe7-ba58-53f2de039c12	true	introspection.token.claim
cb7687bd-50f4-4fe7-ba58-53f2de039c12	true	multivalued
cb7687bd-50f4-4fe7-ba58-53f2de039c12	foo	user.attribute
cb7687bd-50f4-4fe7-ba58-53f2de039c12	true	access.token.claim
cb7687bd-50f4-4fe7-ba58-53f2de039c12	resource_access.${client_id}.roles	claim.name
cb7687bd-50f4-4fe7-ba58-53f2de039c12	String	jsonType.label
8151606c-3a87-4c77-b68c-e0b79ade2fc2	true	introspection.token.claim
8151606c-3a87-4c77-b68c-e0b79ade2fc2	true	access.token.claim
c1574c2c-b639-4494-9fd4-8f548e4204eb	true	introspection.token.claim
c1574c2c-b639-4494-9fd4-8f548e4204eb	true	userinfo.token.claim
c1574c2c-b639-4494-9fd4-8f548e4204eb	username	user.attribute
c1574c2c-b639-4494-9fd4-8f548e4204eb	true	id.token.claim
c1574c2c-b639-4494-9fd4-8f548e4204eb	true	access.token.claim
c1574c2c-b639-4494-9fd4-8f548e4204eb	upn	claim.name
c1574c2c-b639-4494-9fd4-8f548e4204eb	String	jsonType.label
cecf2a94-4655-412b-9e63-d02d1fd5f25f	true	introspection.token.claim
cecf2a94-4655-412b-9e63-d02d1fd5f25f	true	multivalued
cecf2a94-4655-412b-9e63-d02d1fd5f25f	foo	user.attribute
cecf2a94-4655-412b-9e63-d02d1fd5f25f	true	id.token.claim
cecf2a94-4655-412b-9e63-d02d1fd5f25f	true	access.token.claim
cecf2a94-4655-412b-9e63-d02d1fd5f25f	groups	claim.name
cecf2a94-4655-412b-9e63-d02d1fd5f25f	String	jsonType.label
ee37dbda-7ab6-4dc8-b5f8-ef1c9eefa536	true	introspection.token.claim
ee37dbda-7ab6-4dc8-b5f8-ef1c9eefa536	true	id.token.claim
ee37dbda-7ab6-4dc8-b5f8-ef1c9eefa536	true	access.token.claim
ba2a06d7-742c-4b30-8d5c-82954df22ed2	true	multivalued
ba2a06d7-742c-4b30-8d5c-82954df22ed2	true	userinfo.token.claim
ba2a06d7-742c-4b30-8d5c-82954df22ed2	true	id.token.claim
ba2a06d7-742c-4b30-8d5c-82954df22ed2	true	access.token.claim
ba2a06d7-742c-4b30-8d5c-82954df22ed2	roles	claim.name
ba2a06d7-742c-4b30-8d5c-82954df22ed2	String	jsonType.label
db6ce5c9-5521-410e-af13-b5ad844dbf16	true	multivalued
db6ce5c9-5521-410e-af13-b5ad844dbf16	true	userinfo.token.claim
db6ce5c9-5521-410e-af13-b5ad844dbf16	true	id.token.claim
db6ce5c9-5521-410e-af13-b5ad844dbf16	true	access.token.claim
db6ce5c9-5521-410e-af13-b5ad844dbf16	roles	claim.name
db6ce5c9-5521-410e-af13-b5ad844dbf16	String	jsonType.label
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	true	multivalued
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	true	userinfo.token.claim
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	true	id.token.claim
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	true	access.token.claim
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	roles	claim.name
4b7810d6-8f4e-4eee-9d76-3e7fa63d2e5b	String	jsonType.label
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	true	introspection.token.claim
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	true	userinfo.token.claim
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	locale	user.attribute
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	true	id.token.claim
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	true	access.token.claim
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	locale	claim.name
a0da8f8c-b1a5-4bee-894e-a7356d4a4f3e	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
ae6d91ea-3c93-4e73-a890-315f220847af	60	300	60	\N	\N	\N	t	t	31536000	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	50c8ef45-e2ba-4681-a4be-40a3e99963ee	1800	f	\N	f	t	f	f	0	1	30	6	HmacSHA1	totp	42af4930-12f5-429f-978c-0a2b016a0752	854c0f6d-c67d-451e-9d54-f7a503fb7028	814b0413-0c58-4197-86ed-cfbf1c4adee6	3d81a45b-54f9-42a3-90df-0850681c2cd5	ae2e86ec-52d4-4311-ac97-c1fe7f00c450	2592000	f	900	t	f	ef3a6168-38ce-45cb-aacd-e97e9c0fc6da	0	f	0	0	c277df1c-ed33-4f5c-a640-c51766d8a67e
bb68fba0-f9aa-4ada-879f-ab68c527b51b	60	300	300	\N	\N	\N	t	t	31536000	\N	pfe	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	fab40a15-e55c-40e6-843a-308eb6e53b13	1800	f	\N	f	t	f	f	0	1	30	6	HmacSHA1	totp	4847cb48-abd7-4607-98b0-cc8998178536	8f601e9f-78a6-4004-9771-7c804b978ffe	489a2268-fae0-4193-8bc1-02000ba6f1b1	0618d95b-2748-4e6f-bb3e-e4da4650206a	f07ecc62-9f08-4ffe-b0ab-17a1395586e2	2592000	f	900	t	f	661b001a-38ce-4eab-b729-ab799bc3f6be	0	f	0	0	ac1849e3-73ba-4266-8b76-242b16a0bc86
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	ae6d91ea-3c93-4e73-a890-315f220847af	false
permanentLockout	ae6d91ea-3c93-4e73-a890-315f220847af	false
maxTemporaryLockouts	ae6d91ea-3c93-4e73-a890-315f220847af	0
maxFailureWaitSeconds	ae6d91ea-3c93-4e73-a890-315f220847af	900
minimumQuickLoginWaitSeconds	ae6d91ea-3c93-4e73-a890-315f220847af	60
waitIncrementSeconds	ae6d91ea-3c93-4e73-a890-315f220847af	60
quickLoginCheckMilliSeconds	ae6d91ea-3c93-4e73-a890-315f220847af	1000
maxDeltaTimeSeconds	ae6d91ea-3c93-4e73-a890-315f220847af	43200
failureFactor	ae6d91ea-3c93-4e73-a890-315f220847af	30
realmReusableOtpCode	ae6d91ea-3c93-4e73-a890-315f220847af	false
firstBrokerLoginFlowId	ae6d91ea-3c93-4e73-a890-315f220847af	b4d8aef3-114a-4569-a21e-175dbdbfae5f
displayName	ae6d91ea-3c93-4e73-a890-315f220847af	Keycloak
displayNameHtml	ae6d91ea-3c93-4e73-a890-315f220847af	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	ae6d91ea-3c93-4e73-a890-315f220847af	RS256
offlineSessionMaxLifespanEnabled	ae6d91ea-3c93-4e73-a890-315f220847af	false
offlineSessionMaxLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	5184000
bruteForceProtected	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
permanentLockout	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
maxTemporaryLockouts	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
maxFailureWaitSeconds	bb68fba0-f9aa-4ada-879f-ab68c527b51b	900
minimumQuickLoginWaitSeconds	bb68fba0-f9aa-4ada-879f-ab68c527b51b	60
waitIncrementSeconds	bb68fba0-f9aa-4ada-879f-ab68c527b51b	60
quickLoginCheckMilliSeconds	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1000
maxDeltaTimeSeconds	bb68fba0-f9aa-4ada-879f-ab68c527b51b	43200
failureFactor	bb68fba0-f9aa-4ada-879f-ab68c527b51b	30
realmReusableOtpCode	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
displayName	bb68fba0-f9aa-4ada-879f-ab68c527b51b	PFE - SSO DevSecOps
defaultSignatureAlgorithm	bb68fba0-f9aa-4ada-879f-ab68c527b51b	RS256
offlineSessionMaxLifespanEnabled	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
offlineSessionMaxLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5184000
actionTokenGeneratedByAdminLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	43200
actionTokenGeneratedByUserLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	300
oauth2DeviceCodeLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	600
oauth2DevicePollingInterval	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5
webAuthnPolicyRpEntityName	bb68fba0-f9aa-4ada-879f-ab68c527b51b	keycloak
webAuthnPolicySignatureAlgorithms	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ES256
webAuthnPolicyRpId	bb68fba0-f9aa-4ada-879f-ab68c527b51b	
webAuthnPolicyAttestationConveyancePreference	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyAuthenticatorAttachment	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyRequireResidentKey	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyUserVerificationRequirement	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyCreateTimeout	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
webAuthnPolicyAvoidSameAuthenticatorRegister	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
webAuthnPolicyRpEntityNamePasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	ES256
webAuthnPolicyRpIdPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	
webAuthnPolicyAttestationConveyancePreferencePasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyRequireResidentKeyPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	not specified
webAuthnPolicyCreateTimeoutPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	false
cibaBackchannelTokenDeliveryMode	bb68fba0-f9aa-4ada-879f-ab68c527b51b	poll
cibaExpiresIn	bb68fba0-f9aa-4ada-879f-ab68c527b51b	120
cibaInterval	bb68fba0-f9aa-4ada-879f-ab68c527b51b	5
cibaAuthRequestedUserHint	bb68fba0-f9aa-4ada-879f-ab68c527b51b	login_hint
parRequestUriLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	60
firstBrokerLoginFlowId	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1b693dbc-45e5-4d72-94b1-884b41e12b26
cibaBackchannelTokenDeliveryMode	ae6d91ea-3c93-4e73-a890-315f220847af	poll
cibaExpiresIn	ae6d91ea-3c93-4e73-a890-315f220847af	120
cibaAuthRequestedUserHint	ae6d91ea-3c93-4e73-a890-315f220847af	login_hint
parRequestUriLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	60
cibaInterval	ae6d91ea-3c93-4e73-a890-315f220847af	5
actionTokenGeneratedByAdminLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	43200
actionTokenGeneratedByUserLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	300
webAuthnPolicyRpEntityName	ae6d91ea-3c93-4e73-a890-315f220847af	keycloak
webAuthnPolicySignatureAlgorithms	ae6d91ea-3c93-4e73-a890-315f220847af	ES256
webAuthnPolicyRpId	ae6d91ea-3c93-4e73-a890-315f220847af	
webAuthnPolicyAttestationConveyancePreference	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyAuthenticatorAttachment	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyRequireResidentKey	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyUserVerificationRequirement	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyCreateTimeout	ae6d91ea-3c93-4e73-a890-315f220847af	0
webAuthnPolicyAvoidSameAuthenticatorRegister	ae6d91ea-3c93-4e73-a890-315f220847af	false
webAuthnPolicyRpEntityNamePasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	ES256
webAuthnPolicyRpIdPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	
webAuthnPolicyAttestationConveyancePreferencePasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyRequireResidentKeyPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	not specified
webAuthnPolicyCreateTimeoutPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	ae6d91ea-3c93-4e73-a890-315f220847af	false
client-policies.profiles	ae6d91ea-3c93-4e73-a890-315f220847af	{"profiles":[]}
client-policies.policies	ae6d91ea-3c93-4e73-a890-315f220847af	{"policies":[]}
adminEventsExpiration	ae6d91ea-3c93-4e73-a890-315f220847af	31536000
oauth2DeviceCodeLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	600
oauth2DevicePollingInterval	ae6d91ea-3c93-4e73-a890-315f220847af	5
clientSessionIdleTimeout	ae6d91ea-3c93-4e73-a890-315f220847af	0
clientSessionMaxLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	0
clientOfflineSessionIdleTimeout	ae6d91ea-3c93-4e73-a890-315f220847af	0
clientOfflineSessionMaxLifespan	ae6d91ea-3c93-4e73-a890-315f220847af	0
_browser_header.contentSecurityPolicyReportOnly	ae6d91ea-3c93-4e73-a890-315f220847af	
_browser_header.xContentTypeOptions	ae6d91ea-3c93-4e73-a890-315f220847af	nosniff
_browser_header.referrerPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	no-referrer
_browser_header.xRobotsTag	ae6d91ea-3c93-4e73-a890-315f220847af	none
_browser_header.xFrameOptions	ae6d91ea-3c93-4e73-a890-315f220847af	SAMEORIGIN
_browser_header.xXSSProtection	ae6d91ea-3c93-4e73-a890-315f220847af	1; mode=block
_browser_header.contentSecurityPolicy	ae6d91ea-3c93-4e73-a890-315f220847af	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	ae6d91ea-3c93-4e73-a890-315f220847af	max-age=31536000; includeSubDomains
adminEventsExpiration	bb68fba0-f9aa-4ada-879f-ab68c527b51b	31536000
clientSessionIdleTimeout	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
clientSessionMaxLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
clientOfflineSessionIdleTimeout	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
clientOfflineSessionMaxLifespan	bb68fba0-f9aa-4ada-879f-ab68c527b51b	0
client-policies.profiles	bb68fba0-f9aa-4ada-879f-ab68c527b51b	{"profiles":[]}
client-policies.policies	bb68fba0-f9aa-4ada-879f-ab68c527b51b	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	bb68fba0-f9aa-4ada-879f-ab68c527b51b	
_browser_header.xContentTypeOptions	bb68fba0-f9aa-4ada-879f-ab68c527b51b	nosniff
_browser_header.referrerPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	no-referrer
_browser_header.xRobotsTag	bb68fba0-f9aa-4ada-879f-ab68c527b51b	none
_browser_header.xFrameOptions	bb68fba0-f9aa-4ada-879f-ab68c527b51b	SAMEORIGIN
_browser_header.contentSecurityPolicy	bb68fba0-f9aa-4ada-879f-ab68c527b51b	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	bb68fba0-f9aa-4ada-879f-ab68c527b51b	1; mode=block
_browser_header.strictTransportSecurity	bb68fba0-f9aa-4ada-879f-ab68c527b51b	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_CONSENT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_RESET_PASSWORD
bb68fba0-f9aa-4ada-879f-ab68c527b51b	GRANT_CONSENT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	VERIFY_PROFILE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_TOTP
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REMOVE_TOTP
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REVOKE_GRANT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	LOGIN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_LOGIN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	RESET_PASSWORD_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IMPERSONATE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CODE_TO_TOKEN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CUSTOM_REQUIRED_ACTION
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	RESTART_AUTHENTICATION
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_PROFILE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IMPERSONATE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	LOGIN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_PASSWORD_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_VERIFY_USER_CODE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_INITIATED_ACCOUNT_LINKING
bb68fba0-f9aa-4ada-879f-ab68c527b51b	USER_DISABLED_BY_PERMANENT_LOCKOUT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_EXTENSION_GRANT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	TOKEN_EXCHANGE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REGISTER
bb68fba0-f9aa-4ada-879f-ab68c527b51b	LOGOUT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	AUTHREQID_TO_TOKEN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	DELETE_ACCOUNT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_REGISTER
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_LINK_ACCOUNT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	USER_DISABLED_BY_TEMPORARY_LOCKOUT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_PASSWORD
bb68fba0-f9aa-4ada-879f-ab68c527b51b	DELETE_ACCOUNT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	FEDERATED_IDENTITY_LINK_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_DELETE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_FIRST_LOGIN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	VERIFY_EMAIL
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_DELETE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_LOGIN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	RESTART_AUTHENTICATION_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REMOVE_FEDERATED_IDENTITY_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	EXECUTE_ACTIONS
bb68fba0-f9aa-4ada-879f-ab68c527b51b	TOKEN_EXCHANGE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	PERMISSION_TOKEN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_IDENTITY_PROVIDER_LINK_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	EXECUTE_ACTION_TOKEN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_VERIFY_EMAIL
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_EXTENSION_GRANT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_AUTH
bb68fba0-f9aa-4ada-879f-ab68c527b51b	EXECUTE_ACTIONS_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REMOVE_FEDERATED_IDENTITY
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_CODE_TO_TOKEN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_POST_LOGIN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_EMAIL
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REGISTER_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REVOKE_GRANT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	LOGOUT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_EMAIL_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	EXECUTE_ACTION_TOKEN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_UPDATE_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_PROFILE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	AUTHREQID_TO_TOKEN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	FEDERATED_IDENTITY_LINK
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_REGISTER_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_VERIFY_EMAIL_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_IDENTITY_PROVIDER_LINK
bb68fba0-f9aa-4ada-879f-ab68c527b51b	RESET_PASSWORD
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	OAUTH2_DEVICE_AUTH_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_CONSENT
bb68fba0-f9aa-4ada-879f-ab68c527b51b	REMOVE_TOTP_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	VERIFY_EMAIL_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	SEND_RESET_PASSWORD_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CLIENT_UPDATE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_POST_LOGIN_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CUSTOM_REQUIRED_ACTION_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	UPDATE_TOTP_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	CODE_TO_TOKEN
bb68fba0-f9aa-4ada-879f-ab68c527b51b	VERIFY_PROFILE
bb68fba0-f9aa-4ada-879f-ab68c527b51b	GRANT_CONSENT_ERROR
bb68fba0-f9aa-4ada-879f-ab68c527b51b	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_CONSENT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_RESET_PASSWORD
ae6d91ea-3c93-4e73-a890-315f220847af	GRANT_CONSENT
ae6d91ea-3c93-4e73-a890-315f220847af	VERIFY_PROFILE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_TOTP
ae6d91ea-3c93-4e73-a890-315f220847af	REMOVE_TOTP
ae6d91ea-3c93-4e73-a890-315f220847af	REVOKE_GRANT
ae6d91ea-3c93-4e73-a890-315f220847af	LOGIN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_LOGIN
ae6d91ea-3c93-4e73-a890-315f220847af	RESET_PASSWORD_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	IMPERSONATE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CODE_TO_TOKEN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CUSTOM_REQUIRED_ACTION
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	RESTART_AUTHENTICATION
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_PROFILE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	IMPERSONATE
ae6d91ea-3c93-4e73-a890-315f220847af	LOGIN
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_PASSWORD_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_VERIFY_USER_CODE
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_INITIATED_ACCOUNT_LINKING
ae6d91ea-3c93-4e73-a890-315f220847af	USER_DISABLED_BY_PERMANENT_LOCKOUT
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_EXTENSION_GRANT
ae6d91ea-3c93-4e73-a890-315f220847af	TOKEN_EXCHANGE
ae6d91ea-3c93-4e73-a890-315f220847af	REGISTER
ae6d91ea-3c93-4e73-a890-315f220847af	LOGOUT
ae6d91ea-3c93-4e73-a890-315f220847af	AUTHREQID_TO_TOKEN
ae6d91ea-3c93-4e73-a890-315f220847af	DELETE_ACCOUNT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_REGISTER
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_LINK_ACCOUNT
ae6d91ea-3c93-4e73-a890-315f220847af	USER_DISABLED_BY_TEMPORARY_LOCKOUT
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_PASSWORD
ae6d91ea-3c93-4e73-a890-315f220847af	DELETE_ACCOUNT
ae6d91ea-3c93-4e73-a890-315f220847af	FEDERATED_IDENTITY_LINK_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_DELETE
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_FIRST_LOGIN
ae6d91ea-3c93-4e73-a890-315f220847af	VERIFY_EMAIL
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_DELETE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_LOGIN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	RESTART_AUTHENTICATION_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	REMOVE_FEDERATED_IDENTITY_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	EXECUTE_ACTIONS
ae6d91ea-3c93-4e73-a890-315f220847af	TOKEN_EXCHANGE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	PERMISSION_TOKEN
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_IDENTITY_PROVIDER_LINK_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	EXECUTE_ACTION_TOKEN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_VERIFY_EMAIL
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_EXTENSION_GRANT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_AUTH
ae6d91ea-3c93-4e73-a890-315f220847af	EXECUTE_ACTIONS_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	REMOVE_FEDERATED_IDENTITY
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_CODE_TO_TOKEN
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_POST_LOGIN
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_EMAIL
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	REGISTER_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	REVOKE_GRANT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	LOGOUT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_EMAIL_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	EXECUTE_ACTION_TOKEN
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_UPDATE_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_PROFILE
ae6d91ea-3c93-4e73-a890-315f220847af	AUTHREQID_TO_TOKEN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	FEDERATED_IDENTITY_LINK
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_REGISTER_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_VERIFY_EMAIL_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_IDENTITY_PROVIDER_LINK
ae6d91ea-3c93-4e73-a890-315f220847af	RESET_PASSWORD
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	OAUTH2_DEVICE_AUTH_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_CONSENT
ae6d91ea-3c93-4e73-a890-315f220847af	REMOVE_TOTP_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	VERIFY_EMAIL_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	SEND_RESET_PASSWORD_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CLIENT_UPDATE
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_POST_LOGIN_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CUSTOM_REQUIRED_ACTION_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	UPDATE_TOTP_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	CODE_TO_TOKEN
ae6d91ea-3c93-4e73-a890-315f220847af	VERIFY_PROFILE
ae6d91ea-3c93-4e73-a890-315f220847af	GRANT_CONSENT_ERROR
ae6d91ea-3c93-4e73-a890-315f220847af	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
ae6d91ea-3c93-4e73-a890-315f220847af	jboss-logging
bb68fba0-f9aa-4ada-879f-ab68c527b51b	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	ae6d91ea-3c93-4e73-a890-315f220847af
password	password	t	t	bb68fba0-f9aa-4ada-879f-ab68c527b51b
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.redirect_uris (client_id, value) FROM stdin;
668b3405-4a1b-4c81-9cbc-ecd724f328b1	/realms/master/account/*
1781e806-776d-48a5-95ba-839e0a57cd02	/realms/master/account/*
2740f411-4a45-46bc-b875-ffda2b4a420c	/admin/master/console/*
f0275901-ed04-4b9d-ae28-d66de424b069	/realms/pfe/account/*
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	/realms/pfe/account/*
71700017-4f1b-4b6a-9db9-f4a1e50c1202	/admin/pfe/console/*
f79db544-11eb-44c3-a37a-bf20fdf4020d	https://192.168.222.146/iam/
f79db544-11eb-44c3-a37a-bf20fdf4020d	https://192.168.222.146/iam/*
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	https://192.168.222.146/ticketing/
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	https://192.168.222.146/ticketing/*
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	https://192.168.222.146/audit/
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	https://192.168.222.146/audit/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
e8a49f51-2238-4f60-9dc6-8bdcdbd6dfcd	VERIFY_EMAIL	Verify Email	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	VERIFY_EMAIL	50
69556e1a-654a-4c03-9f05-de0b0dffc3fe	UPDATE_PROFILE	Update Profile	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	UPDATE_PROFILE	40
cfaf357b-c89a-46c4-8a42-81d99f93f4c6	CONFIGURE_TOTP	Configure OTP	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	CONFIGURE_TOTP	10
52bd4b35-db81-4e80-b16c-e32dfda17d38	UPDATE_PASSWORD	Update Password	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	UPDATE_PASSWORD	30
1d0f5428-8359-468e-8d64-67e49d222158	TERMS_AND_CONDITIONS	Terms and Conditions	ae6d91ea-3c93-4e73-a890-315f220847af	f	f	TERMS_AND_CONDITIONS	20
eac6034d-c850-4d83-9144-0b9b1044dbfc	delete_account	Delete Account	ae6d91ea-3c93-4e73-a890-315f220847af	f	f	delete_account	60
28fec30d-3755-4498-be11-e09129334c55	delete_credential	Delete Credential	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	delete_credential	100
414174cb-96ea-4eb5-88ed-f04815aac364	update_user_locale	Update User Locale	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	update_user_locale	1000
757d20fc-368c-45e5-8879-b095bfec1219	webauthn-register	Webauthn Register	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	webauthn-register	70
f8ce55c8-11b7-43f0-bd81-27f04206468e	webauthn-register-passwordless	Webauthn Register Passwordless	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	webauthn-register-passwordless	80
755e6572-baa4-470f-abcd-a627425d00b7	VERIFY_PROFILE	Verify Profile	ae6d91ea-3c93-4e73-a890-315f220847af	t	f	VERIFY_PROFILE	90
da7bce31-328f-4553-977e-3ac8037b1701	VERIFY_EMAIL	Verify Email	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	VERIFY_EMAIL	50
f7961fbb-4aea-4b0d-934f-098268ac95ac	UPDATE_PROFILE	Update Profile	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	UPDATE_PROFILE	40
44543fb0-61e9-422f-9cd0-69b0b583971d	CONFIGURE_TOTP	Configure OTP	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	CONFIGURE_TOTP	10
729e6432-a028-40a4-abac-13e34423ba8c	UPDATE_PASSWORD	Update Password	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	UPDATE_PASSWORD	30
524f770b-fee3-4cd7-8709-9a0964223e5e	TERMS_AND_CONDITIONS	Terms and Conditions	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	f	TERMS_AND_CONDITIONS	20
a35055ea-7547-447b-864a-18fe3d897d8a	delete_account	Delete Account	bb68fba0-f9aa-4ada-879f-ab68c527b51b	f	f	delete_account	60
b7cd3903-18c8-4817-b1a9-5389fffdab48	delete_credential	Delete Credential	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	delete_credential	100
bbd16102-13ff-4f6b-abfd-478652e12ec5	update_user_locale	Update User Locale	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	update_user_locale	1000
6d642494-b590-4bad-8db3-1e1f4b37347d	webauthn-register	Webauthn Register	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	webauthn-register	70
3de64db2-a47b-4623-9cfd-f8923446c25a	webauthn-register-passwordless	Webauthn Register Passwordless	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	webauthn-register-passwordless	80
628491ca-d45c-41c9-bfba-fdc8443fa004	VERIFY_PROFILE	Verify Profile	bb68fba0-f9aa-4ada-879f-ab68c527b51b	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
1781e806-776d-48a5-95ba-839e0a57cd02	ee4bef42-94f6-4f11-a0f7-48f9e5a505aa
1781e806-776d-48a5-95ba-839e0a57cd02	60102683-778e-4e02-9784-24a3fb08f744
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	09a3614f-067f-4d65-bc13-78e052cf5d10
9a4d6b4c-8860-4227-8bc0-4d9d266adc01	31cc64dc-2fd6-4d72-bf61-cf1ca77e1d2c
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice@pfe.local	alice@pfe.local	t	t	\N	Alice	Admin	bb68fba0-f9aa-4ada-879f-ab68c527b51b	alice	\N	\N	0
088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob@pfe.local	bob@pfe.local	t	t	\N	Bob	Manager	bb68fba0-f9aa-4ada-879f-ab68c527b51b	bob	\N	\N	0
d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie@pfe.local	charlie@pfe.local	t	t	\N	Charlie	User	bb68fba0-f9aa-4ada-879f-ab68c527b51b	charlie	\N	\N	0
20bb810c-509c-48ac-be27-ec55ff54af6d	\N	ac039585-5051-479c-abc2-39480a8971fe	f	t	\N	\N	\N	ae6d91ea-3c93-4e73-a890-315f220847af	admin	1777494254668	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
7d9bd86c-6fca-4018-96ac-6cc0ca5d219f	8b29a123-9c36-4eb8-bcfa-fc79533e90e7
c9a443e0-9de0-4b49-9241-d7aca6de2e72	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef
e17b25fc-4b72-46d3-8fed-e3df2d6dd16f	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1
c277df1c-ed33-4f5c-a640-c51766d8a67e	20bb810c-509c-48ac-be27-ec55ff54af6d
04b88942-f33e-495f-b8d3-7a7050554b9c	20bb810c-509c-48ac-be27-ec55ff54af6d
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.web_origins (client_id, value) FROM stdin;
2740f411-4a45-46bc-b875-ffda2b4a420c	+
71700017-4f1b-4b6a-9db9-f4a1e50c1202	+
f79db544-11eb-44c3-a37a-bf20fdf4020d	https://192.168.222.146
2dd6d604-7ec8-47e7-b4c9-28fedcc7dfca	https://192.168.222.146
9e3d3f74-aefc-4bf6-8532-d6bb46e262a4	https://192.168.222.146
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict 9PFNqlUg0qItVfcUfHQiksPAQIHj55WegZH5QGMUDLDdSDDYcmgF9tDlyGTcTwG

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict 3AH4fkXT7itBrfEhmBibcAImtn7jV28exca7qkHCklq4wsxnwdPcimALvBXetGM

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

\unrestrict 3AH4fkXT7itBrfEhmBibcAImtn7jV28exca7qkHCklq4wsxnwdPcimALvBXetGM

--
-- Database "ticketing_db" dump
--

--
-- PostgreSQL database dump
--

\restrict 2NWAxPkFEwRfUFD6DncxGQaCGKVFm2EWABP0iQH5w8I56dyRXdIxtTKgQGeMxfb

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ticketing_db; Type: DATABASE; Schema: -; Owner: pfe
--

CREATE DATABASE ticketing_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE ticketing_db OWNER TO pfe;

\unrestrict 2NWAxPkFEwRfUFD6DncxGQaCGKVFm2EWABP0iQH5w8I56dyRXdIxtTKgQGeMxfb
\connect ticketing_db
\restrict 2NWAxPkFEwRfUFD6DncxGQaCGKVFm2EWABP0iQH5w8I56dyRXdIxtTKgQGeMxfb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.audit_log (
    id integer NOT NULL,
    username character varying(255),
    action character varying(255),
    details text,
    ip_address character varying(45),
    severity character varying(20) DEFAULT 'INFO'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.audit_log OWNER TO pfe;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.audit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_log_id_seq OWNER TO pfe;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: ticket_history; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.ticket_history (
    id integer NOT NULL,
    ticket_id integer,
    status character varying(20) NOT NULL,
    changed_by character varying(100) NOT NULL,
    changed_at timestamp without time zone DEFAULT now(),
    ip_address character varying(45),
    user_agent character varying(512),
    hour_of_day integer,
    session_id character varying(128)
);


ALTER TABLE public.ticket_history OWNER TO pfe;

--
-- Name: ticket_history_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.ticket_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_history_id_seq OWNER TO pfe;

--
-- Name: ticket_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.ticket_history_id_seq OWNED BY public.ticket_history.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    priority character varying(20) DEFAULT 'medium'::character varying,
    status character varying(20) DEFAULT 'open'::character varying,
    created_by character varying(255) NOT NULL,
    created_by_name character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    assigned_to character varying DEFAULT ''::character varying,
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tickets OWNER TO pfe;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_id_seq OWNER TO pfe;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: pfe
--

CREATE TABLE public.users (
    id integer NOT NULL,
    keycloak_id character varying(255) NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: pfe
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO pfe;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pfe
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: ticket_history id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.ticket_history ALTER COLUMN id SET DEFAULT nextval('public.ticket_history_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.audit_log (id, username, action, details, ip_address, severity, created_at) FROM stdin;
1	unknown	view_tickets	{'total': 5, 'filter_status': 'all', 'filter_priority': 'all'}	172.18.0.1	INFO	2026-05-02 11:15:12.160413
2	unknown	view_tickets	{'total': 5, 'filter_status': 'all', 'filter_priority': 'all'}	172.18.0.1	INFO	2026-05-02 11:20:32.756375
3	Charlie User	view_tickets	{'total': 5, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 12:55:20.188774
4	Charlie User	view_new_ticket_form	{'page': 'new_ticket'}	192.168.222.1	INFO	2026-05-02 12:55:27.057684
5	Charlie User	create_ticket	{'ticket_id': 6, 'title': 'qsedrftghjklmù', 'priority': 'medium', 'status': 'open'}	192.168.222.1	INFO	2026-05-02 12:55:34.805969
6	Charlie User	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 12:55:34.852272
7	Charlie User	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 12:55:38.987925
8	Charlie User	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 12:55:48.068129
9	Charlie User	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 12:56:36.014242
10	Alice Admin	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 12:58:05.154415
11	Alice Admin	logout	{'username': 'Alice Admin', 'ip_address': '192.168.222.143'}	192.168.222.143	INFO	2026-05-02 12:58:16.996665
12	unknown	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 12:58:50.220132
13	unknown	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.146	INFO	2026-05-02 13:04:23.848339
14	Charlie User	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 13:31:22.85295
15	unknown	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.146	INFO	2026-05-02 13:34:15.992987
16	unknown	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 13:48:27.308712
17	unknown	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.146	INFO	2026-05-02 14:14:05.153778
18	unknown	login_attempt	{'page': 'login'}	192.168.222.143	INFO	2026-05-02 14:49:57.102817
19	Alice Admin	view_tickets	{'total': 6, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:50:25.814372
20	Alice Admin	view_new_ticket_form	{'page': 'new_ticket'}	192.168.222.143	INFO	2026-05-02 14:50:39.367117
21	Alice Admin	create_ticket	{'ticket_id': 7, 'title': 'sdfghn,', 'priority': 'medium', 'status': 'open'}	192.168.222.143	INFO	2026-05-02 14:50:43.058399
22	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:50:43.111685
23	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:50:48.231437
24	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:50:49.624139
25	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:56:55.76337
26	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:57:00.946975
27	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:57:01.712185
28	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 14:57:33.236205
29	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 15:18:59.638976
30	Alice Admin	logout	{'username': 'Alice Admin', 'ip_address': '192.168.222.143'}	192.168.222.143	INFO	2026-05-02 15:19:04.352207
31	unknown	login_attempt	{'page': 'login'}	192.168.222.143	INFO	2026-05-02 15:24:21.980797
32	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 15:24:30.852023
33	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 15:24:39.459295
34	Alice Admin	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 15:24:48.306298
35	Charlie User	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:32:28.788664
36	Charlie User	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:37:27.364023
37	Charlie User	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:37:34.167171
38	Charlie User	logout	{'username': 'Charlie User', 'ip_address': '192.168.222.1'}	192.168.222.1	INFO	2026-05-02 15:37:39.077717
39	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 15:52:00.603132
40	Bob Manager	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:52:00.715775
41	Bob Manager	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:52:32.272347
42	Bob Manager	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:52:36.809257
43	Bob Manager	view_tickets	{'total': 7, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:53:26.700389
44	Bob Manager	view_new_ticket_form	{'page': 'new_ticket'}	192.168.222.1	INFO	2026-05-02 15:53:28.826421
45	Bob Manager	create_ticket	{'ticket_id': 8, 'title': 'azerftgyhuj', 'priority': 'medium', 'status': 'open'}	192.168.222.1	INFO	2026-05-02 15:53:31.801103
46	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:53:31.856246
47	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 15:53:34.247061
48	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:18:22.990927
49	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:35:10.576478
50	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:43:07.509562
51	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:43:32.103328
52	Bob Manager	view_tickets	{'total': 8, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:44:32.001036
53	Bob Manager	view_new_ticket_form	{'page': 'new_ticket'}	192.168.222.1	INFO	2026-05-02 16:44:33.493606
54	Bob Manager	create_ticket	{'ticket_id': 9, 'title': 'sdrftgyhujklm', 'priority': 'medium', 'status': 'open'}	192.168.222.1	INFO	2026-05-02 16:44:36.642138
55	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 16:44:36.68632
129	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:10.861532
56	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:04:04.778306
57	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:12:24.424123
58	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:12:36.92597
59	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:16:23.17419
60	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:19:54.397894
61	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:21:43.202551
62	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:25:26.546134
63	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:35:09.426201
64	Bob Manager	logout	{'username': 'Bob Manager', 'ip_address': '192.168.222.1'}	192.168.222.1	INFO	2026-05-02 17:35:10.613939
65	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 17:47:17.643468
66	Bob Manager	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:47:17.739713
67	Bob Manager	logout	{'username': 'Bob Manager', 'ip_address': '192.168.222.1'}	192.168.222.1	INFO	2026-05-02 17:47:19.955913
68	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 17:54:03.483829
69	Alice Admin	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:54:03.587827
70	Alice Admin	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:54:03.892432
71	Alice Admin	logout	{'username': 'Alice Admin', 'ip_address': '192.168.222.1'}	192.168.222.1	INFO	2026-05-02 17:54:06.171352
72	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 17:55:09.398299
73	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 17:55:14.251971
74	Alice Admin	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:55:22.129619
75	Alice Admin	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 17:55:22.25376
76	Alice Admin	logout	{'username': 'Alice Admin', 'ip_address': '192.168.222.1'}	192.168.222.1	INFO	2026-05-02 17:55:55.393152
77	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:00:25.084393
78	Charlie User	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 18:00:25.173375
79	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:25:46.138397
80	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:26:21.033608
81	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:26:22.181801
82	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:46.807987
83	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:47.205139
84	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:47.337493
85	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:48.665386
86	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:48.904357
87	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:49.024655
88	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:49.295142
89	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:51.964646
90	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:52.126522
91	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:52.363251
92	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:52.483756
93	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:53.733993
94	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:53.870277
95	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:54.107392
96	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:54.236976
97	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:54.997375
98	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:55.116105
99	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:55.346681
100	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:56.368782
101	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:56.662771
102	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:56.814662
103	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:58.792629
104	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:58.931009
105	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:59.048442
106	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:41:59.97213
107	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:00.085384
108	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:00.19909
109	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:01.157051
110	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:01.282806
111	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:01.409902
112	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:01.813798
113	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:02.050637
114	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:03.877231
115	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:04.003022
116	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:04.223686
117	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:04.345571
118	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:05.419472
119	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:05.538995
120	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:05.772648
121	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:42:05.899366
122	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:03.45129
123	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:03.570875
124	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:03.685956
125	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:05.08871
126	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:05.206931
127	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:05.329456
128	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:10.732748
130	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:11.224385
131	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:11.930837
132	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:12.045082
133	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:12.230685
134	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 18:43:12.451752
135	unknown	login_attempt	{'page': 'login'}	192.168.222.146	INFO	2026-05-02 19:07:01.203402
136	unknown	login_attempt	{'page': 'login'}	192.168.222.146	INFO	2026-05-02 19:12:21.812714
137	unknown	login_attempt	{'page': 'login'}	192.168.222.146	INFO	2026-05-02 19:12:22.797316
138	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 19:19:37.620225
139	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 19:19:37.74585
140	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:08:19.587892
141	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:08:19.68748
142	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:09:02.429645
143	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:12:02.743976
144	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:12:02.849829
145	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:12:04.405784
146	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:12:19.781764
147	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:12:21.804909
148	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:12:30.812047
149	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:12:38.988532
150	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:13:12.750776
151	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:13:14.61349
152	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:36:44.708163
153	unknown	view_tickets	{'total': 9, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:36:44.799771
154	unknown	view_new_ticket_form	{'page': 'new_ticket'}	192.168.222.1	INFO	2026-05-02 20:36:59.216872
155	unknown	create_ticket	{'ticket_id': 10, 'title': 'sdfgh', 'priority': 'medium', 'status': 'open'}	192.168.222.1	INFO	2026-05-02 20:37:02.057208
156	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:37:02.112451
157	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:37:09.723667
158	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:44:01.994829
159	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 20:44:04.561526
160	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:16.921751
161	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:19.757009
162	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:20.521441
163	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:20.695054
164	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:20.860946
165	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:21.057804
166	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:48:28.459073
167	Alice Admin	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 20:50:37.403869
168	Alice Admin	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 20:50:40.833719
169	Alice Admin	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 20:52:19.108598
170	Alice Admin	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.143	INFO	2026-05-02 20:52:19.945349
171	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:54:09.052601
172	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:54:09.247476
173	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 20:54:42.948035
174	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:03:50.524581
175	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:10:22.673746
176	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:33:44.001401
177	unknown	login_attempt	{'page': 'login'}	192.168.222.1	INFO	2026-05-02 21:34:42.021428
178	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:34:56.244184
179	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:35:12.413635
180	unknown	view_tickets	{'total': 10, 'filter_status': 'all', 'filter_priority': 'all'}	192.168.222.1	INFO	2026-05-02 21:38:52.249544
\.


--
-- Data for Name: ticket_history; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.ticket_history (id, ticket_id, status, changed_by, changed_at, ip_address, user_agent, hour_of_day, session_id) FROM stdin;
1	1	open	bob	2026-05-01 12:59:53.359654	\N	\N	\N	\N
2	1	closed	alice	2026-05-01 13:12:06.27502	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	\N
3	2	open	alice	2026-05-01 13:46:58.509674	\N	\N	\N	\N
4	3	open	charlie	2026-05-01 13:49:02.491635	\N	\N	\N	\N
5	4	open	charlie	2026-05-01 13:49:14.572973	\N	\N	\N	\N
6	4	in_progress	bob	2026-05-01 13:49:35.630794	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	\N
7	2	in_progress	bob	2026-05-01 13:49:50.353924	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	\N
8	3	in_progress	bob	2026-05-01 16:57:10.752965	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36 Edg/147.0.0.0	\N	\N
9	2	closed	alice	2026-05-01 17:51:22.14691	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	\N
10	2	closed	alice	2026-05-01 17:51:23.580381	192.168.222.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36	\N	\N
11	5	open	alice	2026-05-02 08:43:50.226057	\N	\N	\N	\N
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.tickets (id, title, description, priority, status, created_by, created_by_name, created_at, assigned_to, updated_at) FROM stdin;
1	vpn	urgent	high	closed	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	2026-05-01 12:59:53.342291		2026-05-02 10:34:33.904506
4	eeeeee		medium	in_progress	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	2026-05-01 13:49:14.555345		2026-05-02 10:34:33.904506
3	eee		medium	in_progress	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	2026-05-01 13:49:02.477037		2026-05-02 10:34:33.904506
2	password		medium	closed	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	2026-05-01 13:46:58.495023		2026-05-02 10:34:33.904506
5	dd		medium	open	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	2026-05-02 08:43:50.196392		2026-05-02 10:34:33.904506
6	qsedrftghjklmù		medium	open	Charlie User	\N	2026-05-02 12:55:34.786905		2026-05-02 12:55:34.786905
7	sdfghn,		medium	open	Alice Admin	\N	2026-05-02 14:50:42.930294		2026-05-02 14:50:42.930294
8	azerftgyhuj		medium	open	Bob Manager	\N	2026-05-02 15:53:31.780179		2026-05-02 15:53:31.780179
9	sdrftgyhujklm		medium	open	Bob Manager	\N	2026-05-02 16:44:36.624531		2026-05-02 16:44:36.624531
10	sdfgh		medium	open	unknown	\N	2026-05-02 20:37:02.029444		2026-05-02 20:37:02.029444
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pfe
--

COPY public.users (id, keycloak_id, username, email, created_at) FROM stdin;
1	d2ab07c5-32d0-41fe-aba7-bd3d776c12d1	charlie	charlie@pfe.local	2026-05-01 01:56:00.507184
2	8b29a123-9c36-4eb8-bcfa-fc79533e90e7	alice	alice@pfe.local	2026-05-01 12:56:44.965942
3	088d8cf4-7b38-4eaf-9f6f-a921a9b4d6ef	bob	bob@pfe.local	2026-05-01 12:58:24.14578
\.


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 180, true);


--
-- Name: ticket_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.ticket_history_id_seq', 11, true);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.tickets_id_seq', 10, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pfe
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: ticket_history ticket_history_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.ticket_history
    ADD CONSTRAINT ticket_history_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_keycloak_id_key; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_keycloak_id_key UNIQUE (keycloak_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_ticket_history_changed_at; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_ticket_history_changed_at ON public.ticket_history USING btree (changed_at);


--
-- Name: idx_ticket_history_changed_by; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_ticket_history_changed_by ON public.ticket_history USING btree (changed_by);


--
-- Name: idx_ticket_history_hour; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_ticket_history_hour ON public.ticket_history USING btree (hour_of_day);


--
-- Name: idx_tickets_status; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_tickets_status ON public.tickets USING btree (status);


--
-- Name: idx_tickets_user; Type: INDEX; Schema: public; Owner: pfe
--

CREATE INDEX idx_tickets_user ON public.tickets USING btree (created_by);


--
-- Name: ticket_history ticket_history_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pfe
--

ALTER TABLE ONLY public.ticket_history
    ADD CONSTRAINT ticket_history_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.tickets(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict 2NWAxPkFEwRfUFD6DncxGQaCGKVFm2EWABP0iQH5w8I56dyRXdIxtTKgQGeMxfb

--
-- PostgreSQL database cluster dump complete
--

