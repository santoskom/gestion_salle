--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-06-23 10:57:02

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 231 (class 1259 OID 17665)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17672)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 34312)
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255),
    phone character varying(255),
    email character varying(255),
    logo character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.company OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 34311)
-- Name: company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.company_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 249
-- Name: company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_id_seq OWNED BY public.company.id;


--
-- TOC entry 222 (class 1259 OID 17601)
-- Name: departements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departements (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    description character varying(255),
    responsable character varying(255),
    telephone character varying(255),
    localisation character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    company_id bigint
);


ALTER TABLE public.departements OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17600)
-- Name: departements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departements_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 221
-- Name: departements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departements_id_seq OWNED BY public.departements.id;


--
-- TOC entry 243 (class 1259 OID 17840)
-- Name: equipement_reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipement_reservation (
    id bigint NOT NULL,
    reservation_id bigint NOT NULL,
    equipement_id bigint NOT NULL
);


ALTER TABLE public.equipement_reservation OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17839)
-- Name: equipement_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipement_reservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipement_reservation_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 242
-- Name: equipement_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipement_reservation_id_seq OWNED BY public.equipement_reservation.id;


--
-- TOC entry 239 (class 1259 OID 17762)
-- Name: equipements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipements (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    description character varying(255),
    numero_serie character varying(255),
    marque character varying(255),
    modele character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.equipements OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17761)
-- Name: equipements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipements_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 238
-- Name: equipements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipements_id_seq OWNED BY public.equipements.id;


--
-- TOC entry 237 (class 1259 OID 17697)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17696)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 236
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 235 (class 1259 OID 17689)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17680)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17679)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 233
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 218 (class 1259 OID 17565)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17564)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 248 (class 1259 OID 34252)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    type character varying(255) NOT NULL,
    notifiable_type character varying(255) NOT NULL,
    notifiable_id bigint NOT NULL,
    data text NOT NULL,
    read_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17649)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17610)
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17609)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- TOC entry 241 (class 1259 OID 17813)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id bigint NOT NULL,
    salle_id bigint NOT NULL,
    id_demandeur bigint,
    id_createur bigint,
    objet_reunion character varying(255) NOT NULL,
    description text,
    date_debut timestamp without time zone NOT NULL,
    date_fin timestamp without time zone NOT NULL,
    statut character varying(255) DEFAULT 'en_attente'::character varying NOT NULL,
    "nombreParticipants" integer NOT NULL,
    rappel_active boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT reservations_statut_check CHECK (((statut)::text = ANY ((ARRAY['en_attente'::character varying, 'valide'::character varying, 'annulee'::character varying])::text[])))
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17812)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservations_id_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 240
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- TOC entry 247 (class 1259 OID 26099)
-- Name: reset_code_passwords; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reset_code_passwords (
    id bigint NOT NULL,
    code character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.reset_code_passwords OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 26098)
-- Name: reset_code_passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reset_code_passwords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reset_code_passwords_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 246
-- Name: reset_code_passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reset_code_passwords_id_seq OWNED BY public.reset_code_passwords.id;


--
-- TOC entry 226 (class 1259 OID 17617)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    nom character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17616)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 225
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 220 (class 1259 OID 17581)
-- Name: salles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salles (
    id bigint NOT NULL,
    nom character varying(255),
    capacite integer,
    localisation character varying(255),
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    company_id bigint
);


ALTER TABLE public.salles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17580)
-- Name: salles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salles_id_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 219
-- Name: salles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salles_id_seq OWNED BY public.salles.id;


--
-- TOC entry 230 (class 1259 OID 17656)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 26075)
-- Name: user_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permission (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    id_permission bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.user_permission OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 26074)
-- Name: user_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_permission_id_seq OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_permission_id_seq OWNED BY public.user_permission.id;


--
-- TOC entry 228 (class 1259 OID 17624)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    id_role bigint NOT NULL,
    departement_id bigint NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    receive_notifications boolean DEFAULT true,
    company_id bigint
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17623)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 227
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4848 (class 2604 OID 34315)
-- Name: company id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN id SET DEFAULT nextval('public.company_id_seq'::regclass);


--
-- TOC entry 4833 (class 2604 OID 17604)
-- Name: departements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departements ALTER COLUMN id SET DEFAULT nextval('public.departements_id_seq'::regclass);


--
-- TOC entry 4845 (class 2604 OID 17843)
-- Name: equipement_reservation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement_reservation ALTER COLUMN id SET DEFAULT nextval('public.equipement_reservation_id_seq'::regclass);


