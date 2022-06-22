-- db schema 
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

-- Name: user_config; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
CREATE TABLE user_config (
    id integer NOT NULL,
    type character varying(50),
    data character varying
);
ALTER TABLE ONLY user_config ADD CONSTRAINT user_config_pkey PRIMARY KEY (id);

COPY user_config (id, type, data) FROM stdin;
1	exchanges	{"exchanges" : {\
    "settings": {\
      "commission": 1.0\
    },\
    "plugins" : {\
      "current": {\
        "ticker": "bitpay",\
        "trade": "bitstamp",\
        "transfer": "blockchain"\
      },\
      "settings": {\
        "bitpay": {},\
        "bitstamp": {"currency": "USD", "key": "test", "secret": "test", "clientId": "test" },\
        "blockchain" : {}\
      }\
    }\
  }\
}
\.

COPY user_config (id, type, data) FROM stdin;
2	software	{"brain": {\
    "qrTimeout": 60000,\
    "goodbyeTimeout": 2000,\
    "billTimeout": 60000,\
    "completedTimeout": 60000,\
    "networkTimeout": 20000,\
    "triggerRetry": 5000,\
    "idleTime": 600000,\
    "checkIdleTime": 60000,\
    "maxProcessSize": 104857600,\
    "freeMemRatio": 0.15\
  },\
  "updater": {\
    "caFile": "/usr/local/share/sencha/certs/lamassu.pem",\
    "certFile": "/usr/local/share/sencha/keys/client.pem",\
    "keyFile": "/usr/local/share/sencha/keys/client.key",\
    "port": 8000,\
    "host": "updates.lamassu.is",\
    "downloadDir": "/tmp/download",\
    "extractDir": "/tmp/extract",\
    "updateInterval": 30000,\
    "deathInterval": 600000,\
    "extractor": {\
      "lamassuPubKeyFile": "/usr/local/share/sencha/pubkeys/lamassu.pub.key",\
      "sigAlg": "RSA-SHA256",\
      "hashAlg": "sha256"\
    }\
  },\
  "exchanges": {\
    "settings": {\
      "fastPoll": 5000,\
      "fastPollLimit": 10,\
      "tickerInterval": 5000,\
      "balanceInterval": 5000,\
      "tradeInterval": 5000,\
      "retryInterval": 5000,\
      "retries": 3,\
      "lowBalanceMargin": 1.05,\
      "transactionFee": 10000,\
      "tickerDelta": 0,\
      "minimumTradeFiat": 0\
    },\
    "plugins": {\
      "settings": {\
        "blockchain": {\
          "retryInterval": 10000,\
          "retryTimeout": 60000\
        }\
      }\
    }\
  }\
}
\.

COPY user_config (id, type, data) FROM stdin;
3	unit	{ "brain": {\
    "unit": {\
      "ssn": "xx-1234-45",\
      "owner": "Lamassu, Inc. / Trofa / Portugal"\
    },\
    "locale": {\
      "currency": "USD",\
      "localeInfo": {\
        "primaryLocale": "en-US",\
        "primaryLocales": ["en-US"]\
      }\
    }\
  }\
}
\.


-- Name: txlog ; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
CREATE TABLE txlog (
    id SERIAL,
    timestamp timestamp,
    type character varying(10),
    exchange character varying(50),
    address character varying(50),
    satoshis integer not null,
    currency character varying(10),
    rate float,
    status character varying(20),
    errorMessage character varying
);

ALTER TABLE ONLY txlog ADD CONSTRAINT txlog_pkey PRIMARY KEY (id);

CREATE TABLE devices (
    id SERIAL,
    fingerprint character varying(59) not null unique,
    name character varying,
    authorized boolean
);

ALTER TABLE ONLY devices ADD CONSTRAINT devices_pkey PRIMARY KEY (id);

CREATE TABLE pairing_tokens (
    id SERIAL,
    token character varying(64),
    created bigint
);

ALTER TABLE ONLY pairing_tokens ADD CONSTRAINT pairing_tokens_pkey PRIMARY KEY (id);


-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
CREATE TABLE users (
    id SERIAL,
    userName character varying(20) not null,
    salt character varying(180) not null,
    pwdHash character varying(512) not null
);

ALTER TABLE ONLY users ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY users ADD CONSTRAINT userName_unique UNIQUE (userName);
