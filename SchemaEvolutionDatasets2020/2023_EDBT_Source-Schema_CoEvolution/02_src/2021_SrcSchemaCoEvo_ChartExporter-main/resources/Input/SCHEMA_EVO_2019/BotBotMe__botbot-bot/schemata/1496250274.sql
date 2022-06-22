-- pg_dump --schema-only --no-owner --table bots_chatbot --table bots_channel --table bots_usercount botbot > sql/schema.sql
--
-- PostgreSQL database dump
--

--
-- Name: bots_channel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bots_channel (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    name character varying(250) NOT NULL,
    slug character varying(50) NOT NULL,
    private_slug character varying(50),
    password character varying(250),
    is_public boolean NOT NULL,
    is_featured boolean NOT NULL,
    fingerprint character varying(36),
    public_kudos boolean NOT NULL,
    notes text NOT NULL,
    chatbot_id integer NOT NULL,
    status character varying(20) NOT NULL
);


--
-- Name: bots_chatbot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bots_chatbot (
    id integer NOT NULL,
    is_active boolean NOT NULL,
    server character varying(100) NOT NULL,
    server_password character varying(100),
    server_identifier character varying(164) NOT NULL,
    nick character varying(64) NOT NULL,
    password character varying(100),
    real_name character varying(250) NOT NULL,
    slug character varying(50) NOT NULL,
    max_channels integer NOT NULL
);


--
-- Name: bots_usercount; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE bots_usercount (
    id integer NOT NULL,
    dt date NOT NULL,
    counts integer[],
    channel_id integer NOT NULL
);


--
-- Name: bots_channel bots_channel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bots_channel
    ADD CONSTRAINT bots_channel_pkey PRIMARY KEY (id);


--
-- Name: bots_chatbot bots_chatbot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bots_chatbot
    ADD CONSTRAINT bots_chatbot_pkey PRIMARY KEY (id);


--
-- Name: bots_usercount bots_usercount_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY bots_usercount
    ADD CONSTRAINT bots_usercount_pkey PRIMARY KEY (id);