--
-- TOC entry 4841 (class 2604 OID 17765)
-- Name: equipements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipements ALTER COLUMN id SET DEFAULT nextval('public.equipements_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 17700)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4838 (class 2604 OID 17683)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4831 (class 2604 OID 17568)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 17613)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- TOC entry 4842 (class 2604 OID 17816)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 4847 (class 2604 OID 26102)
-- Name: reset_code_passwords id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_code_passwords ALTER COLUMN id SET DEFAULT nextval('public.reset_code_passwords_id_seq'::regclass);


--
-- TOC entry 4835 (class 2604 OID 17620)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4832 (class 2604 OID 17584)
-- Name: salles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles ALTER COLUMN id SET DEFAULT nextval('public.salles_id_seq'::regclass);


--
-- TOC entry 4846 (class 2604 OID 26078)
-- Name: user_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission ALTER COLUMN id SET DEFAULT nextval('public.user_permission_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 17627)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5073 (class 0 OID 17665)
-- Dependencies: 231
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 5074 (class 0 OID 17672)
-- Dependencies: 232
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5092 (class 0 OID 34312)
-- Dependencies: 250
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (id, name, address, phone, email, logo, created_at, updated_at) FROM stdin;
1	PANZANI	Rue : douala dokoti , ....	+23723456789	PANZANI@CADYST.com	companys/cDPSEDd4rOmGIeIgNkIc6aDGjNzg7IZECTRXrbKx.png	2025-05-09 12:10:19	2025-05-09 12:36:01
3	CADYST GROUPE	ndossimi	+36778901234	GROUPE@CADYST.COM	companys/zFdci4luHN5O2litROcYqtktoQI1AjEng76nS8D9.png	2025-05-09 12:10:19	2025-05-09 12:37:14
4	UMS	bonaberi carrefou musik	+23769999999	Ums@cadyst.com	companys/Oit2spIVc25DsALlehCpxsgsmTVTNWBljHV9R7Kh.jpg	2025-05-09 12:34:58	2025-05-09 12:54:39
\.


--
-- TOC entry 5064 (class 0 OID 17601)
-- Dependencies: 222
-- Data for Name: departements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departements (id, nom, description, responsable, telephone, localisation, created_at, updated_at, company_id) FROM stdin;
1	Ressources Humaines	Gestion du personnel et du recrutements	Sophie Durand	0123456789	Bâtiment A, 2e étage	\N	2025-04-29 12:54:57	\N
3	Comptabilités	Gestion des finances et de la trésorerie	Caroline Moreau	0123456791	Bâtiment A, 3e étage	\N	2025-04-29 16:46:34	\N
4	Marketing	Promotion des produits et de l’image de l’entreprises	Pauline Garcia	0123456792	Bâtiment C, RDC	\N	2025-05-09 22:10:11	\N
8	fggjjjjjjjjj	gg	fg	6666666	fgfgfkj	2025-05-09 16:42:54	2025-05-10 08:13:59	4
5	Direction Générale	Supervision de l’entreprise	Jean-Baptiste Martin	0123456793	Bâtiment A, 4e étage	\N	2025-05-10 08:14:16	4
12	rh	gere les humains	chef	691178267	bureau a cote de ..	2025-06-07 13:02:10	2025-06-07 13:02:10	4
\.


--
-- TOC entry 5085 (class 0 OID 17840)
-- Dependencies: 243
-- Data for Name: equipement_reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipement_reservation (id, reservation_id, equipement_id) FROM stdin;
4	12	1
5	12	4
6	12	7
7	13	1
8	13	4
9	13	5
10	14	1
11	14	4
12	14	5
13	15	1
14	15	4
15	16	1
16	16	4
17	17	1
18	18	2
19	19	2
20	20	2
21	21	1
22	21	2
29	25	2
30	26	2
31	27	2
32	28	2
34	30	1
35	30	2
36	31	1
37	31	2
38	32	1
39	32	2
40	33	1
41	33	2
42	33	3
43	33	5
44	34	1
45	35	7
46	36	7
47	37	7
48	40	1
49	40	4
50	41	1
51	41	2
52	42	1
53	42	5
54	43	1
56	45	2
57	46	2
58	47	2
59	47	5
60	48	1
61	48	10
64	51	1
66	53	1
67	54	1
68	55	1
69	57	1
70	58	1
71	58	4
72	59	1
73	60	1
74	61	1
75	63	1
86	66	1
87	66	2
88	66	5
89	67	1
90	67	2
91	67	4
92	67	5
93	68	7
96	72	1
97	72	2
98	72	4
99	73	3
100	73	4
106	76	4
107	77	1
108	77	10
109	78	1
111	81	1
114	84	10
115	87	4
116	88	1
117	89	2
119	92	1
120	93	1
121	94	1
122	95	1
123	96	1
124	97	10
125	98	1
126	98	5
\.


--
-- TOC entry 5081 (class 0 OID 17762)
-- Dependencies: 239
-- Data for Name: equipements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipements (id, nom, description, numero_serie, marque, modele, created_at, updated_at) FROM stdin;
1	Vidéoprojecteur	Vidéoprojecteur Full HD pour présentations	VP-2024-0001	Epson	EB-X41	\N	\N
2	Ordinateur Portable	PC portable pour la salle de réunion	PC-2024-0002	Dell	Latitude 5420	\N	\N
3	Tableau Blanc	Tableau blanc magnétique effaçable	TB-2024-0003	Bi-Office	Earth-It	\N	\N
4	Système Audio	Enceintes avec micro sans fil	SA-2024-0004	Bose	S1 Pro	\N	\N
5	Caméra de Visio	Caméra HD pour visioconférences	CV-2024-0005	Logitech	Rally Bar	\N	\N
7	ruutut	jrjjtgjjg	47tbtbt	ifgbjjgjrir	u	2025-04-29 16:41:13	2025-04-29 17:02:43
10	matchait	Elle permes as coupe les serbe	47	MT	A4	2025-05-15 19:06:27	2025-05-15 19:06:27
\.


--
-- TOC entry 5079 (class 0 OID 17697)
-- Dependencies: 237
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
1	d35c7b62-63dd-47cf-8dac-80a60f0a0467	database	default	{"uuid":"d35c7b62-63dd-47cf-8dac-80a60f0a0467","displayName":"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:60:\\"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated\\":3:{s:10:\\"notifiable\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";i:29;s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:44:\\"App\\\\Notifications\\\\NouvelleDemandeReservation\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:12;s:9:\\"relations\\";a:2:{i:0;s:9:\\"demandeur\\";i:1;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"3a5138f4-5879-4b4c-aec6-370ffeedaa72\\";}s:4:\\"data\\";a:10:{s:14:\\"reservation_id\\";i:12;s:5:\\"titre\\";s:32:\\"Nouvelle demande de réservation\\";s:7:\\"message\\";s:51:\\"Demande de  pour la salle 'Salle D04' le 18\\/05\\/2025\\";s:3:\\"url\\";s:16:\\"\\/reservations\\/12\\";s:5:\\"salle\\";s:9:\\"Salle D04\\";s:9:\\"demandeur\\";N;s:4:\\"date\\";s:10:\\"18\\/05\\/2025\\";s:11:\\"heure_debut\\";s:5:\\"2025-\\";s:9:\\"heure_fin\\";s:5:\\"2025-\\";s:5:\\"objet\\";s:6:\\"sprint\\";}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Error: The script tried to call a method on an incomplete object. Please ensure that the class definition "App\\Notifications\\NouvelleDemandeReservation" of the object you are trying to operate on was loaded _before_ unserialize() gets called or provide an autoloader to load the class definition in C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php:110\nStack trace:\n#0 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php(110): method_exists()\n#1 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(77): Illuminate\\Notifications\\Events\\BroadcastNotificationCreated->broadcastAs()\n#2 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle()\n#3 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#4 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#5 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#6 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#7 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(125): Illuminate\\Container\\Container->call()\n#8 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():122}()\n#9 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#10 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Pipeline\\Pipeline->then()\n#11 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(125): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#12 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():120}()\n#13 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#14 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Pipeline\\Pipeline->then()\n#15 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#16 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#17 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(441): Illuminate\\Queue\\Jobs\\Job->fire()\n#18 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(391): Illuminate\\Queue\\Worker->process()\n#19 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(177): Illuminate\\Queue\\Worker->runJob()\n#20 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#21 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#22 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#23 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#24 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#25 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#26 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#27 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call()\n#28 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute()\n#29 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#30 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run()\n#31 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand()\n#32 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun()\n#33 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#34 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1234): Illuminate\\Foundation\\Console\\Kernel->handle()\n#35 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#36 {main}	2025-05-14 11:36:42
2	86bf6ac9-4a99-40e1-9128-3381a8a6af27	database	default	{"uuid":"86bf6ac9-4a99-40e1-9128-3381a8a6af27","displayName":"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:60:\\"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated\\":3:{s:10:\\"notifiable\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";i:28;s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:44:\\"App\\\\Notifications\\\\NouvelleDemandeReservation\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:12;s:9:\\"relations\\";a:2:{i:0;s:9:\\"demandeur\\";i:1;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"d49e1ef6-0867-4f86-b554-86d862046f27\\";}s:4:\\"data\\";a:10:{s:14:\\"reservation_id\\";i:12;s:5:\\"titre\\";s:32:\\"Nouvelle demande de réservation\\";s:7:\\"message\\";s:51:\\"Demande de  pour la salle 'Salle D04' le 18\\/05\\/2025\\";s:3:\\"url\\";s:16:\\"\\/reservations\\/12\\";s:5:\\"salle\\";s:9:\\"Salle D04\\";s:9:\\"demandeur\\";N;s:4:\\"date\\";s:10:\\"18\\/05\\/2025\\";s:11:\\"heure_debut\\";s:5:\\"2025-\\";s:9:\\"heure_fin\\";s:5:\\"2025-\\";s:5:\\"objet\\";s:6:\\"sprint\\";}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Error: The script tried to call a method on an incomplete object. Please ensure that the class definition "App\\Notifications\\NouvelleDemandeReservation" of the object you are trying to operate on was loaded _before_ unserialize() gets called or provide an autoloader to load the class definition in C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php:110\nStack trace:\n#0 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php(110): method_exists()\n#1 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(77): Illuminate\\Notifications\\Events\\BroadcastNotificationCreated->broadcastAs()\n#2 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle()\n#3 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#4 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#5 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#6 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#7 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(125): Illuminate\\Container\\Container->call()\n#8 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():122}()\n#9 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#10 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Pipeline\\Pipeline->then()\n#11 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(125): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#12 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():120}()\n#13 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#14 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Pipeline\\Pipeline->then()\n#15 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#16 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#17 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(441): Illuminate\\Queue\\Jobs\\Job->fire()\n#18 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(391): Illuminate\\Queue\\Worker->process()\n#19 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(177): Illuminate\\Queue\\Worker->runJob()\n#20 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#21 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#22 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#23 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#24 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#25 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#26 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#27 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call()\n#28 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute()\n#29 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#30 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run()\n#31 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand()\n#32 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun()\n#33 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#34 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1234): Illuminate\\Foundation\\Console\\Kernel->handle()\n#35 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#36 {main}	2025-05-14 11:36:42
3	702ece33-2692-4e8f-90f7-065756e5ad60	database	default	{"uuid":"702ece33-2692-4e8f-90f7-065756e5ad60","displayName":"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:60:\\"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated\\":3:{s:10:\\"notifiable\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";i:29;s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:44:\\"App\\\\Notifications\\\\NouvelleDemandeReservation\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:16;s:9:\\"relations\\";a:2:{i:0;s:9:\\"demandeur\\";i:1;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5f0b4422-3923-4133-ae0f-0a5cc869a110\\";}s:4:\\"data\\";a:10:{s:14:\\"reservation_id\\";i:16;s:5:\\"titre\\";s:32:\\"Nouvelle demande de réservation\\";s:7:\\"message\\";s:50:\\"Demande de  pour la salle 'Salle-A2' le 09\\/05\\/2025\\";s:3:\\"url\\";s:16:\\"\\/reservations\\/16\\";s:5:\\"salle\\";s:8:\\"Salle-A2\\";s:9:\\"demandeur\\";N;s:4:\\"date\\";s:10:\\"09\\/05\\/2025\\";s:11:\\"heure_debut\\";s:5:\\"2025-\\";s:9:\\"heure_fin\\";s:5:\\"2025-\\";s:5:\\"objet\\";s:40:\\"Réunion de la coopérative d'entreprise\\";}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Error: The script tried to call a method on an incomplete object. Please ensure that the class definition "App\\Notifications\\NouvelleDemandeReservation" of the object you are trying to operate on was loaded _before_ unserialize() gets called or provide an autoloader to load the class definition in C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php:110\nStack trace:\n#0 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php(110): method_exists()\n#1 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(77): Illuminate\\Notifications\\Events\\BroadcastNotificationCreated->broadcastAs()\n#2 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle()\n#3 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#4 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#5 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#6 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#7 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(125): Illuminate\\Container\\Container->call()\n#8 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():122}()\n#9 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#10 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Pipeline\\Pipeline->then()\n#11 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(125): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#12 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():120}()\n#13 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#14 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Pipeline\\Pipeline->then()\n#15 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#16 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#17 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(441): Illuminate\\Queue\\Jobs\\Job->fire()\n#18 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(391): Illuminate\\Queue\\Worker->process()\n#19 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(177): Illuminate\\Queue\\Worker->runJob()\n#20 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#21 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#22 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#23 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#24 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#25 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#26 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#27 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call()\n#28 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute()\n#29 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#30 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run()\n#31 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand()\n#32 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun()\n#33 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#34 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1234): Illuminate\\Foundation\\Console\\Kernel->handle()\n#35 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#36 {main}	2025-05-14 11:36:42
4	e8c8e726-3921-4dd0-af6a-c22797c25e0c	database	default	{"uuid":"e8c8e726-3921-4dd0-af6a-c22797c25e0c","displayName":"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":14:{s:5:\\"event\\";O:60:\\"Illuminate\\\\Notifications\\\\Events\\\\BroadcastNotificationCreated\\":3:{s:10:\\"notifiable\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";i:28;s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:44:\\"App\\\\Notifications\\\\NouvelleDemandeReservation\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:16;s:9:\\"relations\\";a:2:{i:0;s:9:\\"demandeur\\";i:1;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"f7ef5dd2-2144-4f51-8eb3-9c42fe4d92f9\\";}s:4:\\"data\\";a:10:{s:14:\\"reservation_id\\";i:16;s:5:\\"titre\\";s:32:\\"Nouvelle demande de réservation\\";s:7:\\"message\\";s:50:\\"Demande de  pour la salle 'Salle-A2' le 09\\/05\\/2025\\";s:3:\\"url\\";s:16:\\"\\/reservations\\/16\\";s:5:\\"salle\\";s:8:\\"Salle-A2\\";s:9:\\"demandeur\\";N;s:4:\\"date\\";s:10:\\"09\\/05\\/2025\\";s:11:\\"heure_debut\\";s:5:\\"2025-\\";s:9:\\"heure_fin\\";s:5:\\"2025-\\";s:5:\\"objet\\";s:40:\\"Réunion de la coopérative d'entreprise\\";}}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;s:7:\\"backoff\\";N;s:13:\\"maxExceptions\\";N;s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;s:11:\\"afterCommit\\";N;s:10:\\"middleware\\";a:0:{}s:7:\\"chained\\";a:0:{}s:15:\\"chainConnection\\";N;s:10:\\"chainQueue\\";N;s:19:\\"chainCatchCallbacks\\";N;}"}}	Error: The script tried to call a method on an incomplete object. Please ensure that the class definition "App\\Notifications\\NouvelleDemandeReservation" of the object you are trying to operate on was loaded _before_ unserialize() gets called or provide an autoloader to load the class definition in C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php:110\nStack trace:\n#0 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Events\\BroadcastNotificationCreated.php(110): method_exists()\n#1 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Broadcasting\\BroadcastEvent.php(77): Illuminate\\Notifications\\Events\\BroadcastNotificationCreated->broadcastAs()\n#2 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Broadcasting\\BroadcastEvent->handle()\n#3 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#4 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#5 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#6 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#7 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(125): Illuminate\\Container\\Container->call()\n#8 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():122}()\n#9 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#10 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Pipeline\\Pipeline->then()\n#11 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(125): Illuminate\\Bus\\Dispatcher->dispatchNow()\n#12 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(169): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():120}()\n#13 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(126): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():167}()\n#14 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Pipeline\\Pipeline->then()\n#15 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware()\n#16 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call()\n#17 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(441): Illuminate\\Queue\\Jobs\\Job->fire()\n#18 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(391): Illuminate\\Queue\\Worker->process()\n#19 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(177): Illuminate\\Queue\\Worker->runJob()\n#20 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon()\n#21 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker()\n#22 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#23 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#24 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure()\n#25 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod()\n#26 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call()\n#27 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call()\n#28 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute()\n#29 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run()\n#30 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run()\n#31 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand()\n#32 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun()\n#33 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(197): Symfony\\Component\\Console\\Application->run()\n#34 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1234): Illuminate\\Foundation\\Console\\Kernel->handle()\n#35 C:\\Users\\raymo\\Desktop\\dossier\\laravel\\gestsalle\\artisan(16): Illuminate\\Foundation\\Application->handleCommand()\n#36 {main}	2025-05-14 11:36:42
\.


--
-- TOC entry 5077 (class 0 OID 17689)
-- Dependencies: 235
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 17680)
-- Dependencies: 234
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
14	default	{"uuid":"b7e48c75-da62-4ec3-9f8a-93c2b1d19cc7","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:45;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"073aa7b4-2688-447d-b570-d966b70ac280\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747337726	1747337726
15	default	{"uuid":"800cb970-216e-4f2b-b2f6-bcb5e2609177","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:45;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"073aa7b4-2688-447d-b570-d966b70ac280\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747337726	1747337726
16	default	{"uuid":"f06357d0-8fa5-4f05-a49c-d59ac2edecdc","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:45;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"073aa7b4-2688-447d-b570-d966b70ac280\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747337726	1747337726
17	default	{"uuid":"446562cd-6c68-4c66-a6ec-7e544be88401","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:46;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5804427f-c87c-48b0-89b3-37dc3a2cef0c\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747337863	1747337863
18	default	{"uuid":"bfc369e5-967f-4661-a664-a3476a58a6a4","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:46;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5804427f-c87c-48b0-89b3-37dc3a2cef0c\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747337863	1747337863
19	default	{"uuid":"65b37390-6942-40e9-bf37-7b798a6ac1ec","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:46;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5804427f-c87c-48b0-89b3-37dc3a2cef0c\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747337863	1747337863
20	default	{"uuid":"7828132e-a9fc-4752-aa76-5f9b39bce53b","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:47;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6c13a343-b369-4808-981b-885f165fa804\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747339145	1747339145
21	default	{"uuid":"5c7be6d6-05e7-4d2b-8021-5e5c1c230f0d","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:47;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6c13a343-b369-4808-981b-885f165fa804\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747339145	1747339145
22	default	{"uuid":"09cdfb7f-1ffd-47f0-880b-e51d58e08367","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:47;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6c13a343-b369-4808-981b-885f165fa804\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747339145	1747339145
23	default	{"uuid":"7173609d-7c63-4159-b26b-fa5b478af157","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:48;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"45456122-1c63-4602-885a-b3c03e14364a\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747411147	1747411147
24	default	{"uuid":"c35e4209-1b92-47eb-92a1-68ae8f4775be","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:48;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"45456122-1c63-4602-885a-b3c03e14364a\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747411147	1747411147
25	default	{"uuid":"4baaa1ad-b012-4156-bf55-3b2e0bdfebb3","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:48;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"45456122-1c63-4602-885a-b3c03e14364a\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747411147	1747411147
26	default	{"uuid":"8de452f7-1b39-4245-b767-069ed32b4c05","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:58;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5d624475-5262-4b5b-a7b2-5715bd84d406\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747906608	1747906608
27	default	{"uuid":"53627c71-af37-490a-8d1c-8c5a6009b6d6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:58;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5d624475-5262-4b5b-a7b2-5715bd84d406\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747906608	1747906608
28	default	{"uuid":"00f2c27b-3784-41c6-ba3b-e9e3f05afdb7","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:58;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5d624475-5262-4b5b-a7b2-5715bd84d406\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747906608	1747906608
29	default	{"uuid":"525e06cb-9f08-4081-914c-d95b4ec0407c","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:59;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2836d3eb-78dd-4067-866e-7a8397968967\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747906974	1747906974
30	default	{"uuid":"a932f34d-286f-439a-ab16-cf7132de0924","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:59;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2836d3eb-78dd-4067-866e-7a8397968967\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747906974	1747906974
31	default	{"uuid":"09690a83-e854-4fac-af07-a23969ae59c1","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:59;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2836d3eb-78dd-4067-866e-7a8397968967\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747906974	1747906974
32	default	{"uuid":"efd51f09-e159-412e-86aa-bc6fa1aa538a","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:60;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"413958dd-7556-4923-8610-28309c008121\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747912970	1747912970
33	default	{"uuid":"f713bd44-2dae-4fdd-b777-8b2b87bfb53a","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:60;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"413958dd-7556-4923-8610-28309c008121\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747912970	1747912970
34	default	{"uuid":"9ea6d7cd-2bb4-4246-a7b2-de9774ae3134","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:60;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"413958dd-7556-4923-8610-28309c008121\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747912970	1747912970
35	default	{"uuid":"3a5eae4f-6119-4591-83c6-0fa94bfdcebc","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:61;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5bfb29a0-2ea4-41d7-aa88-aadc12ac2417\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747915273	1747915273
36	default	{"uuid":"395fca9a-2bd5-4895-b378-4fa9da237199","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:61;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5bfb29a0-2ea4-41d7-aa88-aadc12ac2417\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747915273	1747915273
37	default	{"uuid":"e23d7974-76a7-4775-bfc8-065cae73e104","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:61;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"5bfb29a0-2ea4-41d7-aa88-aadc12ac2417\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747915273	1747915273
38	default	{"uuid":"9eba2b68-7a73-4a90-b22c-5c6ca3f5c434","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:62;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"07cc3458-122b-46f1-839d-a7f743b36c52\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1747921247	1747921247
39	default	{"uuid":"c8c5e1f6-0734-4557-89dd-1b6cc1e24808","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:62;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"07cc3458-122b-46f1-839d-a7f743b36c52\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1747921247	1747921247
40	default	{"uuid":"2b6bd291-7796-4fcb-ab28-aef4140da5e6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:62;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"07cc3458-122b-46f1-839d-a7f743b36c52\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1747921247	1747921247
41	default	{"uuid":"11deda8e-04b3-4111-a32c-7241a7afd8ca","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:63;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ed7d98b9-63be-4df5-98c3-5dd00e373456\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748028071	1748028071
42	default	{"uuid":"9cd42c20-5b18-4316-8aad-216a9c6f57e7","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:63;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ed7d98b9-63be-4df5-98c3-5dd00e373456\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748028071	1748028071
43	default	{"uuid":"8c99a289-260a-46e1-a260-0cf1d798f7f4","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:63;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ed7d98b9-63be-4df5-98c3-5dd00e373456\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748028071	1748028071
44	default	{"uuid":"a4841650-8034-4cfa-87e6-0aec2bc286fc","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:64;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"e216b615-c854-4f2f-94e5-51bc20be854b\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748036270	1748036270
45	default	{"uuid":"bf313774-7a4b-4f09-999c-b08d3bd67298","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:64;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"e216b615-c854-4f2f-94e5-51bc20be854b\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748036270	1748036270
46	default	{"uuid":"82500a07-54d6-48b8-ab26-d8dadd6e2d41","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:64;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"e216b615-c854-4f2f-94e5-51bc20be854b\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748036270	1748036270
47	default	{"uuid":"d6b3146e-6fd5-45e2-9f3d-234f37ee0837","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:65;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"4e2b0726-7404-4e1d-8818-4aa9a82a74f3\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748036763	1748036763
48	default	{"uuid":"1f2ee373-2227-421b-b045-27737e886aae","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:65;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"4e2b0726-7404-4e1d-8818-4aa9a82a74f3\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748036763	1748036763
49	default	{"uuid":"2797037b-a37f-4cce-ba99-348f321584c1","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:65;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"4e2b0726-7404-4e1d-8818-4aa9a82a74f3\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748036763	1748036763
50	default	{"uuid":"2393f34f-433f-47fe-9ecb-ec5d84a9b1e7","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:66;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"66e9c163-adf2-47db-abb7-786a44d0297f\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748037038	1748037038
51	default	{"uuid":"efffd346-68ea-4219-88e3-647208943215","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:66;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"66e9c163-adf2-47db-abb7-786a44d0297f\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748037038	1748037038
52	default	{"uuid":"e3404b75-674d-46de-970e-9efe521088ca","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:66;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"66e9c163-adf2-47db-abb7-786a44d0297f\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748037038	1748037038
53	default	{"uuid":"f0a5dd3c-3d61-4bcc-9a6e-36e889650c36","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:67;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba45ad56-93da-4abb-a6e6-1093639fdbf3\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748037249	1748037249
54	default	{"uuid":"7fa06055-52f9-4178-b0b1-4cbcd2c3e65c","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:67;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba45ad56-93da-4abb-a6e6-1093639fdbf3\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748037249	1748037249
55	default	{"uuid":"5d96f05e-aabc-4025-9351-a4b4017d1d4e","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:67;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba45ad56-93da-4abb-a6e6-1093639fdbf3\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748037249	1748037249
56	default	{"uuid":"777b361b-118b-484d-a7e2-3546c764ec80","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:68;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbe39ae2-ff69-48a7-bf65-4853b9ea771a\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748079899	1748079899
57	default	{"uuid":"206eb734-ab6d-4dbc-9404-5bb86d56d7ca","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:68;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbe39ae2-ff69-48a7-bf65-4853b9ea771a\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748079899	1748079899
58	default	{"uuid":"7e4a18ee-9a55-4647-bf08-4f254505c269","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:68;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbe39ae2-ff69-48a7-bf65-4853b9ea771a\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748079899	1748079899
59	default	{"uuid":"bd5b4c91-00a6-4682-8e91-7e87f9c52312","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:69;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"8f865a29-af8f-4136-a5ed-bd4488824172\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748080509	1748080509
60	default	{"uuid":"d964a321-8973-43c7-b2db-0c38cb4582a9","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:69;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"8f865a29-af8f-4136-a5ed-bd4488824172\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748080509	1748080509
61	default	{"uuid":"40ecf1ef-7d2d-4146-8275-230fd85d1023","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:69;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"8f865a29-af8f-4136-a5ed-bd4488824172\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748080509	1748080509
62	default	{"uuid":"9f1574ff-d0ae-4572-a6e8-5ad734d5d0a0","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:70;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"d8353563-bddc-4966-b41d-04dbf597c23a\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748089555	1748089555
63	default	{"uuid":"96c3b2d8-4c71-4d5e-899f-123989a28033","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:70;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"d8353563-bddc-4966-b41d-04dbf597c23a\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748089555	1748089555
64	default	{"uuid":"0d309f72-9d47-4c3a-b830-318241ef4d70","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:70;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"d8353563-bddc-4966-b41d-04dbf597c23a\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748089555	1748089555
65	default	{"uuid":"7be6834d-da1c-43d2-9812-43aa2e8fdf88","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:71;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbc5b3f9-7e9c-46da-bf41-101a8fe28d68\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748099150	1748099150
66	default	{"uuid":"f2c8d59c-f480-4516-828e-82fa2a6da4f6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:71;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbc5b3f9-7e9c-46da-bf41-101a8fe28d68\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748099150	1748099150
67	default	{"uuid":"cad3524b-40c9-4e7e-a75e-0955ef4ac22e","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:71;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"dbc5b3f9-7e9c-46da-bf41-101a8fe28d68\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748099150	1748099150
68	default	{"uuid":"92233522-77eb-43f6-8801-aaa18268d360","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:72;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"98b6f950-db59-416b-83d1-2c8cf21f9e45\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748267219	1748267219
69	default	{"uuid":"c1ddb898-cda4-4b6c-8506-de78719a16db","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:72;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"98b6f950-db59-416b-83d1-2c8cf21f9e45\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748267219	1748267219
70	default	{"uuid":"83b8b4b4-c919-4ef7-967f-f2285db6a7e2","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:72;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"98b6f950-db59-416b-83d1-2c8cf21f9e45\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748267219	1748267219
71	default	{"uuid":"09333d89-0f92-47f7-a967-551cf89de819","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:73;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"74bcc033-e527-4bed-b9c0-0c8410cf2cde\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748267857	1748267857
72	default	{"uuid":"f35bdb7e-e29c-4054-b752-ccddc866e88a","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:73;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"74bcc033-e527-4bed-b9c0-0c8410cf2cde\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748267857	1748267857
73	default	{"uuid":"a0d37a13-d6ed-45cc-829b-b007dd3276b1","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:73;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"74bcc033-e527-4bed-b9c0-0c8410cf2cde\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748267857	1748267857
74	default	{"uuid":"0cb08f5c-5590-426a-a83f-9ced4b1b94f9","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:75;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"9909418d-dc6d-4808-b9e6-d2e5d3d35661\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748340320	1748340320
75	default	{"uuid":"07f2c15b-3f2c-4d48-9003-55d2890a62d6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:75;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"9909418d-dc6d-4808-b9e6-d2e5d3d35661\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748340320	1748340320
76	default	{"uuid":"5c388d20-cb02-44fd-a4ee-440b21e6e0ef","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:75;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"9909418d-dc6d-4808-b9e6-d2e5d3d35661\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748340320	1748340320
77	default	{"uuid":"52464a57-98f5-482b-8b20-7e20d2277396","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:76;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"0acb1803-de73-47a3-b014-e39f6efec65c\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748435364	1748435364
78	default	{"uuid":"9c4d77f0-3d77-4758-b3bb-975ff8bbd7d2","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:76;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"0acb1803-de73-47a3-b014-e39f6efec65c\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748435364	1748435364
79	default	{"uuid":"f562ad3a-6a47-4130-8e5e-fc9435011b7f","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:76;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"0acb1803-de73-47a3-b014-e39f6efec65c\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748435364	1748435364
80	default	{"uuid":"497be834-43a4-41ec-b1c6-22c08b8c1208","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:77;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"7598b944-79c5-425d-b084-73f9464522e2\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748437883	1748437883
81	default	{"uuid":"c07c61a4-c1e2-4bcf-aa81-95e0ed12fe32","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:77;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"7598b944-79c5-425d-b084-73f9464522e2\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748437883	1748437883
82	default	{"uuid":"a32d5521-8ed6-4b56-9107-2010dd95880e","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:77;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"7598b944-79c5-425d-b084-73f9464522e2\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748437883	1748437883
83	default	{"uuid":"4b8c6b0f-f99c-49fa-bec1-24cda3921707","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:78;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"02610dc0-32d0-4af5-a153-54bb234c6b38\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748452070	1748452070
84	default	{"uuid":"d3278e00-b6d6-4276-9d8f-bb43a9895448","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:78;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"02610dc0-32d0-4af5-a153-54bb234c6b38\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748452070	1748452070
85	default	{"uuid":"1ac462df-c556-483e-a900-53d32337e9f1","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:78;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"02610dc0-32d0-4af5-a153-54bb234c6b38\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748452070	1748452070
86	default	{"uuid":"977af5c8-4d8e-468c-8279-4bcef35ff221","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:79;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6f84affd-7e96-4879-a519-0d818a6d7865\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748521216	1748521216
87	default	{"uuid":"6a4470b0-3158-4bcc-b2a1-3e69a2ff6b66","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:79;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6f84affd-7e96-4879-a519-0d818a6d7865\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748521216	1748521216
88	default	{"uuid":"d0615668-f350-43da-92ca-2b8e1d46c72c","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:79;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"6f84affd-7e96-4879-a519-0d818a6d7865\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748521216	1748521216
89	default	{"uuid":"4e53292b-0804-45d2-907d-26e4f47bb7aa","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:81;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2e7c3821-2196-4335-9a26-166523277108\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748598104	1748598104
90	default	{"uuid":"5f5bb86b-36c4-438e-b425-edd4751cc7f5","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:81;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2e7c3821-2196-4335-9a26-166523277108\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748598104	1748598104
91	default	{"uuid":"0c962520-211e-4e2f-b7c4-343ee23b5203","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:81;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"2e7c3821-2196-4335-9a26-166523277108\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748598104	1748598104
92	default	{"uuid":"92376f21-55c5-4493-a608-3a44e2b419a3","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:87;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"216db146-16e7-4b8e-bebb-f5bdce3865d8\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748690438	1748690438
93	default	{"uuid":"36b37a8d-1672-4e0a-b809-8c6420e57ccd","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:87;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"216db146-16e7-4b8e-bebb-f5bdce3865d8\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748690438	1748690438
94	default	{"uuid":"a332f6fc-5258-4de0-91b2-3a06811ea6ce","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:87;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"216db146-16e7-4b8e-bebb-f5bdce3865d8\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748690438	1748690438
95	default	{"uuid":"233793e7-8976-41bc-98ba-5639964c7ae3","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:88;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b0ecb388-cce2-413f-aca2-50f194ddac3c\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748690482	1748690482
96	default	{"uuid":"1feb461d-0369-45d4-bca2-4abc0cb9e6fe","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:88;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b0ecb388-cce2-413f-aca2-50f194ddac3c\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748690482	1748690482
97	default	{"uuid":"218c3118-4fec-4080-9d08-86a026e2e8ce","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:88;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b0ecb388-cce2-413f-aca2-50f194ddac3c\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748690482	1748690482
98	default	{"uuid":"6f66d19c-7e19-4ffd-9842-3a83bd650ad6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:92;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba68c091-2646-4954-ae77-5740f1260e1b\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748941202	1748941202
99	default	{"uuid":"8d374477-bf59-4cc0-ace8-0cca4634b655","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:92;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba68c091-2646-4954-ae77-5740f1260e1b\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748941202	1748941202
100	default	{"uuid":"b6e9cb24-c755-4e69-aa05-47822a6dc42f","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:92;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"ba68c091-2646-4954-ae77-5740f1260e1b\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748941202	1748941202
101	default	{"uuid":"67307f10-7577-40ea-8a69-cf01507d9262","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:93;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"05dbdcb2-3639-40a6-bc32-eeb08e44e9d8\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748941589	1748941589
102	default	{"uuid":"75175ff4-9e05-45d2-b0da-5ad96f28d1f6","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:93;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"05dbdcb2-3639-40a6-bc32-eeb08e44e9d8\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748941589	1748941589
103	default	{"uuid":"55fae8a6-9562-45ef-9c5e-f0cf3880491f","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:93;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"05dbdcb2-3639-40a6-bc32-eeb08e44e9d8\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748941589	1748941589
104	default	{"uuid":"0536d8c2-35a9-4500-8c1e-b1c89525ff36","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:94;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b819c9ee-0c6a-480b-90e0-c9bfd63174ea\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748946476	1748946476
105	default	{"uuid":"4cf5e47a-eef0-4220-9fc5-dbbd5df4525c","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:94;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b819c9ee-0c6a-480b-90e0-c9bfd63174ea\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748946476	1748946476
106	default	{"uuid":"c2c84d84-6839-4d58-8693-3394278688af","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:94;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"b819c9ee-0c6a-480b-90e0-c9bfd63174ea\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748946476	1748946476
107	default	{"uuid":"f5fcfcac-52a7-454c-a817-dd9f8deec7ff","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:95;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"1864cf2e-36bb-4bc2-9ac5-07e88c745b24\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1748951953	1748951953
108	default	{"uuid":"d9ed5c45-abff-442d-933a-330cc525deba","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:95;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"1864cf2e-36bb-4bc2-9ac5-07e88c745b24\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1748951953	1748951953
109	default	{"uuid":"642e3580-f803-4892-b5f2-d8d937fc5785","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:95;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"1864cf2e-36bb-4bc2-9ac5-07e88c745b24\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1748951953	1748951953
110	default	{"uuid":"acc8b97f-1054-483b-891c-2cc7aa221e27","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:96;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"31bc2312-fbe0-47ee-ab78-11eb91cb77cb\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1749218087	1749218087
111	default	{"uuid":"3ad4cbed-602c-4a38-8879-d34ca2950ed3","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:96;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"31bc2312-fbe0-47ee-ab78-11eb91cb77cb\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1749218087	1749218087
112	default	{"uuid":"7333d7b1-c9b2-49ab-bd9e-1285f757b901","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:28;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:96;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"31bc2312-fbe0-47ee-ab78-11eb91cb77cb\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1749218087	1749218087
113	default	{"uuid":"3e72d16d-6d0b-475b-84a1-350397d6c388","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:97;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"72a90403-8a27-4da2-8106-93fd5a85a609\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1749301961	1749301961
114	default	{"uuid":"8b897db2-5b47-4a81-9de8-e8384904b666","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:97;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"72a90403-8a27-4da2-8106-93fd5a85a609\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1749301961	1749301961
115	default	{"uuid":"b8f7c160-15e9-4c28-88f4-76bc0a894d76","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:97;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"72a90403-8a27-4da2-8106-93fd5a85a609\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1749301961	1749301961
116	default	{"uuid":"8b1405f9-ebd6-4dae-bddd-5cf4a8b55664","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:98;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"28753bcf-42bf-4496-8724-1898aedabf04\\";}s:8:\\"channels\\";a:1:{i:0;s:4:\\"mail\\";}}"}}	0	\N	1749302316	1749302316
117	default	{"uuid":"c0faa8d2-9133-48e4-b327-9247b09a74d9","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:98;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"28753bcf-42bf-4496-8724-1898aedabf04\\";}s:8:\\"channels\\";a:1:{i:0;s:8:\\"database\\";}}"}}	0	\N	1749302316	1749302316
118	default	{"uuid":"533aff00-aa07-416e-88ea-14393db15b0a","displayName":"App\\\\Notifications\\\\NewRequestBooking","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"maxExceptions":null,"failOnTimeout":false,"backoff":null,"timeout":null,"retryUntil":null,"data":{"commandName":"Illuminate\\\\Notifications\\\\SendQueuedNotifications","command":"O:48:\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\":3:{s:11:\\"notifiables\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:15:\\"App\\\\Models\\\\User\\";s:2:\\"id\\";a:1:{i:0;i:35;}s:9:\\"relations\\";a:0:{}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:12:\\"notification\\";O:35:\\"App\\\\Notifications\\\\NewRequestBooking\\":2:{s:14:\\"\\u0000*\\u0000reservation\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":5:{s:5:\\"class\\";s:23:\\"App\\\\Models\\\\Reservations\\";s:2:\\"id\\";i:98;s:9:\\"relations\\";a:1:{i:0;s:5:\\"salle\\";}s:10:\\"connection\\";s:5:\\"pgsql\\";s:15:\\"collectionClass\\";N;}s:2:\\"id\\";s:36:\\"28753bcf-42bf-4496-8724-1898aedabf04\\";}s:8:\\"channels\\";a:1:{i:0;s:9:\\"broadcast\\";}}"}}	0	\N	1749302316	1749302316
\.


--
-- TOC entry 5060 (class 0 OID 17565)
-- Dependencies: 218
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2025_04_28_160144_salle	1
2	2025_04_28_160113_create_equipements_table	2
3	2025_04_28_160058_departement	3
4	2025_04_28_160015_create_permissions_table	4
5	2025_04_28_160001_create_roses_table	5
6	0001_01_01_000000_create_users_table	6
7	0001_01_01_000001_create_cache_table	6
8	0001_01_01_000002_create_jobs_table	6
9	2025_04_28_160126_reservation	6
10	2025_04_29_155935_equipement	7
11	2025_04_29_161351_create_equipements_table	8
13	2025_04_29_171026_create_reservations_table	9
14	2025_05_02_142732_user_permission	10
15	2025_05_01_010712_create_reset_code_passwords_table	11
16	2025_05_02_171917_remove_id_permission_from_users_table	11
17	2025_05_03_194201_create_notifications_table	12
18	2025_05_08_112245_create_componies_table	13
\.


--
-- TOC entry 5090 (class 0 OID 34252)
-- Dependencies: 248
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, type, notifiable_type, notifiable_id, data, read_at, created_at, updated_at) FROM stdin;
724d2bd2-9431-44a2-ac6d-436b6c81ec88	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	30	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour hugo.morel@exampler.com","email":"hugo.morel@exampler.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-04 19:17:52	2025-05-04 19:17:52
3a5138f4-5879-4b4c-aec6-370ffeedaa72	App\\Notifications\\NouvelleDemandeReservation	App\\Models\\User	29	{"reservation_id":12,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle D04' le 18\\/05\\/2025","url":"\\/reservations\\/12"}	\N	2025-05-04 20:47:48	2025-05-04 20:47:48
d49e1ef6-0867-4f86-b554-86d862046f27	App\\Notifications\\NouvelleDemandeReservation	App\\Models\\User	28	{"reservation_id":12,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle D04' le 18\\/05\\/2025","url":"\\/reservations\\/12"}	\N	2025-05-04 20:47:50	2025-05-04 20:47:50
5f0b4422-3923-4133-ae0f-0a5cc869a110	App\\Notifications\\NouvelleDemandeReservation	App\\Models\\User	29	{"reservation_id":16,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 09\\/05\\/2025","url":"\\/reservations\\/16"}	\N	2025-05-06 16:52:46	2025-05-06 16:52:46
f7ef5dd2-2144-4f51-8eb3-9c42fe4d92f9	App\\Notifications\\NouvelleDemandeReservation	App\\Models\\User	28	{"reservation_id":16,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 09\\/05\\/2025","url":"\\/reservations\\/16"}	\N	2025-05-06 16:52:49	2025-05-06 16:52:49
18f9d798-5b35-4c43-9eeb-859f2899cf6f	App\\Notifications\\ReservationValidee	App\\Models\\User	8	{"reservation_id":1,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle C03' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/1"}	2025-05-06 22:37:57	2025-05-04 20:44:42	2025-05-06 22:37:57
4a41dae4-eaac-49cc-9d57-51781b9adbc3	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	28	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":"\\u2014","new":"1"}}}	\N	2025-05-10 08:01:21	2025-05-10 08:01:21
23bb4a9b-2b1c-4cb8-b07d-c6bc195dbc6a	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	31	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":"\\u2014","new":"1"}}}	\N	2025-05-10 08:06:22	2025-05-10 08:06:22
226873c8-fbea-4e2a-9578-beeddc84bb3c	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":15,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/15"}	\N	2025-05-10 12:15:37	2025-05-10 12:15:37
2636f127-d9c6-4858-afca-bfe1e24595fe	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	32	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour gilles@cadyst.com","email":"gilles@cadyst.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-10 15:00:56	2025-05-10 15:00:56
cfdb6cb0-46f3-452b-80a7-f514ecbe2a48	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	33	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour hugo.florian@cadyst.com","email":"hugo.florian@cadyst.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-10 15:23:38	2025-05-10 15:23:38
60b1429c-83f3-4fa4-af87-e373ab7bb84d	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":37,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 15\\/05\\/2025","url":"\\/reservations\\/37"}	\N	2025-05-14 10:21:08	2025-05-14 10:21:08
3428dd19-301b-4103-8311-1604b1820a61	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":38,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 24\\/05\\/2025","url":"\\/reservations\\/38"}	\N	2025-05-14 10:27:08	2025-05-14 10:27:08
60794b70-7d72-40c2-8fe6-84c23ad1baa5	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":39,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 24\\/05\\/2025","url":"\\/reservations\\/39"}	\N	2025-05-14 10:27:14	2025-05-14 10:27:14
eb038914-9cf9-424b-bd42-6358b3069ed6	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":40,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 15\\/05\\/2025","url":"\\/reservations\\/40"}	\N	2025-05-14 11:23:18	2025-05-14 11:23:18
13351118-f883-49e0-b18d-01ce8d619d9d	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":41,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 16\\/05\\/2025","url":"\\/reservations\\/41"}	\N	2025-05-14 11:29:06	2025-05-14 11:29:06
9c830cd7-36c4-40ba-a2a1-d79fa4cf0e9a	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":42,"titre":"Nouvelle demande de r\\u00e9servation","message":"Demande de  pour la salle 'Salle-A2' le 16\\/05\\/2025","url":"\\/reservations\\/42"}	\N	2025-05-14 11:44:20	2025-05-14 11:44:20
83f24ace-3d54-4a7b-b08c-f42d0e899c52	App\\Notifications\\BookingValidated	App\\Models\\User	8	{"reservation_id":5,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle B02' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/5"}	2025-05-14 15:59:25	2025-05-07 19:21:16	2025-05-14 15:59:25
7a5ec6fa-fa50-4446-aa5c-23fd0399d167	App\\Notifications\\BookingValidated	App\\Models\\User	8	{"reservation_id":18,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle E05' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/18"}	2025-05-14 15:59:25	2025-05-07 19:20:42	2025-05-14 15:59:25
0bea276a-fdbc-42d2-abf1-36b2214c3246	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	34	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour catchtry55@gmail.com","email":"catchtry55@gmail.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-14 21:23:33	2025-05-14 21:23:33
e41dc818-83a4-4d66-9c3e-7b843bd7d3b2	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":36,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/36"}	\N	2025-05-15 09:14:27	2025-05-15 09:14:27
54792f05-5ed6-4cac-8d92-35d8f869c20a	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":37,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/37"}	\N	2025-05-15 09:14:33	2025-05-15 09:14:33
70b899ff-d70a-447a-baf8-a771886255ab	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":35,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/35"}	\N	2025-05-15 09:14:39	2025-05-15 09:14:39
e113cb6c-e0f3-438b-ae13-9d8e6baae6a5	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":40,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/40"}	\N	2025-05-15 09:14:44	2025-05-15 09:14:44
6aa12929-28d7-4a10-bb71-897fedcc7afd	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":42,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/42"}	\N	2025-05-15 09:14:50	2025-05-15 09:14:50
03a83dfd-0184-4381-bf8b-3e914a8e6c50	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":38,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/38"}	\N	2025-05-15 09:19:31	2025-05-15 09:19:31
1a1e41b7-cece-4d70-bc8d-3d2a975fa171	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":41,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/41"}	\N	2025-05-15 09:19:36	2025-05-15 09:19:36
f63cf649-03b9-46ba-ae7e-1e9693f6db43	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":39,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-05-15 09:19:48	2025-05-15 09:19:48
26b23d64-de62-48e6-a071-205e13ec6a98	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":46,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/46"}	\N	2025-05-15 19:41:04	2025-05-15 19:41:04
a04d7950-5594-42af-840c-5a7d0647c2ba	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":45,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE- P001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/45"}	\N	2025-05-15 19:41:18	2025-05-15 19:41:18
07f43809-7068-4322-8532-3a4399c0a87f	App\\Notifications\\NewRequestBooking	App\\Models\\User	28	{"reservation_id":57,"salle":"SALLE-D001","heure_debut":null,"date_fin":"2025-05-29T16:29:00.000000Z","type":"refus_avec_alternatives","message":"Votre r\\u00e9servation de salle a \\u00e9t\\u00e9 refus\\u00e9e. Des alternatives sont disponibles."}	\N	2025-05-21 11:32:26	2025-05-21 11:32:26
198066eb-2ef2-481d-8551-222ea5573e58	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":34,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle-A2' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	2025-05-21 15:26:02	2025-05-15 09:19:42	2025-05-21 15:26:02
3a70f175-e973-47ad-9307-72350718c94c	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":58,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE- P001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/58"}	\N	2025-05-22 09:37:30	2025-05-22 09:37:30
9104a1d8-9818-4de3-acd5-c5d59871eb71	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":48,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-D001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/48"}	\N	2025-05-22 11:30:05	2025-05-22 11:30:05
f935336c-6533-455e-aed9-cd23fee39981	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":60,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/60"}	\N	2025-05-22 11:30:11	2025-05-22 11:30:11
9fdff589-2bc9-4ad9-9c1f-b23bac23e033	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":59,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/59"}	\N	2025-05-22 11:47:41	2025-05-22 11:47:41
9ee3e021-2657-4057-b2b4-79a177d344bb	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":62,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-D001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/62"}	\N	2025-05-22 13:41:04	2025-05-22 13:41:04
7864b065-19e3-4d64-81d4-3fb46a156505	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":61,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-D001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/61"}	\N	2025-05-23 04:50:30	2025-05-23 04:50:30
df61ced6-465f-4946-ac14-fe3bbd8f52fa	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":63,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE- P001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/63"}	\N	2025-05-24 14:32:21	2025-05-24 14:32:21
9b82b18c-be2a-4469-98c5-e860b6ac09fb	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":67,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-A2' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/67"}	\N	2025-05-24 14:32:50	2025-05-24 14:32:50
eefb727a-adbe-449c-868e-4d4b27dce4cc	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":66,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle P02' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/66"}	\N	2025-05-24 16:14:36	2025-05-24 16:14:36
6ca15bf5-7b60-41fc-8d6a-d72eb8cab18d	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":71,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-D001' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/71"}	\N	2025-05-24 16:15:14	2025-05-24 16:15:14
3bf2c74f-81db-4f32-9a75-ffb01fa2ee89	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":68,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle -D112' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/68"}	\N	2025-05-24 16:15:36	2025-05-24 16:15:36
c9d2ca70-9391-4b13-a6d6-1ab7a86a9a25	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	35	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour moundyaugustine9@gmail.com","email":"moundyaugustine9@gmail.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-26 13:30:45	2025-05-26 13:30:45
5f091064-78d2-45a9-ac8d-370a35e4b619	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	36	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour kfdguy@gmail.com","email":"kfdguy@gmail.com","type":"Cr\\u00e9ation de compte"}	\N	2025-05-26 13:36:08	2025-05-26 13:36:08
7166b562-9f8b-4721-b86b-febd36186252	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	35	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":4,"new":"3"}}}	\N	2025-05-26 13:39:24	2025-05-26 13:39:24
802dc929-14ef-48b2-a3ff-35b0f1db363a	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	36	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":4,"new":"3"}}}	\N	2025-05-26 13:39:45	2025-05-26 13:39:45
fbd4da1a-dfd2-4780-aaaf-dc0575a99c8c	App\\Notifications\\BookingValidated	App\\Models\\User	35	{"reservation_id":72,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'PINK' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/72"}	\N	2025-05-26 14:00:59	2025-05-26 14:00:59
5b5a73ce-e936-4c35-807f-ff8507f60fdd	App\\Notifications\\ReservationDeclined	App\\Models\\User	36	{"reservation_id":73,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'jjerjk' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-05-26 14:01:11	2025-05-26 14:01:11
c58e2afa-b5a1-45c4-95dd-18cd14413a1b	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	36	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"id_role":{"old":6,"new":"16"}}}	\N	2025-05-30 07:06:41	2025-05-30 07:06:41
3bc40f8a-2449-4225-aaf3-9a06ed21bd62	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	35	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":3,"new":"\\u2014"}}}	\N	2025-05-30 07:14:34	2025-05-30 07:14:34
bfc2f5f4-d2c4-468a-b9f9-bd18e625804c	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	35	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":"\\u2014","new":"3"}}}	\N	2025-05-30 07:15:43	2025-05-30 07:15:43
74d9ad5e-a7c8-4739-8f3b-078c27c3d43a	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	36	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":3,"new":"\\u2014"}}}	\N	2025-05-30 07:15:51	2025-05-30 07:15:51
09b7fc52-4fbd-44c4-9b0d-68eddfa2a127	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	36	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":"\\u2014","new":"3"}}}	\N	2025-05-30 07:19:52	2025-05-30 07:19:52
524afcbd-bc1e-4ee5-8685-94ff53cee8ac	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	35	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":3,"new":"\\u2014"}}}	\N	2025-05-30 08:47:31	2025-05-30 08:47:31
2d846a40-4556-4e82-868b-b0f7bc8d157b	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	35	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":"\\u2014","new":"3"}}}	\N	2025-05-30 08:47:44	2025-05-30 08:47:44
ec139494-71a8-4e1e-9ced-36767fde7fe9	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":76,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE- P001' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-03 10:26:41	2025-06-03 10:26:41
6251390b-cb66-46f6-85e6-8ff8d93a19fc	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":77,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-D001' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-03 10:26:47	2025-06-03 10:26:47
a70522ef-24da-47fa-a323-9773a96bcaf7	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":78,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE-A2' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-03 10:26:51	2025-06-03 10:26:51
6c869a61-42f4-422d-b80d-76390208e1cf	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":93,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle P02' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-03 10:27:17	2025-06-03 10:27:17
549b5dab-fb35-47f6-968e-b2da31042f0f	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":92,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'SALLE- P001' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-03 10:27:21	2025-06-03 10:27:21
6ce7335a-d809-4ed4-b1d5-2d40f104d5a5	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":94,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle P02' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/94"}	\N	2025-06-03 10:28:20	2025-06-03 10:28:20
5852808a-7915-4e65-8bbf-dadac52e6fdf	App\\Notifications\\BookingValidated	App\\Models\\User	28	{"reservation_id":95,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle -D112' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/95"}	\N	2025-06-03 13:02:38	2025-06-03 13:02:38
eaa0528f-8fe0-4c8e-a42b-9aa9882f6370	App\\Notifications\\ReservationDeclined	App\\Models\\User	28	{"reservation_id":96,"titre":"R\\u00e9servation refus\\u00e9e","message":"Votre r\\u00e9servation de la salle 'Salle P02' a \\u00e9t\\u00e9 refus\\u00e9e","url":"\\/reservations\\/create"}	\N	2025-06-06 16:34:43	2025-06-06 16:34:43
583ca34f-d82c-4387-9445-4072748e9760	App\\Notifications\\BookingValidated	App\\Models\\User	35	{"reservation_id":98,"titre":"R\\u00e9servation valid\\u00e9e","message":"Votre r\\u00e9servation de la salle 'PINK' a \\u00e9t\\u00e9 valid\\u00e9e","url":"\\/reservations\\/98"}	\N	2025-06-07 13:19:04	2025-06-07 13:19:04
dd8bc893-0b09-4116-babe-929d655f7cae	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	38	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour RER75@gmail.com","email":"RER75@gmail.com","type":"Cr\\u00e9ation de compte"}	\N	2025-06-07 13:39:24	2025-06-07 13:39:24
cb9be5c9-a0f8-4d3b-9a31-29373c35868a	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	40	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour hugomorel@gmail.com","email":"hugomorel@gmail.com","type":"Cr\\u00e9ation de compte"}	\N	2025-06-17 10:46:40	2025-06-17 10:46:40
2b8039fc-04e5-490d-a1d5-65f14519afc7	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	41	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour test75@cadyst.com","email":"test75@cadyst.com","type":"Cr\\u00e9ation de compte"}	\N	2025-06-23 08:24:29	2025-06-23 08:24:29
b614461b-1684-43ac-a99e-a70fab58f4ac	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	42	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour user1@cadyst.com","email":"user1@cadyst.com","type":"Cr\\u00e9ation de compte"}	\N	2025-06-23 08:28:22	2025-06-23 08:28:22
29acd40c-3883-44d9-8ef4-92445a0722f8	App\\Notifications\\SendEmailUpdateToAdmin	App\\Models\\User	41	{"title":"Compte mis \\u00e0 jour","message":"Votre compte a \\u00e9t\\u00e9 modifi\\u00e9.","changes":{"company_id":{"old":3,"new":"4"}}}	\N	2025-06-23 08:29:01	2025-06-23 08:29:01
ea57b641-9868-4de9-bd51-1137eef282f3	App\\Notifications\\SendEmailToAdminRegister	App\\Models\\User	43	{"message":"Le compte a \\u00e9t\\u00e9 cr\\u00e9\\u00e9 pour demandeur1@cadyst.com","email":"demandeur1@cadyst.com","type":"Cr\\u00e9ation de compte"}	\N	2025-06-23 08:31:03	2025-06-23 08:31:03
\.


--
-- TOC entry 5071 (class 0 OID 17649)
-- Dependencies: 229
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5066 (class 0 OID 17610)
-- Dependencies: 224
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, nom, created_at, updated_at) FROM stdin;
2	Modifier des réservations	\N	\N
3	Supprimer des réservations	\N	\N
4	Voir le planning	\N	\N
5	Gérer les utilisateurs	\N	\N
6	Attribuer des rôles	\N	\N
7	Envoyer des notifications	\N	\N
8	Accéder aux paramètres	\N	\N
9	Exporter des données	\N	\N
10	Gérer les salles de réunion	\N	2025-04-30 11:05:11
\.


--
-- TOC entry 5083 (class 0 OID 17813)
-- Dependencies: 241
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, salle_id, id_demandeur, id_createur, objet_reunion, description, date_debut, date_fin, statut, "nombreParticipants", rappel_active, created_at, updated_at) FROM stdin;
7	2	\N	\N	jklgkjfvkefvk	jj	2025-05-10 00:00:00	2025-05-10 00:00:00	en_attente	15	t	2025-05-02 17:55:13	2025-05-02 17:55:13
8	2	\N	\N	jklgkjfvkefvk	jj	2025-05-10 00:00:00	2025-05-10 00:00:00	en_attente	15	t	2025-05-02 18:18:14	2025-05-02 18:18:14
47	16	\N	\N	sv	f	2025-05-15 00:00:00	2025-05-16 00:00:00	en_attente	4	t	2025-05-15 19:59:05	2025-05-15 19:59:05
13	2	\N	\N	test	lorem 10	2025-05-05 00:00:00	2025-05-06 00:00:00	en_attente	14	t	2025-05-05 13:30:26	2025-05-05 13:30:26
79	6	\N	\N	fffff	fffff	2025-05-29 13:19:00	2025-05-29 13:19:00	en_attente	4	f	2025-05-29 12:20:04	2025-05-29 12:20:04
32	6	\N	\N	fs	vf	2025-05-18 00:00:00	2025-05-31 00:00:00	valide	214	f	2025-05-10 15:56:52	2025-05-15 19:41:28
25	6	\N	\N	TEST	RAS	2025-05-17 00:00:00	2025-06-08 00:00:00	valide	30	f	2025-05-10 15:25:44	2025-05-15 09:14:07
72	20	35	35	Formation	\N	2025-05-28 18:44:00	2025-05-28 19:44:00	valide	4	t	2025-05-26 13:46:58	2025-05-26 14:00:59
18	5	\N	\N	c	fff	2025-05-07 00:00:00	2025-05-07 00:00:00	valide	1	t	2025-05-06 23:07:02	2025-05-07 19:20:16
17	1	\N	\N	gtgt	f	2025-05-08 00:00:00	2025-05-23 00:00:00	en_attente	20	f	2025-05-06 22:46:24	2025-05-06 22:46:24
5	2	\N	\N	jklgkjfvkefvk	jj	2025-05-10 00:00:00	2025-05-10 00:00:00	valide	15	t	2025-05-02 17:39:36	2025-05-07 19:21:12
19	2	\N	\N	jj	\N	2025-05-17 00:00:00	2025-05-17 00:00:00	en_attente	10	t	2025-05-07 10:32:24	2025-05-07 10:32:24
20	2	\N	\N	jj	\N	2025-05-17 00:00:00	2025-05-17 00:00:00	en_attente	10	t	2025-05-07 10:36:16	2025-05-07 10:36:16
30	14	\N	\N	RGR	RGRGRG	2025-05-10 00:00:00	2025-05-25 00:00:00	en_attente	41	f	2025-05-10 15:48:29	2025-05-10 15:48:29
53	14	\N	\N	ffffffffffffffffffffffffffffffffffffffffffffffnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn	aaaaaaaaaaaaaaaaaaaaaaaaasssssvvvvvvvvvvvvvvvvvvvvvjnnnn	2025-05-19 00:00:00	2025-05-19 00:00:00	en_attente	8	t	2025-05-18 14:56:43	2025-05-18 14:57:35
54	14	\N	\N	gjgjj	ndff	2025-05-19 00:00:00	2025-05-19 00:00:00	en_attente	5	t	2025-05-18 17:08:20	2025-05-18 17:08:20
55	14	\N	\N	gr	rgr	2025-05-19 00:00:00	2025-05-19 00:00:00	en_attente	2	t	2025-05-18 17:11:24	2025-05-18 17:11:24
33	14	\N	\N	Réunion de la coopérative d'entreprise	Besoin du personnel	2025-05-15 00:00:00	2025-05-17 00:00:00	en_attente	20	t	2025-05-10 18:04:59	2025-05-10 18:04:59
43	14	\N	\N	s	ss	2025-05-14 00:00:00	2025-05-15 00:00:00	en_attente	144	f	2025-05-14 13:38:17	2025-05-14 13:38:17
51	14	\N	\N	fvf	rrff	2025-05-19 00:00:00	2025-05-20 00:00:00	en_attente	1	t	2025-05-18 14:28:30	2025-05-18 14:28:30
84	14	\N	\N	Réunion de la coopérative d'entreprise	jkl	2025-05-31 15:53:00	2025-05-31 19:39:00	en_attente	7	f	2025-05-30 14:53:39	2025-05-30 14:53:39
85	14	\N	\N	Réunion de la coopérative d'entreprise	hhhh	2025-06-02 18:46:00	2025-06-04 18:46:00	en_attente	4	f	2025-05-30 17:47:00	2025-05-30 17:47:00
89	14	\N	\N	Réunion de la coopérative d'entreprise	éertghjk	2025-06-12 09:06:00	2025-06-13 09:07:00	en_attente	5	f	2025-06-03 08:07:19	2025-06-03 08:07:36
21	2	\N	\N	test au choix	rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr	2025-05-17 00:00:00	2025-05-24 00:00:00	annulee	5	f	2025-05-07 10:38:16	2025-05-07 15:45:11
98	20	35	35	HRKKRKERJJE	JJJEJR	2025-06-10 14:18:00	2025-06-13 14:18:00	valide	7	t	2025-06-07 13:18:36	2025-06-07 13:18:50
73	9	\N	35	Réunion de la coopérative d'entreprise	Etroite	2025-05-30 14:55:00	2025-05-30 14:56:00	annulee	7	t	2025-05-26 13:57:37	2025-05-26 14:01:10
81	9	\N	\N	drtrtr	tyetr	2025-05-30 10:14:00	2025-05-31 10:14:00	en_attente	4	f	2025-05-30 09:41:43	2025-05-30 09:41:43
87	9	\N	\N	reunion de haute	fvfgtgt	2025-06-02 12:19:00	2025-06-03 12:20:00	en_attente	4	f	2025-05-31 11:20:38	2025-05-31 11:20:38
88	20	\N	\N	Réunion de la coopérative d'entreprise	uurnnnnnvnvnvn	2025-06-03 12:20:00	2025-06-03 15:20:00	en_attente	5	f	2025-05-31 11:21:22	2025-05-31 11:21:22
97	9	\N	\N	REUNION TEST	JJJJJJJJJJJ	2025-06-07 14:13:00	2025-06-09 14:11:00	en_attente	5	f	2025-06-07 13:12:37	2025-06-07 13:13:32
94	18	\N	\N	sprint	test	2025-06-04 11:27:00	2025-06-06 11:27:00	valide	14	f	2025-06-03 10:27:56	2025-06-03 10:28:19
95	19	\N	\N	Réunion de la coopérative d'entreprise	\N	2025-06-04 12:57:00	2025-06-07 12:57:00	valide	11	f	2025-06-03 11:59:08	2025-06-03 13:02:31
67	6	\N	\N	Réunion de la coopérative d'entreprise	Salle informatique	2025-05-27 08:30:00	2025-05-27 14:38:00	valide	26	f	2025-05-23 21:54:09	2025-05-24 14:32:50
66	18	\N	\N	Réunion de la coopérative d'entreprise	salle informative	2025-05-27 08:30:00	2025-05-27 10:48:00	valide	30	f	2025-05-23 21:50:38	2025-05-24 16:14:36
26	6	\N	\N	TEST	RAS	2025-05-17 00:00:00	2025-06-08 00:00:00	valide	30	f	2025-05-10 15:29:36	2025-05-15 09:14:56
31	6	\N	\N	fs	vf	2025-05-18 00:00:00	2025-05-31 00:00:00	valide	214	f	2025-05-10 15:56:46	2025-05-15 19:41:34
28	6	\N	\N	tt	e	2025-05-16 00:00:00	2025-05-17 00:00:00	annulee	40	f	2025-05-10 15:41:14	2025-05-15 19:41:42
27	6	\N	\N	df	\N	2025-05-10 00:00:00	2025-06-08 00:00:00	annulee	40	f	2025-05-10 15:31:58	2025-05-15 19:41:51
57	17	\N	\N	DD	SD	2025-05-29 15:29:00	2025-05-29 16:29:00	valide	11	t	2025-05-21 11:32:21	2025-05-22 11:58:13
1	3	\N	\N	jjj	jj	2025-05-10 00:00:00	2025-06-08 00:00:00	valide	14	f	2025-04-30 17:58:23	2025-05-04 20:44:36
2	3	\N	\N	jjj	jj	2025-05-10 00:00:00	2025-06-08 00:00:00	annulee	14	f	2025-04-30 17:59:43	2025-05-04 20:49:00
3	3	\N	\N	jjj	jj	2025-05-10 00:00:00	2025-06-08 00:00:00	annulee	14	f	2025-04-30 18:07:43	2025-05-04 20:49:11
6	2	\N	\N	jklgkjfvkefvk	jj	2025-05-10 00:00:00	2025-05-10 00:00:00	annulee	15	t	2025-05-02 17:39:50	2025-05-04 20:49:23
14	2	\N	\N	test	lorem 10	2025-05-05 00:00:00	2025-05-06 00:00:00	valide	14	t	2025-05-05 13:31:33	2025-05-05 15:48:59
12	4	\N	\N	sprint	scrum	2025-05-18 00:00:00	2025-05-30 00:00:00	valide	14	t	2025-05-04 20:47:42	2025-05-05 15:49:43
15	6	\N	\N	Réunion de la coopérative d'entreprise	iii	2025-05-09 00:00:00	2025-05-09 00:00:00	valide	45	f	2025-05-06 16:52:01	2025-05-10 12:15:33
45	16	\N	\N	Coopération	\N	2025-05-15 00:00:00	2025-05-18 00:00:00	valide	25	f	2025-05-15 19:35:23	2025-05-15 19:41:18
16	6	\N	\N	Réunion de la coopérative d'entreprise	iii	2025-05-09 00:00:00	2025-05-09 00:00:00	valide	45	f	2025-05-06 16:52:40	2025-05-12 08:55:48
36	6	\N	\N	s	s	2025-05-15 00:00:00	2025-05-15 00:00:00	valide	2	f	2025-05-14 10:20:33	2025-05-15 09:14:12
37	6	\N	\N	s	s	2025-05-15 00:00:00	2025-05-15 00:00:00	valide	2	f	2025-05-14 10:20:53	2025-05-15 09:14:33
35	6	\N	\N	s	s	2025-05-15 00:00:00	2025-05-15 00:00:00	valide	2	f	2025-05-14 10:19:58	2025-05-15 09:14:39
40	6	\N	\N	ds	d	2025-05-15 00:00:00	2025-05-15 00:00:00	valide	1	f	2025-05-14 11:23:15	2025-05-15 09:14:44
42	6	\N	\N	d	d	2025-05-16 00:00:00	2025-05-24 00:00:00	valide	1	f	2025-05-14 11:44:13	2025-05-15 09:14:50
38	6	\N	\N	hh	h	2025-05-24 00:00:00	2025-05-24 00:00:00	valide	1	f	2025-05-14 10:27:01	2025-05-15 09:19:31
41	6	\N	\N	s	ss	2025-05-16 00:00:00	2025-05-16 00:00:00	valide	2	f	2025-05-14 11:29:03	2025-05-15 09:19:36
34	6	\N	\N	d	d	2025-05-16 00:00:00	2025-05-16 00:00:00	annulee	2	t	2025-05-14 10:18:59	2025-05-15 09:19:42
39	6	\N	\N	hh	h	2025-05-24 00:00:00	2025-05-24 00:00:00	annulee	1	f	2025-05-14 10:27:09	2025-05-15 09:19:47
46	6	\N	\N	Coopération	\N	2025-05-15 00:00:00	2025-05-18 00:00:00	valide	21	f	2025-05-15 19:37:43	2025-05-15 19:40:50
60	6	\N	\N	sprint	àoiuytree	2025-05-23 12:06:00	2025-05-23 14:06:00	valide	7	t	2025-05-22 11:22:47	2025-05-22 11:30:11
58	16	\N	\N	rterttrtr	rryutyu	2025-05-23 11:36:00	2025-05-23 13:36:00	valide	3	f	2025-05-22 09:36:45	2025-05-22 09:37:16
48	17	\N	\N	u	uuu	2025-05-26 14:00:00	2025-05-26 14:17:00	valide	2	f	2025-05-16 15:59:04	2025-05-22 11:29:49
59	6	\N	\N	grtrhhrtht	htrhtrhrth	2025-05-23 08:27:00	2025-05-23 10:42:00	valide	2	t	2025-05-22 09:42:54	2025-05-22 11:47:41
62	17	\N	\N	Réunion de la coopérative d'entreprise	efuè-	2025-05-30 14:40:00	2025-05-30 15:40:00	valide	4	f	2025-05-22 13:40:47	2025-05-22 13:41:03
61	17	\N	\N	htrht	hthr	2025-05-26 13:00:00	2025-05-26 15:00:00	valide	4	t	2025-05-22 12:01:13	2025-05-23 04:50:17
63	16	\N	\N	gttt	ffgf	2025-05-24 16:09:00	2025-05-24 16:23:00	valide	2	t	2025-05-23 19:21:07	2025-05-24 14:32:05
71	17	\N	\N	jjjj	\N	2025-05-26 16:05:00	2025-05-26 17:05:00	valide	8	f	2025-05-24 15:05:50	2025-05-24 16:15:13
68	19	\N	\N	formation	\N	2025-05-26 09:28:00	2025-05-26 10:29:00	valide	14	f	2025-05-24 09:44:55	2025-05-24 16:15:36
96	18	\N	\N	reeeeeere	hhhhhhhhhhhhhhhhhhh	2025-06-06 14:59:00	2025-06-09 14:54:00	annulee	12	f	2025-06-06 13:54:44	2025-06-06 16:34:28
76	16	\N	\N	gfgnrthtr	tgtrrtge	2025-05-28 13:11:00	2025-05-29 13:11:00	annulee	8	t	2025-05-28 12:29:12	2025-06-03 10:26:28
77	17	\N	\N	ezrtryj	egtryty	2025-05-30 13:47:00	2025-05-31 13:47:00	annulee	20	t	2025-05-28 13:11:23	2025-06-03 10:26:47
78	6	\N	\N	Réunion de la coopérative d'entreprise	wXwsdfg	2025-06-03 18:07:00	2025-06-05 18:07:00	annulee	15	f	2025-05-28 17:07:49	2025-06-03 10:26:51
93	18	\N	\N	sprint	hh	2025-06-03 10:09:00	2025-06-04 10:05:00	annulee	27	f	2025-06-03 09:06:28	2025-06-03 10:27:17
92	16	\N	\N	Réunion de la coopérative d'entreprise	\N	2025-06-03 10:00:00	2025-06-04 09:56:00	annulee	5	f	2025-06-03 09:00:01	2025-06-03 10:27:21
\.


--
-- TOC entry 5089 (class 0 OID 26099)
-- Dependencies: 247
-- Data for Name: reset_code_passwords; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reset_code_passwords (id, code, email, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5068 (class 0 OID 17617)
-- Dependencies: 226
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, nom, created_at, updated_at) FROM stdin;
8	Administrateur Système	\N	\N
1	Assistant de directions	\N	2025-04-30 07:58:55
18	DEMANDEUR	2025-06-07 13:40:41	2025-06-07 13:40:41
\.


--
-- TOC entry 5062 (class 0 OID 17581)
-- Dependencies: 220
-- Data for Name: salles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salles (id, nom, capacite, localisation, description, created_at, updated_at, company_id) FROM stdin;
3	Salle C03	50	Bâtiment C, 2e étage	Grande salle pour conférences	\N	\N	\N
4	Salle D04	15	Bâtiment D, 3e étage	Salle pour formations internes	\N	\N	\N
5	Salle E05	8	Bâtiment E, RDC	Salle de brainstorming et ateliers créatifs	\N	\N	\N
1	Salle A01	11	Bâtiment A, 1er étage	Petite salle pour réunions d’équipe	\N	2025-04-29 13:46:07	\N
7	Salle-A2e	25	primiere niveau CGRainf	rrr	2025-05-04 18:35:21	2025-05-04 19:05:47	\N
2	Salle B02	21	Bâtiment B, RDC	Salle équipée pour présentations et séminaires	\N	2025-05-07 12:41:22	\N
9	jjerjk	7	rjrjjr	hhehv	2025-05-09 17:21:13	2025-05-09 17:21:13	3
10	SALLE P-02	12	DOKOTI/KJ	pour reunion des DG	2025-05-10 07:15:58	2025-05-10 07:15:58	\N
11	SALLE P-07	12	DOKOTI/K7	RAS	2025-05-10 07:21:06	2025-05-10 07:21:06	\N
12	VRGR	7	RVRTG	RVT	2025-05-10 07:24:03	2025-05-10 07:24:03	\N
14	SALLE-P1	14	ETAGE 2 EN FACE BUREEAU PRESIDENT	POUR DES ACCASSION RARE	2025-05-10 10:51:29	2025-05-10 10:51:29	4
18	Salle P02	31	première niveau P2	chaise, table,amuoar	2025-05-23 21:13:26	2025-05-23 21:13:26	1
6	SALLE-A2	42	primiere niveau DGRain	chaise,table,document	2025-05-04 18:34:34	2025-05-23 21:15:33	1
16	SALLE- P001	24	BATIMENT B 4 ETAGE	Chaise, table, mur	2025-05-15 19:23:41	2025-05-23 21:16:21	1
17	SALLE-D001	42	première niveau rayer	Table, document, Mur	2025-05-15 19:24:51	2025-05-23 21:19:17	1
19	Salle -D112	25	Première niveau deuxième étage	Salle climatise	2025-05-23 21:59:15	2025-05-23 21:59:15	1
20	PINK	8	Batiment 7	Large	2025-05-26 13:43:19	2025-05-26 13:43:19	3
\.


--
-- TOC entry 5072 (class 0 OID 17656)
-- Dependencies: 230
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
OlfIdVS8qljrvWaTmtT7H28D5DVNpFlBCs5W5RgF	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiaUlRNmVGajFXOFZiTXhNUVAyN2hLZ29mbG9XWHkybExHa2poSGFNeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750670352
MZA7BWlUND58jHs3DLocS0yJSDE3uXV1BfFTlzhf	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWVueERQbXIyUDVRalBGRUxrV0FpaGhyRzNPeVBqSWU5OGZuVWQ3aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750669328
a6a0LkTrRva2UdiafG6KOS9MRlqgresEYa3hmJZM	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoicDNlWDIwdnJLWnJpNUo2S2k4RUs3MzhuQ01JWDRuVlhFRlM4WDEzNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750667747
AWPxjkcZR80giKWD3TwkEOaIYnzIVqzoulHZRiO7	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGdxRmN6VmZDV3ZsU1EybWNRQXhha3VYeElmS1RlaUg3SGVjR3lHeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750667578
jfJdYugdsn1LpauWoIADltz8g8toBv3nuN3vyby3	43	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNlhBblNsbHFPeUp3cmMxYzlITko3WU9VVWJ0NjRuMmJXTlNrYVpCRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wbGFubmluZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjQzO30=	1750672563
x0m621KyOnuHHRzVJqgt0QEPSjLpn2UWABK2lgoE	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiVEk3ek9pMVN5cTZoeUhLWUVSSUFGUmxGUXZuNUl0Yjl6aU5ER2JGYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750666278
rrAxKoYxIqgSLsVA6hfKHApaWgUt5Iw8wRjcJm62	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoibnllVm1VbFM0c0lTTFJTdXRHV1g2aVljWGt6c3ZPYll0ZGh5b0xiOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750666307
wekX5cxInvn7QVCPXYbCJ2QByJDlIzRnpPY6up7x	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDd5Rm1telhMMnNOaWhlQmVJRW9EUVhIUW9YNWpFbTNaUE9ueDN2dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750669272
B939lTvVGbLo3xIcwwoeU1lYYj7N2z5AxTgDYy8z	\N	\N		YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3RNN0VXYURUeDVKNTFLeUl5OXg2U1JRSERaWnhCc29MazJkTWF4SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6ODoiaHR0cDovLzoiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1750666339
SibHIqUVECdopi7cJA7S53w0Ob2z54opp6uzrcPv	41	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36	YTo1OntzOjY6Il90b2tlbiI7czo0MDoiYWxZejJGRzdjcEYyNElKTjYzY0JQZ21WR29tdG5mQ2xicEhiSFZkdCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyODoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FkbWlucyI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvcGxhbm5pbmciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo0MTt9	1750672563
x6xxMmVTm2dJeXptLm2FzOMnIwMjinjJKdajBhB6	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0	YToyOntzOjY6Il90b2tlbiI7czo0MDoiYXR0OGNReE1SaE5Hc3JHM2NCQXJGeW9JTUE4UjY4elFCVk9uSGx2eSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1750670061
\.


--
-- TOC entry 5087 (class 0 OID 26075)
-- Dependencies: 245
-- Data for Name: user_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permission (id, user_id, id_permission, created_at, updated_at) FROM stdin;
49	35	9	\N	\N
\.


--
-- TOC entry 5070 (class 0 OID 17624)
-- Dependencies: 228
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, id_role, departement_id, password, remember_token, created_at, updated_at, receive_notifications, company_id) FROM stdin;
35	Augustine	moundyaugustine9@gmail.com	\N	8	1	$2y$12$./kBwTXOCRlywDo5WUbi8usY/8mjWBvHk45E8vSurlp0CUp8gidj.	\N	2025-05-26 13:30:29	2025-05-30 08:47:44	t	3
42	user1	user1@cadyst.com	\N	1	3	$2y$12$/kbeEVSWCvZd6ehwJ0TouuHepQs/hhfBUbdtoUwlvYCU5fvLpR6sO	\N	2025-06-23 08:28:21	2025-06-23 08:28:21	t	4
41	test	test75@cadyst.com	\N	8	4	$2y$12$nIDunbNeaxrHL2c78VGd8.AL/tZazECXIaQannYDuPz/6/2OnTZ72	\N	2025-06-23 08:24:13	2025-06-23 08:29:00	t	4
43	demandeur	demandeur1@cadyst.com	\N	18	5	$2y$12$w0ZwZx/toJc0iyy8fl.NXe.mvVin1F7s3unEyAWJRvOaV9NoSB24e	\N	2025-06-23 08:31:03	2025-06-23 08:31:03	t	4
\.


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 249
-- Name: company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_id_seq', 5, true);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 221
-- Name: departements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departements_id_seq', 12, true);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 242
-- Name: equipement_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipement_reservation_id_seq', 126, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 238
-- Name: equipements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipements_id_seq', 10, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 236
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 4, true);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 233
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 118, true);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 217
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 18, true);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 223
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 16, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 240
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 98, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 246
-- Name: reset_code_passwords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reset_code_passwords_id_seq', 1, false);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 225
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 18, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 219
-- Name: salles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salles_id_seq', 20, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_permission_id_seq', 53, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 227
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 43, true);


--
-- TOC entry 4873 (class 2606 OID 17678)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4871 (class 2606 OID 17671)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 4901 (class 2606 OID 34319)
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 17608)
-- Name: departements departements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departements
    ADD CONSTRAINT departements_pkey PRIMARY KEY (id);


--
-- TOC entry 4888 (class 2606 OID 17845)
-- Name: equipement_reservation equipement_reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement_reservation
    ADD CONSTRAINT equipement_reservation_pkey PRIMARY KEY (id);


--
-- TOC entry 4890 (class 2606 OID 17857)
-- Name: equipement_reservation equipement_reservation_reservation_id_equipement_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement_reservation
    ADD CONSTRAINT equipement_reservation_reservation_id_equipement_id_unique UNIQUE (reservation_id, equipement_id);


--
-- TOC entry 4884 (class 2606 OID 17769)
-- Name: equipements equipements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipements
    ADD CONSTRAINT equipements_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 17705)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4882 (class 2606 OID 17707)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 4878 (class 2606 OID 17695)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 17687)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 17570)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4899 (class 2606 OID 34259)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4865 (class 2606 OID 17655)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 4857 (class 2606 OID 17615)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4886 (class 2606 OID 17823)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4896 (class 2606 OID 26106)
-- Name: reset_code_passwords reset_code_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_code_passwords
    ADD CONSTRAINT reset_code_passwords_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 17622)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4853 (class 2606 OID 17588)
-- Name: salles salles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT salles_pkey PRIMARY KEY (id);


--
-- TOC entry 4868 (class 2606 OID 17662)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 26080)
-- Name: user_permission user_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission
    ADD CONSTRAINT user_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4894 (class 2606 OID 26092)
-- Name: user_permission user_permission_user_id_id_permission_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission
    ADD CONSTRAINT user_permission_user_id_id_permission_unique UNIQUE (user_id, id_permission);


--
-- TOC entry 4861 (class 2606 OID 17648)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4863 (class 2606 OID 17631)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4876 (class 1259 OID 17688)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 4897 (class 1259 OID 34257)
-- Name: notifications_notifiable_type_notifiable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_notifiable_type_notifiable_id_index ON public.notifications USING btree (notifiable_type, notifiable_id);


--
-- TOC entry 4866 (class 1259 OID 17664)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4869 (class 1259 OID 17663)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 4910 (class 2606 OID 17851)
-- Name: equipement_reservation equipement_reservation_equipement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement_reservation
    ADD CONSTRAINT equipement_reservation_equipement_id_foreign FOREIGN KEY (equipement_id) REFERENCES public.equipements(id) ON DELETE RESTRICT;


--
-- TOC entry 4911 (class 2606 OID 17846)
-- Name: equipement_reservation equipement_reservation_reservation_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipement_reservation
    ADD CONSTRAINT equipement_reservation_reservation_id_foreign FOREIGN KEY (reservation_id) REFERENCES public.reservations(id) ON DELETE CASCADE;


--
-- TOC entry 4903 (class 2606 OID 34344)
-- Name: departements fk_departements_company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departements
    ADD CONSTRAINT fk_departements_company FOREIGN KEY (company_id) REFERENCES public.company(id) ON DELETE CASCADE;


--
-- TOC entry 4902 (class 2606 OID 34327)
-- Name: salles fk_salles_company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salles
    ADD CONSTRAINT fk_salles_company FOREIGN KEY (company_id) REFERENCES public.company(id) ON DELETE CASCADE;


--
-- TOC entry 4904 (class 2606 OID 34339)
-- Name: users fk_users_company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_company FOREIGN KEY (company_id) REFERENCES public.company(id) ON DELETE CASCADE;


--
-- TOC entry 4907 (class 2606 OID 17834)
-- Name: reservations reservations_id_createur_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_createur_foreign FOREIGN KEY (id_createur) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 4908 (class 2606 OID 17829)
-- Name: reservations reservations_id_demandeur_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_demandeur_foreign FOREIGN KEY (id_demandeur) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 4909 (class 2606 OID 17824)
-- Name: reservations reservations_salle_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_salle_id_foreign FOREIGN KEY (salle_id) REFERENCES public.salles(id) ON DELETE CASCADE;


--
-- TOC entry 4912 (class 2606 OID 26086)
-- Name: user_permission user_permission_id_permission_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission
    ADD CONSTRAINT user_permission_id_permission_foreign FOREIGN KEY (id_permission) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- TOC entry 4913 (class 2606 OID 26081)
-- Name: user_permission user_permission_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission
    ADD CONSTRAINT user_permission_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4905 (class 2606 OID 17642)
-- Name: users users_departement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_departement_id_foreign FOREIGN KEY (departement_id) REFERENCES public.departements(id) ON DELETE CASCADE;


--
-- TOC entry 4906 (class 2606 OID 17632)
-- Name: users users_id_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_role_foreign FOREIGN KEY (id_role) REFERENCES public.roles(id) ON DELETE CASCADE;


-- Completed on 2025-06-23 10:57:04

--
-- PostgreSQL database dump complete
--

