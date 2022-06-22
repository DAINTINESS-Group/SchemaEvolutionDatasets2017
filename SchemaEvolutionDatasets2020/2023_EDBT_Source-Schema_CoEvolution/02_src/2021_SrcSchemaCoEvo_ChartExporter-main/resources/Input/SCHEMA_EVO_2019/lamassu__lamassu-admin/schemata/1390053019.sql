-- db schema 
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE ROLE postgres LOGIN INHERIT;

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
ALTER TABLE public.user_config OWNER TO postgres;
ALTER TABLE ONLY user_config ADD CONSTRAINT user_config_pkey PRIMARY KEY (id);

COPY user_config (id, type, data) FROM stdin;
1	exchanges	{"exchanges":{"settings":{"commission":1,"blockchain":{"guid":"1234"}},"plugins":{"current":{"ticker":"bitpay_ticker","trade":"bitstamp_trade","transfer":"blockchain"},"settings":{"bitpay_ticker":{},"bitstamp_trade":{"clientId":"","key":"","secret":""},"blockchain":{"guid":"","password":"","fromAddress":""}}}}}
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
      "tickerInterval": 60000,\
      "balanceInterval": 60000,\
      "tradeInterval": 10000,\
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
    id integer NOT NULL,
    timestamp timestamp,
    exchange character varying(50),
    address character varying(50),
    satoshis integer not null,
    status integer not null,
    errorMessage character varying
);

-- ALTER TABLE public.txlog OWNER TO postgres;
ALTER TABLE ONLY txlog ADD CONSTRAINT txlog_pkey PRIMARY KEY (id);
ALTER TABLE public.txlog OWNER TO postgres;

-- Name: public; Type: ACL; Schema: -; Owner: postgres
REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


