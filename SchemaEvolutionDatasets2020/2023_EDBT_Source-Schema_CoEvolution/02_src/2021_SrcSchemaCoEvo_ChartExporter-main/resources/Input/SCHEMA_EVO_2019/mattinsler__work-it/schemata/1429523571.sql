CREATE DATABASE tasks;

GRANT ALL ON tasks.* TO 'root'@'%' IDENTIFIED BY 'password';

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
  error TEXT,
  
  PRIMARY KEY (task_id, execution_id),
  CONSTRAINT fk_executions_task_id FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE task_tags (
  id VARCHAR(64) NOT NULL,
  task_id BINARY(16) NOT NULL,
  
  PRIMARY KEY (id, task_id),
  CONSTRAINT fk_task_tags_task_id FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
