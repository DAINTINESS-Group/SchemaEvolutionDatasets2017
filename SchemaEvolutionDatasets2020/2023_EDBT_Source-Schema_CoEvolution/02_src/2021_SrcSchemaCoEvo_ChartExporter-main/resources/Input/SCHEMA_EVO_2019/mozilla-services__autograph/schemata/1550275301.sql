CREATE TABLE endentities(
      id          SERIAL PRIMARY KEY,
      label       VARCHAR NOT NULL,
      hsm_handle  BIGINT NOT NULL,
      signer_id   VARCHAR NOT NULL,
      is_current  BOOLEAN NOT NULL,
      x5u         VARCHAR NULL,
      created_at  TIMESTAMP WITH TIME ZONE NOT NULL
);
CREATE INDEX endentities_latest_idx ON endentities(label, signer_id, is_current);
ALTER TABLE endentities ADD CONSTRAINT endentities_unique_label UNIQUE (label);

CREATE ROLE myautographdbuser;
ALTER ROLE myautographdbuser WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN PASSWORD 'myautographdbpassword';
GRANT SELECT, INSERT ON endentities TO myautographdbuser;
GRANT UPDATE (is_current) ON endentities TO myautographdbuser;
GRANT USAGE ON endentities_id_seq TO myautographdbuser;