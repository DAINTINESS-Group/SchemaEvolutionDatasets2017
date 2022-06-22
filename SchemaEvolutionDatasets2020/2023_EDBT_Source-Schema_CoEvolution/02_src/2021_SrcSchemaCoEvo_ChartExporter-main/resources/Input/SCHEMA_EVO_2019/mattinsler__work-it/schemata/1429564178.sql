CREATE DATABASE tasks;

GRANT ALL ON tasks.* TO 'read-write'@'%' IDENTIFIED BY '8fdc21e776def2471015f6fcfc0663c942c7b18e593a4b955d30a208c837c32a';

CREATE TABLE tasks (
  id BINARY(16) NOT NULL PRIMARY KEY,
  
  data TEXT NOT NULL,
  
  queue VARCHAR(32) NOT NULL,
  retry_queue VARCHAR(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE executions (
  task_id BINARY(16) NOT NULL,
  execution_id BIGINT NOT NULL,
  
  queued_at BIGINT,
  started_at BIGINT,
  finished_at BIGINT,
  
  failed_count SMALLINT DEFAULT 0,
  reaped_count SMALLINT DEFAULT 0,
  
  success BOOL,
  error_id BINARY(32), -- SHA256 hash of error text
  
  PRIMARY KEY (task_id, execution_id),
  CONSTRAINT fk_executions_task_id FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE task_tags (
  id VARCHAR(64) NOT NULL,
  task_id BINARY(16) NOT NULL,
  
  PRIMARY KEY (id, task_id),
  CONSTRAINT fk_task_tags_task_id FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE execution_errors (
  id BINARY(32) NOT NULL PRIMARY KEY, -- SHA256 hash of error text
  error TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE OR REPLACE VIEW task_executions AS
  SELECT
    t.id as task_id, t.data, t.queue, t.retry_queue,
    ex.execution_id, ex.queued_at, ex.started_at, ex.finished_at, ex.failed_count, ex.reaped_count, ex.success,
    er.error
  FROM tasks t
    JOIN executions ex ON (ex.task_id = t.id)
    LEFT JOIN execution_errors er ON (er.id = ex.error_id);
