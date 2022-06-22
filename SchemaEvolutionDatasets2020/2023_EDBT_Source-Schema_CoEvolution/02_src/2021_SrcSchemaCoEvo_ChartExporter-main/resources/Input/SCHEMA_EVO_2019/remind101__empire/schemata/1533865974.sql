--
-- PostgreSQL database dump
--


--
-- Name: apps; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE apps (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()),
    repo text,
    exposure text  NOT NULL,
    certs json,
    maintenance boolean DEFAULT false NOT NULL
);


--
-- Name: certificates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE certificates (
    id integer NOT NULL,
    app_id integer NOT NULL,
    name text,
    certificate_chain text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()),
    updated_at timestamp without time zone DEFAULT timezone('utc'::text, now())
);


--
-- Name: configs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE configs (
    id integer NOT NULL,
    app_id integer NOT NULL,
    vars hstore,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now())
);


--
-- Name: domains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE domains (
    id integer NOT NULL,
    app_id integer NOT NULL,
    hostname text NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now())
);


--
-- Name: ecs_environment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ecs_environment (
    id integer NOT NULL,
    environment json NOT NULL
);


--
-- Name: ports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ports (
    id integer NOT NULL,
    port integer,
    app_id integer,
    taken text
);


--
-- Name: releases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE releases (
    id integer NOT NULL,
    app_id integer NOT NULL,
    config_id integer NOT NULL,
    slug_id integer NOT NULL,
    version integer NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()),
    formation json NOT NULL
);


--
-- Name: scheduler_migration; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scheduler_migration (
    app_id text NOT NULL,
    backend text NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version integer NOT NULL
);


--
-- Name: slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE slugs (
    id integer NOT NULL,
    image text NOT NULL,
    procfile bytea NOT NULL
);


--
-- Name: stacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stacks (
    app_id text NOT NULL,
    stack_name text NOT NULL
);

