CREATE SCHEMA IF NOT EXISTS url_shortener AUTHORIZATION clever;

CREATE TABLE IF NOT EXISTS "url_shortener" (
  slug VARCHAR(255) PRIMARY KEY,
  long_url VARCHAR(4000) NOT NULL,
  expires  timestamp without time zone,
  modified  timestamp without time zone
);
