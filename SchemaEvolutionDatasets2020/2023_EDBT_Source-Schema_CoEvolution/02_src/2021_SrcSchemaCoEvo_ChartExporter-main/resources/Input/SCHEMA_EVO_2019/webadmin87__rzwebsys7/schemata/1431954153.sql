--
-- PostgreSQL database dump
--

--
-- Name: geo_countrys; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geo_countrys (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    title2 character varying(255) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: geo_np; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);



--
-- Name: geo_rajon; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);



--
-- Name: geo_region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
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
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: geo_street; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE geo_street (
    id integer NOT NULL,
    region_id integer DEFAULT 0 NOT NULL,
    rajon_id integer DEFAULT 0 NOT NULL,
    clean_title character varying(255),
    title character varying(255) NOT NULL,
    title2 character varying(255),
    type character varying(16),
    type_ext character varying(255),
    code character varying(255),
    active boolean DEFAULT true NOT NULL,
    author_id integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) with time zone DEFAULT now() NOT NULL
);

