CREATE TABLE magnitudes (
    id integer NOT NULL,
    star_id integer,
    u real,
    b real,
    v real,
    r real,
    i real
);



--
-- Name: names; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE names (
    id integer NOT NULL,
    star_id integer,
    alternatename character varying
);



--
-- Name: stars; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE stars (
    name character varying NOT NULL,
    right_ascension double precision,
    declination double precision,
    id integer NOT NULL
);



--
-- Name: temperatures; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temperatures (
    star_id integer,
    temperature integer,
    id integer NOT NULL
);


--
-- Name: magnitudes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY magnitudes
    ADD CONSTRAINT magnitudes_pkey PRIMARY KEY (id);


--
-- Name: names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (id);


--
-- Name: stars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: temperatures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY temperatures
    ADD CONSTRAINT temperatures_pkey PRIMARY KEY (id);






--

