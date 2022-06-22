CREATE TABLE IF NOT EXISTS pipeline (
    pipeline_name TEXT NOT NULL PRIMARY KEY,
    pipeline_group TEXT NOT NULL,
    sync INTEGER CHECK (sync IN (0, 1)),
    log_parser TEXT,
    email_notifications INTEGER 
);


CREATE TABLE IF NOT EXISTS pipeline_sync_rule (
    id INTEGER NOT NULL PRIMARY KEY,
    kind TEXT NOT NULL DEFAULT 're',
    pipeline_groups_field TEXT NOT NULL DEFAULT 'pipelines.name',
    pattern TEXT NOT NULL,
    sync INTEGER NOT NULL CHECK (sync IN (0, 1)) DEFAULT 0,
    log_parser TEXT,
    email_notifications INTEGER NOT NULL  DEFAULT 0
);

CREATE TABLE IF NOT EXISTS pipeline_instance(
    id INTEGER NOT NULL PRIMARY KEY,
    pipeline_name TEXT NOT NULL,
    pipeline_counter INTEGER NOT NULL,
    trigger_message TEXT
    outcome TEXT,
    claimant TEXT,
    claim_text TEXT,
    email_sent DATETIME,
    fail_counter INTEGER,
    pass_counter INTEGER,
    currently_passing INTEGER NOT NULL CHECK (currently_passing IN (0, 1)) DEFAULT 0,
    done INTEGER CHECK (done IN (0, 1))
);


CREATE TABLE IF NOT EXISTS stage(
    id INTEGER NOT NULL PRIMARY KEY,
    instance_id INTEGER NOT NULL,
    stage_counter INTEGER NOT NULL,
    name TEXT NOT NULL,
    approved_by TEXT,
    scheduled_date DATETIME,
    result TEXT,
    final INTEGER NOT NULL CHECK (final IN (0, 1)) DEFAULT 0,
    failure_stage TEXT

);


CREATE TABLE IF NOT EXISTS job(
    id INTEGER NOT NULL PRIMARY KEY,
    stage_id INTEGER,
    name TEXT,
    agent_uuid TEXT,
    scheduled_date DATETIME,
    result TEXT,
    tests_run INTEGER,
    tests_failed INTEGER,
    tests_skipped INTEGER,
    FOREIGN KEY(agent_uuid) REFERENCES agent(id),
    FOREIGN KEY(stage_id) REFERENCES stage(id)
);


CREATE TABLE IF NOT EXISTS agent(
    id TEXT NOT NULL PRIMARY KEY,
    agent_name TEXT
);


CREATE TABLE IF NOT EXISTS texttest_failure(
    id INTEGER PRIMARY KEY,
    stage_id INTEGER,
    test_index INTEGER,
    failure_type TEXT,
    document_name TEXT
);


-- Replace with column in stage
CREATE TABLE IF NOT EXISTS failure_information(
    id INTEGER PRIMARY KEY,
    stage_id INTEGER,
    failure_stage TEXT
);


CREATE TABLE IF NOT EXISTS junit_failure(
    id INTEGER PRIMARY KEY,
    stage_id INTEGER,
    failure_type TEXT,
    failure_test TEXT
);
-- Perhaps merge X_failure tables?


-- Replace with columns in pipeline_instance
CREATE TABLE IF NOT EXISTS instance_claim(
    id INTEGER PRIMARY KEY,
    pipeline_name TEXT,
    pipeline_counter INTEGER,
    responsible TEXT,
    description TEXT
);


-- Replace with column in pipeline_instance
CREATE TABLE IF NOT EXISTS email_notifications(
    id INTEGER PRIMARY KEY,
    pipeline_name TEXT,
    pipeline_counter INTEGER,
    sent DATETIME
);

