--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: user_config; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_config (
    id integer NOT NULL,
    type character varying(50),
    data character varying
);


ALTER TABLE public.user_config OWNER TO postgres;

--
-- Data for Name: user_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_config (id, type, data) FROM stdin;
1	exchanges	{"exchanges":{"settings":{"commission":1,"blockchain":{"guid":"1234"}},"plugins":{"current":{"ticker":"bitpay_ticker","trade":"bitstamp_trade","transfer":"blockchain"},"settings":{"bitpay_ticker":{},"bitstamp_trade":{"clientId":"","key":"","secret":""},"blockchain":{"guid":"","password":"","fromAddress":""}}}}}
\.


--
-- Name: user_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_config
    ADD CONSTRAINT user_config_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

