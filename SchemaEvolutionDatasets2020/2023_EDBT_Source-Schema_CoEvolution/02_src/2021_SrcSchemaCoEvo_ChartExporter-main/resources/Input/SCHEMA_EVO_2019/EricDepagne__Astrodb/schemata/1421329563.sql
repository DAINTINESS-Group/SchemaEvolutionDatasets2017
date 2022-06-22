--
-- Name: stars; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stars (
    id bigint,
    name character varying NOT NULL,
    right_ascension double precision DEFAULT 0.0 NOT NULL,
    declination double precision DEFAULT 0.0 NOT NULL
);


--
-- Name: abundances; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE abundances (
    id integer NOT NULL,
    carbon double precision,
    oxygen double precision
);



--
-- Name: temperatures; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temperatures (
    id integer NOT NULL,
    temperature smallint
);


ALTER TABLE public.temperatures OWNER TO postgres;

--
-- Name: vr; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vr (
    id integer,
    vr double precision,
    observationdate double precision
);


A
--
-- Name: Stars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT "Stars_pkey" PRIMARY KEY (name);



--
-- PostgreSQL database dump complete
--

