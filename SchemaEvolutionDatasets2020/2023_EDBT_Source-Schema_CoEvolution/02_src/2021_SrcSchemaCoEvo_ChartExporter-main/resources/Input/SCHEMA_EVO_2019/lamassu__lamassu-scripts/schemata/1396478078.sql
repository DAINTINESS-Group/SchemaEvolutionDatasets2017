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
  id serial PRIMARY KEY,
  type text NOT NULL,
  data json NOT NULL
);

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
      "minimumTradeFiat": 0,\
      "compliance": {\
        "maximum": {\
          "limit": null\
        }\
      }\
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

CREATE TABLE devices (
  id serial PRIMARY KEY,
  fingerprint text NOT NULL UNIQUE,
  name text,
  authorized boolean
);

CREATE TABLE pairing_tokens (
  id serial PRIMARY KEY,
  token text,
  created timestamp NOT NULL DEFAULT now()
);

CREATE TABLE transactions (
  id uuid PRIMARY KEY,
  status text NOT NULL,
  txHash text,
  deviceId integer REFERENCES devices ON DELETE RESTRICT,
  toAddress text NOT NULL,
  satoshis integer,
  currencyCode text,
  fiat decimal,
  rate decimal,
  error text,
  created timestamp NOT NULL DEFAULT now(),
  completed timestamp
);

-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
CREATE TABLE users (
  id serial PRIMARY KEY,
  userName text NOT NULL UNIQUE,
  salt text NOT NULL,
  pwdHash text NOT NULL
);
