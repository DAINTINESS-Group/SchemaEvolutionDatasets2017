--
-- channels in the system
--
DROP TABLE IF EXISTS t_channel;
CREATE TABLE t_channel (
   channel_name  VARCHAR(32) PRIMARY KEY NOT NULL
   ,domain_a     VARCHAR(100) NOT NULL
   ,domain_b     VARCHAR(100) NOT NULL
   ,contact      VARCHAR(255)
   -- bandwidth in Mb/s
   ,bandwidth    INTEGER
   ,state        VARCHAR(30)
   ,last_active  DATE
) TYPE=INNODB;

--
-- t_job contains the list of jobs currently in the transfer database.
--
DROP TABLE IF EXISTS t_job;
CREATE TABLE t_job (
  --
  -- the job_id is a IETF UUID in string form.
  job_id	            CHAR(36)  NOT NULL PRIMARY KEY
  --
  -- The state a job is currently in
  ,job_state		    VARCHAR(9) NOT NULL
  --
  -- transport specific parameters
  ,job_params           VARCHAR(250)
  --
  -- the DN of the user starting the job - they are the only one
  -- who can sumbit/cancel
  ,user_dn              TEXT NOT NULL
  --
  -- the DN of the agent currently servicing the job
  ,agent_dn             TEXT NOT NULL
  --
  -- the user credentials passphrase. This is passed to the movement service in
  -- order to retrieve the appropriate user proxy to do the transfers
  ,user_cred            VARCHAR(250)
  --
  -- the name of the transfer channel for this job
  ,channel_name         VARCHAR(32) REFERENCES t_channel(channel_name)
  ,reason		        VARCHAR(255)
  ,submit_time          DATE
) TYPE=INNODB;

--
-- t_file stores the actual file transfers - one row per source/dest pair
--
DROP TABLE IF EXISTS t_file;
CREATE TABLE t_file (
   --
   -- file_id is a unique identifier for a (source, destination) pair with a
   -- job.
   file_id		        INTEGER NOT NULL UNIQUE AUTO_INCREMENT
   --
   -- job_id (used in joins with file table)
   ,job_id              CHAR(36) NOT NULL
                        REFERENCES t_job(job_id)
   --
   -- the state of this file
   ,file_state		    VARCHAR(29) NOT NULL
   --
   -- The Source
   ,source_surl	        TEXT NOT NULL
   --
   -- The Destination
   ,dest_surl		    TEXT NOT NULL
   --
   -- The transport specific paramaters for the file transfer
  ,file_params		    VARCHAR(250)
  --
  -- The agent who is transferring the file. This is only valid when the file
  -- is in 'Active' state
  ,agent_dn		        TEXT
  ,reason		        VARCHAR(255)
  -- the time at which the file was transferred
  ,transfer_time        DATE
  -- the transfer duration in seconds
  ,duration 		    INTEGER,
  PRIMARY KEY (job_id, file_id),
  KEY(file_id)
) TYPE=INNODB;

--
-- t_logical stores the
--
DROP TABLE IF EXISTS t_logical;
CREATE TABLE t_logical (
  --
  -- the file_id index for this logical file
  file_id		        INTEGER NULL PRIMARY KEY
                        REFERENCES t_file(file_id)
  --
  -- job_id index for that file.
  ,job_id		        CHAR(36) NOT NULL
                        REFERENCES t_job(job_id)
  --
  -- The generalised logical Source
  ,source	            TEXT NOT NULL
  --
  -- The Destination Surl or logical destination site
  ,destination		    TEXT NOT NULL
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
	job_id 	            CHAR(36) NOT NULL
	,file_id 	        INTEGER
	,job_state	        VARCHAR(9)
	,file_state	        VARCHAR(9)
	,timestamp	        DATE
	,dn                 TEXT
) TYPE=INNODB;


-- Schema version

DROP TABLE IF EXISTS t_schema_vers;
CREATE TABLE t_schema_vers (
  major INTEGER NOT NULL,
  minor INTEGER NOT NULL,
  patch INTEGER NOT NULL
) TYPE=INNODB;
