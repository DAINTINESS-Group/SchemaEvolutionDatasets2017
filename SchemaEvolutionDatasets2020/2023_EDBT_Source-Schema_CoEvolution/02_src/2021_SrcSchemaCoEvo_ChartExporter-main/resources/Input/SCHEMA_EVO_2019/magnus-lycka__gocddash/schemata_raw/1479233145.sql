CREATE TABLE IF NOT EXISTS pipeline (
    pipeline_name TEXT NOT NULL PRIMARY KEY,
    pipeline_group TEXT NOT NULL,
    sync INTEGER CHECK (sync IN (0, 1)),
    log_parser TEXT,
    email_notifications INTEGER CHECK (email_notifications IN (0, 1))
);


CREATE TABLE IF NOT EXISTS pipeline_sync_rule (
    id INTEGER NOT NULL PRIMARY KEY,
    kind TEXT NOT NULL DEFAULT 're',
    pipeline_groups_field TEXT NOT NULL DEFAULT 'pipelines.name',
    pattern TEXT NOT NULL,
    sync INTEGER NOT NULL CHECK (sync IN (0, 1)) DEFAULT 0,
    log_parser TEXT,
    email_notifications INTEGER NOT NULL CHECK (email_notifications IN (0, 1)) DEFAULT 0,
    UNIQUE (kind, pipeline_groups_field, pattern)
);


INSERT OR IGNORE INTO pipeline_sync_rule
    (pattern, sync, log_parser, email_notifications)
    VALUES
    ('characterize', 1, 'characterize', 0);


INSERT OR IGNORE INTO pipeline_sync_rule
    (pattern, sync, log_parser, email_notifications)
    VALUES
    ('.', 1, 'junit', 0);


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
    done INTEGER CHECK (done IN (0, 1)),
    UNIQUE (pipeline_name, pipeline_counter),
    FOREIGN KEY(pipeline_name) REFERENCES pipeline(pipeline_name)
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
    failure_stage TEXT,
    UNIQUE (instance_id, name, stage_counter),
    FOREIGN KEY(instance_id) REFERENCES pipeline_instance(id)
-- Use natural key?
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
-- Adapt to parent natural key
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
-- Adapt to parent natural key
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
-- Adapt to parent natural key
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


-- Replace with column in stage
-- CREATE VIEW IF NOT EXISTS final_stages AS
--     SELECT s.*
--     FROM stage s
--     INNER JOIN (
--         SELECT instance_id, max(stage_counter) as stage_counter, name
--         FROM stage
--         GROUP BY instance_id, name
--     ) sa
--     ON s.instance_id = sa.instance_id AND
--        s.stage_counter = sa.stage_counter AND
--        s.name = sa.name;


CREATE VIEW IF NOT EXISTS final_stages AS
   SELECT s.*
   FROM stage s
   LEFT OUTER JOIN stage sa
   ON s.name = sa.name AND
      s.instance_id = sa.instance_id AND
      s.stage_counter < sa.stage_counter
   WHERE sa.stage_counter IS NULL;


-- replace with column in pipeline_instance
CREATE VIEW IF NOT EXISTS run_outcomes AS
    SELECT pi.*, outcome
    FROM pipeline_instance pi
    JOIN (
        SELECT instance_id, min(result) as outcome
        FROM final_stages f
        JOIN pipeline_instance p
        ON f.instance_id = p.id
        GROUP BY instance_id
    ) px
    ON px.instance_id = pi.id
    ORDER BY pipeline_counter DESC;


-- Replace with columns in pipeline_instance
CREATE VIEW IF NOT EXISTS latest_intervals AS
    WITH max_failing as (
        SELECT pipeline_name, max(pipeline_counter) as fail_counter
        FROM run_outcomes
        WHERE outcome = 'Failed'
        GROUP BY pipeline_name
    ), max_passing as (
        SELECT pipeline_name, max(pipeline_counter) as pass_counter
        FROM run_outcomes
        WHERE outcome = 'Passed'
        GROUP BY pipeline_name
    )
    SELECT mf.pipeline_name, fail_counter, pass_counter, (fail_counter < pass_counter) as currently_passing
    FROM max_failing mf
    LEFT OUTER JOIN max_passing ms
    ON mf.pipeline_name = ms.pipeline_name;


CREATE VIEW IF NOT EXISTS active_claims AS
    SELECT i.id, i.pipeline_name, i.pipeline_counter, i.responsible, i.description
    FROM instance_claim i
    JOIN (
        SELECT pipeline_name, max(pipeline_counter) as max_pipeline_counter
        FROM instance_claim
        GROUP BY pipeline_name
    ) ia
    ON i.pipeline_name = ia.pipeline_name AND i.pipeline_counter = ia.max_pipeline_counter
    JOIN (
        SELECT l.*, p.pipeline_counter as current_pipeline
        FROM latest_intervals l
        JOIN (
            SELECT pipeline_name, max(pipeline_counter) AS pipeline_counter
            FROM pipeline_instance pi
            JOIN stage s ON pi.id = s.instance_id
            GROUP BY pipeline_name
        ) p
        ON l.pipeline_name = p.pipeline_name
        WHERE currently_passing = 0
    ) lf
    ON i.pipeline_name = lf.pipeline_name AND
        lf.pass_counter < i.pipeline_counter AND
        i.pipeline_counter <= lf.current_pipeline;


CREATE VIEW IF NOT EXISTS failure_info AS
    SELECT p.pipeline_name, p.pipeline_counter, s.stage_counter, s.id, s.name as stage_name,
           p.trigger_message, s.approved_by, s.result, f.failure_stage, ac.responsible,
           ac.description, s.scheduled_date
    FROM pipeline_instance p
    JOIN stage s ON s.instance_id = p.id
    LEFT JOIN failure_information f ON f.stage_id = s.id
    LEFT JOIN active_claims ac ON ac.pipeline_name = p.pipeline_name AND
              ac.pipeline_counter <= p.pipeline_counter
    WHERE s.result <> 'Cancelled'
    ORDER BY p.pipeline_counter DESC, s.stage_counter DESC;


CREATE VIEW IF NOT EXISTS graph_statistics AS
    SELECT p.pipeline_name, p.pipeline_counter, s.stage_counter, s.name as stage_name,
           s.result as stage_result, j.name as job_name, j.scheduled_date, j.result as job_result,
           f.failure_stage, a.agent_name, j.tests_run, j.tests_failed, j.tests_skipped
    FROM pipeline_instance p
    JOIN stage s ON s.instance_id = p.id
    JOIN job j ON j.stage_id = s.id
    JOIN agent a ON a.id = j.agent_uuid
    LEFT JOIN failure_information f ON f.stage_id = s.id;


CREATE VIEW IF NOT EXISTS graph_statistics_final_stages AS
    SELECT p.pipeline_name, p.pipeline_counter, s.stage_counter, s.name as stage_name,
           s.result as stage_result, j.name as job_name, j.scheduled_date, j.result as job_result,
           f.failure_stage, a.agent_name, j.tests_run, j.tests_failed, j.tests_skipped
    FROM pipeline_instance p
    JOIN final_stages s ON s.instance_id = p.id
    JOIN job j ON j.stage_id = s.id
    JOIN agent a ON a.id = j.agent_uuid
    LEFT JOIN failure_information f ON f.stage_id = s.id;
