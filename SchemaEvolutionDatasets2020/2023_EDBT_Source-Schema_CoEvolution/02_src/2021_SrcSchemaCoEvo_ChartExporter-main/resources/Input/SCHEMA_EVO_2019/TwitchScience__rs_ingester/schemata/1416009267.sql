-- Initialize the postgres database

-- Locks while a load is being performed
CREATE TABLE load_batch (
    uuid        UUID PRIMARY KEY,       -- uuid for the manifest file name
    retry_ts    TIMESTAMP,              -- time to retry this load/check if it's stale
    retry_count INT DEFAULT 0,          -- number of times we've tried loading this batch
    last_error  VARCHAR                 -- the last error on this load; NULL if in progress
);

-- Individual files from the pipeline
CREATE TABLE pending_load (
    id          BIGSERIAL PRIMARY KEY,                 -- a unique ID for this load
    tablename   VARCHAR,                               -- the table name we're loading into
    keyname     VARCHAR,                               -- the s3 key of the TSV
    ts          TIMESTAMP,                             -- the time the SQS message was recieved
    batch_uuid    UUID REFERENCES load_batch(uuid)     -- if present, this load is in a batch
);
