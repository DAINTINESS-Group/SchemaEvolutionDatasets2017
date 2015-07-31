--
-- t_job contains the list of jobs currently in the transfer database.
--
DROP TABLE IF EXISTS t_job;
CREATE TABLE t_job (
  job_id	        CHAR(36)  NOT NULL PRIMARY KEY
  ,job_state		VARCHAR(9) NOT NULL
  ,job_params           VARCHAR(250)
  ,user_dn              TEXT NOT NULL
  ,user_cred            VARCHAR(250)
  ,reason		VARCHAR(255)
) TYPE=INNODB;

--
-- t_file stores the actual file transfers - one row per source/dest pair
--
DROP TABLE IF EXISTS t_file;
CREATE TABLE t_file (
-- file_id is a unique identifier for a (source, destination) pair with a
-- job.
--
  file_id		INTEGER NOT NULL UNIQUE AUTO_INCREMENT
 -- job_id (used in joins with file table
   ,job_id		CHAR(36) 
                        NOT NULL
                        REFERENCES t_job(job_id)
 -- the state of this file
  ,file_state		VARCHAR(29) 
                        NOT NULL
 -- The Source
  ,source_surl	        TEXT
                        NOT NULL
 -- The Destination
  ,dest_surl		TEXT 
                        NOT NULL
 -- The transport specific paramaters for the file transfer
  ,file_params		VARCHAR(250)
-- The agent who is transferring the file. This is only valid when the file
-- is in 'Active' state
  ,agent_dn		TEXT
  ,reason		VARCHAR(255)
-- why it failed
  ,duration 		INTEGER,
  PRIMARY KEY (job_id, file_id),
  KEY(file_id)
) TYPE=INNODB;


DROP TABLE IF EXISTS t_logical;
CREATE TABLE t_logical (
--
  file_id		INTEGER NULL PRIMARY KEY
                REFERENCES t_file(file_id)
-- job_id 
   ,job_id		CHAR(36)
                        NOT NULL
                        REFERENCES t_job(job_id)
 -- The generalised Source
  ,source	        TEXT NOT NULL
 -- The Destination Surl or Site
  ,destination		TEXT NOT NULL
) TYPE=INNODB;

DROP TABLE IF EXISTS t_channel;
CREATE TABLE t_channel (
   name         VARCHAR(255)
   ,domain_a     VARCHAR(100)
   ,domain_b     VARCHAR(100)
   ,contact      VARCHAR(255)
   ,bandwidth    INTEGER
   ,state        VARCHAR(30)
) TYPE=INNODB;


CREATE INDEX file_job_id ON t_file(job_id);
CREATE INDEX file_state ON t_file(file_state);
-- index up to 1000 for >MySQL 4.1.20
CREATE INDEX file_source_surl ON t_file(source_surl(255));


--
-- A logging table which tracks interactions with the t_job and t_file table
--
DROP TABLE IF EXISTS t_job_log;
CREATE TABLE t_job_log (
	job_id 	        CHAR(36) 
                        NOT NULL
	,file_id 	INTEGER
	,job_state	VARCHAR(9)
	,file_state	VARCHAR(9)
	,timestamp	DATE
	,dn             TEXT
) TYPE=INNODB;


-- Schema version

DROP TABLE IF EXISTS t_schema_vers;
CREATE TABLE t_schema_vers (
  major INTEGER NOT NULL,
  minor INTEGER NOT NULL,
  patch INTEGER NOT NULL
) TYPE=INNODB;
