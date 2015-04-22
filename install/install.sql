REVOKE CONNECT ON DATABASE acdwide FROM PUBLIC, acdwide;
DROP DATABASE IF EXISTS acdwide;
DROP ROLE acdwide;

CREATE ROLE acdwide LOGIN ENCRYPTED PASSWORD 'md5ba3c6ad6edd7233f0024691483526660' VALID UNTIL 'infinity';
CREATE DATABASE acdwide WITH ENCODING='UTF8' OWNER=acdwide CONNECTION LIMIT=-1;
\c acdwide;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.15
-- Dumped by pg_dump version 9.1.15
-- Started on 2015-04-22 11:18:19 EEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 188 (class 3079 OID 11685)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 188
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 513 (class 1247 OID 62278)
-- Dependencies: 6
-- Name: list_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE list_type AS ENUM (
    'white',
    'black'
);


ALTER TYPE public.list_type OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 62267)
-- Dependencies: 1879 1880 1881 1882 6
-- Name: agents_logs; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE agents_logs (
    id serial NOT NULL,
    dt timestamp without time zone,
    agent integer,
    event integer,
    callerid character varying(32),
    timer integer,
    acdgroup character varying(16) DEFAULT 0,
    extention text,
    beforeanswer integer DEFAULT 0,
    dialstatus integer DEFAULT 0,
    begin_time timestamp without time zone,
    record_id integer DEFAULT 0
);


ALTER TABLE public.agents_logs OWNER TO acdwide;

--
-- TOC entry 164 (class 1259 OID 62292)
-- Dependencies: 6
-- Name: calls; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE calls (
    id1 integer NOT NULL,
    id bigint,
    dt timestamp without time zone,
    acdgroup character varying(10),
    agent integer,
    status smallint,
    beforeanswer integer,
    answertime integer,
    queuetime integer,
    queuecount integer,
    callerid character varying(32),
    exten character varying,
    holdtime integer,
    crossid integer,
    operator character varying(1)
);


ALTER TABLE public.calls OWNER TO acdwide;

--
-- TOC entry 165 (class 1259 OID 62298)
-- Dependencies: 6
-- Name: calls_id1_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE calls_id1_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calls_id1_seq OWNER TO acdwide;

--
-- TOC entry 166 (class 1259 OID 62300)
-- Dependencies: 6 164
-- Name: calls_id1_seq1; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE calls_id1_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calls_id1_seq1 OWNER TO acdwide;

--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 166
-- Name: calls_id1_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE calls_id1_seq1 OWNED BY calls.id1;


--
-- TOC entry 162 (class 1259 OID 62283)
-- Dependencies: 1883 6 513
-- Name: calls_rules; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE calls_rules (
    id integer NOT NULL,
    date timestamp without time zone,
    type list_type,
    number text,
    count integer DEFAULT 0,
    text text,
    service text
);


ALTER TABLE public.calls_rules OWNER TO acdwide;

--
-- TOC entry 163 (class 1259 OID 62290)
-- Dependencies: 6 162
-- Name: calls_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE calls_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calls_rules_id_seq OWNER TO acdwide;

--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 163
-- Name: calls_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE calls_rules_id_seq OWNED BY calls_rules.id;


--
-- TOC entry 171 (class 1259 OID 62318)
-- Dependencies: 6
-- Name: languages; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE languages (
    id integer NOT NULL,
    name text,
    name_short text
);


ALTER TABLE public.languages OWNER TO acdwide;

--
-- TOC entry 172 (class 1259 OID 62324)
-- Dependencies: 6 171
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_id_seq OWNER TO acdwide;

--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 172
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE languages_id_seq OWNED BY languages.id;


--
-- TOC entry 167 (class 1259 OID 62302)
-- Dependencies: 6
-- Name: location; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE location (
    id integer NOT NULL,
    name text,
    ip inet
);


ALTER TABLE public.location OWNER TO acdwide;

