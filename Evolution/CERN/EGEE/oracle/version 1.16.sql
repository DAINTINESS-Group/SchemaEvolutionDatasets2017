--
-- channels in the system
--
DROP TABLE t_channel CASCADE CONSTRAINTS;
CREATE TABLE t_channel (
--
-- Name of the channel
   channel_name     	VARCHAR2(32)
                    	CONSTRAINT channel_channel_name_not_null NOT NULL
                    	CONSTRAINT channel_channel_name_id_pk PRIMARY KEY
		        USING INDEX TABLESPACE &1
--
-- Close domain name: "cern.ch"
   ,domain_a        	VARCHAR2(100)
			CONSTRAINT channel_domain_a_not_null NOT NULL
--
-- Far domain name: "rl.ac.uk"
   ,domain_b        	VARCHAR2(100)
	                CONSTRAINT channel_domain_b_not_null NOT NULL
--
-- Email contact of the channel responsbile
   ,contact         	VARCHAR2(255)
--
-- Maximum bandwidth, capacity, in Mbits/s
   ,bandwidth       	NUMBER
--
-- The target number of concurrent streams on the network
   ,nostreams       	INTEGER
--
-- The target number of concurrent files on the network
   ,nofiles       	    INTEGER
--
-- The target throughput for the system (Mbits/s)
   ,nominal_throughput	NUMBER
--
-- The state of the channel ("Active", "Inactive", "Drain", "Stopped")
   ,state		VARCHAR2(30)
--
-- The time the channel was last active
   ,last_active		TIMESTAMP(0)
);

--
-- t_job contains the list of jobs currently in the transfer database.
--
DROP TABLE t_job CASCADE CONSTRAINTS;
CREATE TABLE t_job (
--
-- the job_id is a IETF UUID in string form.  
   job_id		CHAR(36)
                    	CONSTRAINT job_job_id_not_null NOT NULL
                    	CONSTRAINT job_job_id_pk PRIMARY KEY
                        USING INDEX TABLESPACE &1
--
-- The state a job is currently in
   ,job_state       	VARCHAR2(9)
                    	CONSTRAINT job_job_state_not_null NOT NULL
--
-- Transport specific parameters
  ,job_params       	VARCHAR2(250)
--
-- the DN of the user starting the job - they are the only one
-- who can sumbit/cancel
  ,user_dn          	VARCHAR2(1024)
                    	CONSTRAINT job_user_dn_not_null NOT NULL
--
-- the DN of the agent currently servicing the job
  ,agent_dn         	VARCHAR2(1024)
--
-- the user credentials passphrase. This is passed to the movement service in
-- order to retrieve the appropriate user proxy to do the transfers
  ,user_cred        	VARCHAR2(250)
--
-- Blob to store user capabilites and groups
  ,voms_cred            BLOB 
--
-- the name of the transfer channel for this job
  ,channel_name     	VARCHAR2(32)
                    	REFERENCES t_channel(channel_name)
--
-- The reason the job is in the current state
  ,reason           	VARCHAR2(1024)
--
-- The time that the job was submitted
  ,submit_time      	TIMESTAMP(0) DEFAULT SYSTIMESTAMP
);

--
-- t_file stores the actual file transfers - one row per source/dest pair
--
DROP TABLE t_file CASCADE CONSTRAINTS;
CREATE TABLE t_file (
-- file_id is a unique identifier for a (source, destination) pair with a
-- job.  It is created automatically.
--
  file_id		INTEGER
			CONSTRAINT file_file_id_not_null NOT NULL
		        -- JC next constraint is actually too strict!
		        CONSTRAINT file_file_id_unique PRIMARY KEY
                        USING INDEX TABLESPACE &1
--
-- job_id (used in joins with file table)
   ,job_id		CHAR(36)
                    	CONSTRAINT file_job_id_not_null NOT NULL
                    	REFERENCES t_job(job_id)
--
-- The state of this file
  ,file_state		VARCHAR2(29)
                    	CONSTRAINT file_state_not_null NOT NULL
--
-- The Source
  ,source_surl      	VARCHAR2(1100)
                    	CONSTRAINT file_source_surl_not_null NOT NULL
--
-- The Destination
  ,dest_surl		VARCHAR2(1100)
                    	CONSTRAINT file_dest_surl_not_null NOT NULL
--
-- The agent who is transferring the file. This is only valid when the file
-- is in 'Active' state
  ,agent_dn		VARCHAR2(1024)
--
-- Number of retries this file has had (0 for first attempt)
  ,num_retries		INTEGER
--
-- The class for the reason field
  ,reason_class		VARCHAR2(32)
--
-- The reason the file is in this state
  ,reason           	VARCHAR2(1024)
--
-- the time at which the file was transferred
  ,transfer_time    	TIMESTAMP(0)
--
-- the transfer duration in seconds
  ,duration         	NUMBER
--
-- the number of bytes written to the destination
  ,bytes_written    	INTEGER
--
-- the nominal size of the file (bytes)
  ,filesize         	INTEGER
--
-- the user-defined checksum of the file "checksum_type:checksum"
  ,checksum         	VARCHAR2(100)
);

--
-- autoinc sequence on file_id
--
DROP SEQUENCE file_file_id_seq;
CREATE SEQUENCE file_file_id_seq;

CREATE OR REPLACE TRIGGER file_file_id_auto_inc
BEFORE INSERT ON t_file
FOR EACH ROW
WHEN (new.file_id IS NULL)
BEGIN
  SELECT file_file_id_seq.nextval
  INTO   :new.file_id from dual;
END;
/

-- t_channel(channel_name) is primary key
CREATE INDEX channel_state ON t_channel(state) TABLESPACE &1;

-- t_job(job_id) is primary key
CREATE INDEX job_job_state ON t_job(job_state) TABLESPACE &1;
CREATE INDEX job_channel_name ON t_job(channel_name) TABLESPACE &1;

-- t_file(file_id) is primary key
CREATE INDEX file_job_id ON t_file(job_id) TABLESPACE &1;
CREATE INDEX file_file_state ON t_file(file_state) TABLESPACE &1;

--
-- Schema version
--
DROP   TABLE t_schema_vers CASCADE CONSTRAINTS;
CREATE TABLE t_schema_vers (
  major NUMBER(2) NOT NULL,
  minor NUMBER(2) NOT NULL,
  patch NUMBER(2) NOT NULL
);
INSERT INTO t_schema_vers (major,minor,patch) VALUES (1,3,8);
