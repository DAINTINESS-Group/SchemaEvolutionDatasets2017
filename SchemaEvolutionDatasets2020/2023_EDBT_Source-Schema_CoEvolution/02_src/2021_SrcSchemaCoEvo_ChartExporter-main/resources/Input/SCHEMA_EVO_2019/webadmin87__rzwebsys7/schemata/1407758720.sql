--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-08-11 14:45:10 MSK


--
-- TOC entry 212 (class 1259 OID 54272)
-- Name: geo_countrys; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geo_countrys (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    title2 character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 54318)
-- Name: geo_np; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geo_np (
    id integer NOT NULL,
    rajon_id integer NOT NULL,
    clean_title character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    title2 character varying(255) NOT NULL,
    type character varying(16) NOT NULL,
    type_ext character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 54300)
-- Name: geo_rajon; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geo_rajon (
    id integer NOT NULL,
    region_id integer NOT NULL,
    clean_title character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    title2 character varying(255) NOT NULL,
    type character varying(16) NOT NULL,
    type_ext character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 54283)
-- Name: geo_region; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geo_region (
    id integer NOT NULL,
    country_id integer NOT NULL,
    clean_title character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    title2 character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    type_ext character varying(255) NOT NULL,
    code integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