--
-- TOC entry 168 (class 1259 OID 62308)
-- Dependencies: 6 167
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_id_seq OWNER TO acdwide;

--
-- TOC entry 2091 (class 0 OID 0)
-- Dependencies: 168
-- Name: location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE location_id_seq OWNED BY location.id;


--
-- TOC entry 169 (class 1259 OID 62310)
-- Dependencies: 6
-- Name: managers; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE managers (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.managers OWNER TO acdwide;

--
-- TOC entry 170 (class 1259 OID 62316)
-- Dependencies: 6 169
-- Name: managers_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE managers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.managers_id_seq OWNER TO acdwide;

--
-- TOC entry 2092 (class 0 OID 0)
-- Dependencies: 170
-- Name: managers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE managers_id_seq OWNED BY managers.id;


--
-- TOC entry 173 (class 1259 OID 62326)
-- Dependencies: 6
-- Name: operators; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE operators (
    id integer NOT NULL,
    name text,
    password text,
    manager_id integer,
    date_hire date,
    date_fired date,
    can_outgoing smallint
);


ALTER TABLE public.operators OWNER TO acdwide;

--
-- TOC entry 178 (class 1259 OID 62348)
-- Dependencies: 6 173
-- Name: operators_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE operators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operators_id_seq OWNER TO acdwide;

--
-- TOC entry 2094 (class 0 OID 0)
-- Dependencies: 178
-- Name: operators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE operators_id_seq OWNED BY operators.id;


--
-- TOC entry 174 (class 1259 OID 62332)
-- Dependencies: 6
-- Name: operators_languages; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE operators_languages (
    id integer NOT NULL,
    operator_id integer,
    lang_id integer
);


ALTER TABLE public.operators_languages OWNER TO acdwide;

--
-- TOC entry 175 (class 1259 OID 62335)
-- Dependencies: 174 6
-- Name: operators_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE operators_languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operators_languages_id_seq OWNER TO acdwide;

--
-- TOC entry 2095 (class 0 OID 0)
-- Dependencies: 175
-- Name: operators_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE operators_languages_id_seq OWNED BY operators_languages.id;


--
-- TOC entry 179 (class 1259 OID 62350)
-- Dependencies: 1895 6
-- Name: operators_services; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE operators_services (
    id integer NOT NULL,
    service_id integer,
    operator_id integer,
    weigth integer DEFAULT 0
);


ALTER TABLE public.operators_services OWNER TO acdwide;

--
-- TOC entry 180 (class 1259 OID 62354)
-- Dependencies: 179 6
-- Name: operators_services_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE operators_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operators_services_id_seq OWNER TO acdwide;

--
-- TOC entry 2096 (class 0 OID 0)
-- Dependencies: 180
-- Name: operators_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE operators_services_id_seq OWNED BY operators_services.id;


--
-- TOC entry 176 (class 1259 OID 62337)
-- Dependencies: 1891 1892 1893 6
-- Name: operators_working; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE operators_working (
    id integer NOT NULL,
    operator_id integer,
    "time" timestamp without time zone,
    status integer,
    location text,
    calls integer DEFAULT 0,
    calls_time integer DEFAULT 0,
    rate integer,
    number text,
    service_id integer,
    channels text,
    channels_check integer,
    state smallint DEFAULT 0,
    "timestamp" integer
);


ALTER TABLE public.operators_working OWNER TO acdwide;

--
-- TOC entry 177 (class 1259 OID 62346)
-- Dependencies: 176 6
-- Name: operators_working_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE operators_working_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.operators_working_id_seq OWNER TO acdwide;

--
-- TOC entry 2097 (class 0 OID 0)
-- Dependencies: 177
-- Name: operators_working_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE operators_working_id_seq OWNED BY operators_working.id;


--
-- TOC entry 181 (class 1259 OID 62356)
-- Dependencies: 6
-- Name: queues; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE queues (
    id integer NOT NULL,
    service_id integer,
    weight integer,
    bussy integer,
    "time" timestamp without time zone,
    number text,
    channel text,
    time_from timestamp without time zone,
    "timestamp" integer,
    timestamp_from integer
);


ALTER TABLE public.queues OWNER TO acdwide;

--
-- TOC entry 182 (class 1259 OID 62362)
-- Dependencies: 6 181
-- Name: queues_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE queues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.queues_id_seq OWNER TO acdwide;

--
-- TOC entry 2098 (class 0 OID 0)
-- Dependencies: 182
-- Name: queues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE queues_id_seq OWNED BY queues.id;


--
-- TOC entry 183 (class 1259 OID 62364)
-- Dependencies: 6
-- Name: records; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE records (
    id integer NOT NULL,
    date timestamp without time zone,
    file_name character varying(100),
    uniqueid character varying(100),
    context character varying(100),
    extension character varying(100),
    callerid character varying(100)
);


ALTER TABLE public.records OWNER TO acdwide;

--
-- TOC entry 184 (class 1259 OID 62370)
-- Dependencies: 6 183
-- Name: records_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.records_id_seq OWNER TO acdwide;

--
-- TOC entry 2100 (class 0 OID 0)
-- Dependencies: 184
-- Name: records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE records_id_seq OWNED BY records.id;


--
-- TOC entry 185 (class 1259 OID 62372)
-- Dependencies: 1899 1900 6
-- Name: services; Type: TABLE; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    name text,
    weight integer,
    message text,
    service_order integer DEFAULT 0,
    access_type smallint DEFAULT 0,
    extensions character varying(60)[]
);


