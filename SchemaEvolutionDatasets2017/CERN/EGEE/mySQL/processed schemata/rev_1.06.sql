--
-- channels in the system
--
DROP TABLE IF EXISTS t_channel;
CREATE TABLE t_channel (
--
-- Name of the channel
   channel_name     	VARCHAR(32) PRIMARY KEY NOT NULL
--
-- Close domain name: "cern.ch"
   ,domain_a        	VARCHAR(100) NOT NULL
--
-- Far domain name: "rl.ac.uk"
   ,domain_b        	VARCHAR(100) NOT NULL
--
-- Email contact of the channel responsbile
   ,contact         	VARCHAR(255)
--
-- Maximum bandwidth, capacity, in Mbits/s
   ,bandwidth       	INTEGER
--
-- The target number of concurrent streams on the network
   ,nostreams       	INTEGER
--
-- The target number of concurrent files on the network
   ,nofiles       	INTEGER
--
-- The target throughput for the system (Mbits/s)
   ,nominal_throughput	INTEGER
--
-- The state of the channel ("Active", "Inactive", "Drain", "Stopped")
   ,state		        VARCHAR(30)
--
-- The date the channel was last active
   ,last_active		    DATETIME
) TYPE=INNODB;

--
-- t_job contains the list of jobs currently in the transfer database.
--
DROP TABLE IF EXISTS t_job;
CREATE TABLE t_job (
--
-- the job_id is a IETF UUID in string form.
   job_id		        CHAR(36) NOT NULL PRIMARY KEY
--
-- The state a job is currently in
   ,job_state       	VARCHAR(13) NOT NULL
--
-- Transport specific parameters
  ,job_params       	VARCHAR(250)
--
-- the DN of the user starting the job - they are the only one
-- who can sumbit/cancel
  ,user_dn          	TEXT NOT NULL
--
-- the DN of the agent currently servicing the job
  ,agent_dn         	TEXT NOT NULL
--
-- the user credentials passphrase. This is passed to the movement service in
-- order to retrieve the appropriate user proxy to do the transfers
  ,user_cred        	VARCHAR(250)
--
-- Blob to store user capabilites and groups
  ,voms_cred            BLOB
--
-- the name of the transfer channel for this job
  ,channel_name     	VARCHAR(32)
                    	REFERENCES t_channel(channel_name)
--
-- The reason the job is in the current state
  ,reason           	VARCHAR(255)
--
-- The date that the job was submitted
  ,submit_time      	DATETIME
) TYPE=INNODB;

--
-- t_file stores the actual file transfers - one row per source/dest pair
--
DROP TABLE IF EXISTS t_file;
CREATE TABLE t_file (
-- file_id is a unique identifier for a (source, destination) pair with a
-- job.  It is created automatically.
--
  file_id		        INTEGER NOT NULL UNIQUE
--
-- job_id (used in joins with file table)
   ,job_id		        CHAR(36) NOT NULL
                    	REFERENCES t_job(job_id)
--
-- The state of this file
  ,file_state		    VARCHAR(29) NOT NULL
--
-- The Source
  ,source_surl      	TEXT NOT NULL
--
-- The Destination
  ,dest_surl		    TEXT NOT NULL
--
-- File params - deprecated; only for backwards compatibility. Will be removed in next major update.
  ,file_params		    VARCHAR(255)
--
-- The agent who is transferring the file. This is only valid when the file
-- is in 'Active' state
  ,agent_dn		        TEXT
--
-- Number of retries this file has had (0 for first attempt)
  ,num_retries		INTEGER
-- 
-- The class for the reason field
  ,reason_class		VARCHAR(32)
--
-- The reason the file is in this state
  ,reason           	VARCHAR(255)
--
-- the time at which the file was transferred
  ,transfer_time    	DATETIME
--
-- the transfer duration in seconds
  ,duration         	FLOAT
--
-- the number of bytes written to the destination
  ,bytes_written    	BIGINT
--
-- the nominal size of the file (bytes)
  ,filesize         	BIGINT
--
-- the user-defined checksum of the file "checksum_type:checksum"
  ,checksum         	VARCHAR(100)
--
  ,PRIMARY KEY (job_id, file_id),
   KEY(file_id)
) TYPE=INNODB;

CREATE INDEX file_job_id ON t_file(job_id);
CREATE INDEX file_state ON t_file(file_state);
-- index up to 1000 for >MySQL 4.1.20
CREATE INDEX file_source_surl ON t_file(source_surl(255));

--
-- Schema version
--
DROP TABLE IF EXISTS t_schema_vers;
CREATE TABLE t_schema_vers (
  major INTEGER NOT NULL,
  minor INTEGER NOT NULL,
  patch INTEGER NOT NULL
) TYPE=INNODB;
INSERT INTO t_schema_vers (major,minor,patch) VALUES (1,3,0);