ALTER TABLE public.services OWNER TO acdwide;

--
-- TOC entry 186 (class 1259 OID 62380)
-- Dependencies: 185 6
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO acdwide;

--
-- TOC entry 2101 (class 0 OID 0)
-- Dependencies: 186
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acdwide
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- TOC entry 187 (class 1259 OID 62382)
-- Dependencies: 6
-- Name: summary_agents_calls_sac_id_seq; Type: SEQUENCE; Schema: public; Owner: acdwide
--

CREATE SEQUENCE summary_agents_calls_sac_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.summary_agents_calls_sac_id_seq OWNER TO acdwide;

--
-- TOC entry 1885 (class 2604 OID 62385)
-- Dependencies: 166 164
-- Name: id1; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY calls ALTER COLUMN id1 SET DEFAULT nextval('calls_id1_seq1'::regclass);


--
-- TOC entry 1884 (class 2604 OID 62384)
-- Dependencies: 163 162
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY calls_rules ALTER COLUMN id SET DEFAULT nextval('calls_rules_id_seq'::regclass);


--
-- TOC entry 1888 (class 2604 OID 62388)
-- Dependencies: 172 171
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY languages ALTER COLUMN id SET DEFAULT nextval('languages_id_seq'::regclass);


--
-- TOC entry 1886 (class 2604 OID 62386)
-- Dependencies: 168 167
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY location ALTER COLUMN id SET DEFAULT nextval('location_id_seq'::regclass);


--
-- TOC entry 1887 (class 2604 OID 62387)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY managers ALTER COLUMN id SET DEFAULT nextval('managers_id_seq'::regclass);


--
-- TOC entry 1889 (class 2604 OID 62389)
-- Dependencies: 178 173
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators ALTER COLUMN id SET DEFAULT nextval('operators_id_seq'::regclass);


--
-- TOC entry 1890 (class 2604 OID 62390)
-- Dependencies: 175 174
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_languages ALTER COLUMN id SET DEFAULT nextval('operators_languages_id_seq'::regclass);


--
-- TOC entry 1896 (class 2604 OID 62392)
-- Dependencies: 180 179
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_services ALTER COLUMN id SET DEFAULT nextval('operators_services_id_seq'::regclass);


--
-- TOC entry 1894 (class 2604 OID 62391)
-- Dependencies: 177 176
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_working ALTER COLUMN id SET DEFAULT nextval('operators_working_id_seq'::regclass);


--
-- TOC entry 1897 (class 2604 OID 62393)
-- Dependencies: 182 181
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY queues ALTER COLUMN id SET DEFAULT nextval('queues_id_seq'::regclass);


--
-- TOC entry 1898 (class 2604 OID 62394)
-- Dependencies: 184 183
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY records ALTER COLUMN id SET DEFAULT nextval('records_id_seq'::regclass);


--
-- TOC entry 1901 (class 2604 OID 62395)
-- Dependencies: 186 185
-- Name: id; Type: DEFAULT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- TOC entry 2053 (class 0 OID 62267)
-- Dependencies: 161 2080
-- Data for Name: agents_logs; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY agents_logs (dt, agent, event, callerid, timer, acdgroup, extention, beforeanswer, dialstatus, begin_time, record_id) FROM stdin;
\.


--
-- TOC entry 2056 (class 0 OID 62292)
-- Dependencies: 164 2080
-- Data for Name: calls; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY calls (id1, id, dt, acdgroup, agent, status, beforeanswer, answertime, queuetime, queuecount, callerid, exten, holdtime, crossid, operator) FROM stdin;
\.


--
-- TOC entry 2102 (class 0 OID 0)
-- Dependencies: 165
-- Name: calls_id1_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('calls_id1_seq', 1, false);


--
-- TOC entry 2103 (class 0 OID 0)
-- Dependencies: 166
-- Name: calls_id1_seq1; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('calls_id1_seq1', 46, true);


--
-- TOC entry 2054 (class 0 OID 62283)
-- Dependencies: 162 2080
-- Data for Name: calls_rules; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY calls_rules (id, date, type, number, count, text, service) FROM stdin;
\.


--
-- TOC entry 2104 (class 0 OID 0)
-- Dependencies: 163
-- Name: calls_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('calls_rules_id_seq', 1, false);


--
-- TOC entry 2063 (class 0 OID 62318)
-- Dependencies: 171 2080
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY languages (id, name, name_short) FROM stdin;
1	English	en
2	Mandarin	ch
3	Spanish	es
4	Hindi	hi
5	Arabic	ar
6	Portuguese	po
7	German	gr
8	French	fr
\.


--
-- TOC entry 2105 (class 0 OID 0)
-- Dependencies: 172
-- Name: languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('languages_id_seq', 1, false);


--
-- TOC entry 2059 (class 0 OID 62302)
-- Dependencies: 167 2080
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY location (id, name, ip) FROM stdin;
1	SIP/3001	192.168.0.51
2	SIP/3002	192.168.0.52
\.


--
-- TOC entry 2106 (class 0 OID 0)
-- Dependencies: 168
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('location_id_seq', 2, true);


--
-- TOC entry 2061 (class 0 OID 62310)
-- Dependencies: 169 2080
-- Data for Name: managers; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY managers (id, name) FROM stdin;
1	Brand Joober
\.


--
-- TOC entry 2107 (class 0 OID 0)
-- Dependencies: 170
-- Name: managers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('managers_id_seq', 1, false);


--
-- TOC entry 2065 (class 0 OID 62326)
-- Dependencies: 173 2080
-- Data for Name: operators; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY operators (id, name, password, manager_id, date_hire, date_fired, can_outgoing) FROM stdin;
1	John Dumas	3144	1	2015-03-22	\N	1
2	Lara Victoria	8181	1	2015-03-22	\N	0
\.


--
-- TOC entry 2108 (class 0 OID 0)
-- Dependencies: 178
-- Name: operators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('operators_id_seq', 2, true);


--
-- TOC entry 2066 (class 0 OID 62332)
-- Dependencies: 174 2080
-- Data for Name: operators_languages; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY operators_languages (id, operator_id, lang_id) FROM stdin;
1	2	2
2	1	2
3	1	1
\.


--
-- TOC entry 2109 (class 0 OID 0)
-- Dependencies: 175
-- Name: operators_languages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('operators_languages_id_seq', 1, true);


--
-- TOC entry 2071 (class 0 OID 62350)
-- Dependencies: 179 2080
-- Data for Name: operators_services; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY operators_services (id, service_id, operator_id, weigth) FROM stdin;
1	1	1	100
2	2	1	50
3	2	2	100
\.


--
-- TOC entry 2110 (class 0 OID 0)
-- Dependencies: 180
-- Name: operators_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('operators_services_id_seq', 3, true);


--
-- TOC entry 2068 (class 0 OID 62337)
-- Dependencies: 176 2080
-- Data for Name: operators_working; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY operators_working (id, operator_id, "time", status, location, calls, calls_time, rate, number, service_id, channels, channels_check, state, "timestamp") FROM stdin;
\.


--
-- TOC entry 2111 (class 0 OID 0)
-- Dependencies: 177
-- Name: operators_working_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('operators_working_id_seq', 17, true);


--
-- TOC entry 2073 (class 0 OID 62356)
-- Dependencies: 181 2080
-- Data for Name: queues; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY queues (id, service_id, weight, bussy, "time", number, channel, time_from, "timestamp", timestamp_from) FROM stdin;
\.


--
-- TOC entry 2112 (class 0 OID 0)
-- Dependencies: 182
-- Name: queues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('queues_id_seq', 46, true);


--
-- TOC entry 2075 (class 0 OID 62364)
-- Dependencies: 183 2080
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY records (id, date, file_name, uniqueid, context, extension, callerid) FROM stdin;
\.


--
-- TOC entry 2113 (class 0 OID 0)
-- Dependencies: 184
-- Name: records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('records_id_seq', 35, true);


--
-- TOC entry 2077 (class 0 OID 62372)
-- Dependencies: 185 2080
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: acdwide
--

COPY services (id, name, weight, message, service_order, access_type, extensions) FROM stdin;
1	840	50	840, %%name%%, %%hello%%	1	0	\N
2	123	20	Support, %%name%%, %%hello%%	2	0	\N
\.


--
-- TOC entry 2114 (class 0 OID 0)
-- Dependencies: 186
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('services_id_seq', 5, true);


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 187
-- Name: summary_agents_calls_sac_id_seq; Type: SEQUENCE SET; Schema: public; Owner: acdwide
--

SELECT pg_catalog.setval('summary_agents_calls_sac_id_seq', 1, false);


--
-- TOC entry 1903 (class 2606 OID 62397)
-- Dependencies: 161 161 161 161 161 2081
-- Name: agents_logs_dt_key; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY agents_logs
    ADD CONSTRAINT agents_logs_dt_key UNIQUE (dt, agent, event, callerid);


--
-- TOC entry 1922 (class 2606 OID 62403)
-- Dependencies: 171 171 2081
-- Name: languages_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- TOC entry 1918 (class 2606 OID 62399)
-- Dependencies: 167 167 2081
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- TOC entry 1920 (class 2606 OID 62401)
-- Dependencies: 169 169 2081
-- Name: managers_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY managers
    ADD CONSTRAINT managers_pkey PRIMARY KEY (id);


--
-- TOC entry 1929 (class 2606 OID 62405)
-- Dependencies: 174 174 2081
-- Name: operators_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY operators_languages
    ADD CONSTRAINT operators_languages_pkey PRIMARY KEY (id);


--
-- TOC entry 1926 (class 2606 OID 62407)
-- Dependencies: 173 173 2081
-- Name: operators_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY operators
    ADD CONSTRAINT operators_pkey PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 62409)
-- Dependencies: 179 179 2081
-- Name: operators_services_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY operators_services
    ADD CONSTRAINT operators_services_pkey PRIMARY KEY (id);


--
-- TOC entry 1941 (class 2606 OID 62411)
-- Dependencies: 181 181 2081
-- Name: queues_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY queues
    ADD CONSTRAINT queues_pkey PRIMARY KEY (id);


--
-- TOC entry 1944 (class 2606 OID 62413)
-- Dependencies: 183 183 2081
-- Name: records_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY records
    ADD CONSTRAINT records_pkey PRIMARY KEY (id);


--
-- TOC entry 1947 (class 2606 OID 62415)
-- Dependencies: 185 185 2081
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: acdwide; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 1904 (class 1259 OID 62416)
-- Dependencies: 161 161 161 2081
-- Name: agents_logs_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx1 ON agents_logs USING btree (dt, event, agent);


--
-- TOC entry 1905 (class 1259 OID 62417)
-- Dependencies: 161 161 161 161 2081
-- Name: agents_logs_idx2; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx2 ON agents_logs USING btree (dt, event, agent, acdgroup);


--
-- TOC entry 1906 (class 1259 OID 62418)
-- Dependencies: 161 161 161 161 2081
-- Name: agents_logs_idx3; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx3 ON agents_logs USING btree (dt, event, agent, extention);


--
-- TOC entry 1907 (class 1259 OID 62419)
-- Dependencies: 161 161 161 161 2081
-- Name: agents_logs_idx4; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx4 ON agents_logs USING btree (dt, agent, event, dialstatus);


--
-- TOC entry 1908 (class 1259 OID 62420)
-- Dependencies: 161 161 161 161 161 2081
-- Name: agents_logs_idx5; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx5 ON agents_logs USING btree (dt, agent, event, acdgroup, dialstatus);


--
-- TOC entry 1909 (class 1259 OID 62421)
-- Dependencies: 161 161 161 161 161 2081
-- Name: agents_logs_idx6; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx6 ON agents_logs USING btree (dt, agent, event, dialstatus, extention);


--
-- TOC entry 1910 (class 1259 OID 62426)
-- Dependencies: 161 2081
-- Name: agents_logs_idx7; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx7 ON agents_logs USING btree (agent);

ALTER TABLE agents_logs CLUSTER ON agents_logs_idx7;


--
-- TOC entry 1911 (class 1259 OID 62427)
-- Dependencies: 161 2081
-- Name: agents_logs_idx8; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx8 ON agents_logs USING btree (dt);


--
-- TOC entry 1912 (class 1259 OID 62428)
-- Dependencies: 161 2081
-- Name: agents_logs_idx9; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX agents_logs_idx9 ON agents_logs USING btree (event);


--
-- TOC entry 1914 (class 1259 OID 62423)
-- Dependencies: 164 2081
-- Name: calls_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX calls_idx ON calls USING btree (dt);


--
-- TOC entry 1915 (class 1259 OID 62424)
-- Dependencies: 164 2081
-- Name: calls_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX calls_idx1 ON calls USING btree (callerid);


--
-- TOC entry 1913 (class 1259 OID 62422)
-- Dependencies: 162 162 2081
-- Name: calls_rules_number_service_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX calls_rules_number_service_idx ON calls_rules USING btree (number, service);


--
-- TOC entry 1916 (class 1259 OID 62425)
-- Dependencies: 167 2081
-- Name: location_name_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX location_name_idx ON location USING btree (name);


--
-- TOC entry 1923 (class 1259 OID 62434)
-- Dependencies: 173 2081
-- Name: operators_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_idx1 ON operators USING btree (manager_id);


--
-- TOC entry 1924 (class 1259 OID 62437)
-- Dependencies: 173 2081
-- Name: operators_idx2; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_idx2 ON operators USING hash (password);


--
-- TOC entry 1927 (class 1259 OID 62435)
-- Dependencies: 174 2081
-- Name: operators_languages_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_languages_idx1 ON operators_languages USING btree (operator_id);


--
-- TOC entry 1933 (class 1259 OID 62431)
-- Dependencies: 179 2081
-- Name: operators_services_idx3; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_services_idx3 ON operators_services USING btree (operator_id);

ALTER TABLE operators_services CLUSTER ON operators_services_idx3;


--
-- TOC entry 1930 (class 1259 OID 62436)
-- Dependencies: 176 2081
-- Name: operators_working_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_working_idx ON operators_working USING btree (operator_id);


--
-- TOC entry 1931 (class 1259 OID 62429)
-- Dependencies: 176 2081
-- Name: operators_working_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_working_idx1 ON operators_working USING btree (location);


--
-- TOC entry 1932 (class 1259 OID 62430)
-- Dependencies: 176 176 2081
-- Name: operators_working_idx2; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX operators_working_idx2 ON operators_working USING btree (operator_id, status);


--
-- TOC entry 1936 (class 1259 OID 62432)
-- Dependencies: 181 181 2081
-- Name: queues_idx1; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX queues_idx1 ON queues USING btree (bussy, service_id);


--
-- TOC entry 1937 (class 1259 OID 62433)
-- Dependencies: 181 2081
-- Name: queues_idx2; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX queues_idx2 ON queues USING btree ("time");


--
-- TOC entry 1938 (class 1259 OID 62438)
-- Dependencies: 181 181 2081
-- Name: queues_idx3; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX queues_idx3 ON queues USING btree (service_id, weight);


--
-- TOC entry 1939 (class 1259 OID 62439)
-- Dependencies: 181 181 181 2081
-- Name: queues_idx4; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX queues_idx4 ON queues USING btree (bussy, id, service_id);


--
-- TOC entry 1942 (class 1259 OID 62440)
-- Dependencies: 183 2081
-- Name: records_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX records_idx ON records USING btree (file_name);


--
-- TOC entry 1945 (class 1259 OID 62441)
-- Dependencies: 185 2081
-- Name: services_idx; Type: INDEX; Schema: public; Owner: acdwide; Tablespace: 
--

CREATE INDEX services_idx ON services USING btree (name);


--
-- TOC entry 1948 (class 2606 OID 62442)
-- Dependencies: 1921 174 171 2081
-- Name: operators_languages_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_languages
    ADD CONSTRAINT operators_languages_id_fkey FOREIGN KEY (lang_id) REFERENCES languages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1949 (class 2606 OID 62447)
-- Dependencies: 1925 173 174 2081
-- Name: operators_languages_operator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_languages
    ADD CONSTRAINT operators_languages_operator_id_fkey FOREIGN KEY (operator_id) REFERENCES operators(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1950 (class 2606 OID 62452)
-- Dependencies: 179 173 1925 2081
-- Name: operators_services_operator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_services
    ADD CONSTRAINT operators_services_operator_id_fkey FOREIGN KEY (operator_id) REFERENCES operators(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1951 (class 2606 OID 62457)
-- Dependencies: 179 1946 185 2081
-- Name: operators_services_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: acdwide
--

ALTER TABLE ONLY operators_services
    ADD CONSTRAINT operators_services_service_id_fkey FOREIGN KEY (service_id) REFERENCES services(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2093 (class 0 OID 0)
-- Dependencies: 173
-- Name: operators; Type: ACL; Schema: public; Owner: acdwide
--

REVOKE ALL ON TABLE operators FROM PUBLIC;
REVOKE ALL ON TABLE operators FROM acdwide;
GRANT ALL ON TABLE operators TO acdwide;


--
-- TOC entry 2099 (class 0 OID 0)
-- Dependencies: 183
-- Name: records; Type: ACL; Schema: public; Owner: acdwide
--

REVOKE ALL ON TABLE records FROM PUBLIC;
REVOKE ALL ON TABLE records FROM acdwide;
GRANT ALL ON TABLE records TO acdwide;


-- Completed on 2015-04-22 11:18:19 EEST

--
-- PostgreSQL database dump complete
--

