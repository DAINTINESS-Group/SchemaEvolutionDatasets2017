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
-- The target throughput for the system (Mbits/s)
   ,nominal_throughput	NUMBER
--
-- The state of the channel ("Active", "Inactive", "Drain", "Stopped")
   ,state		VARCHAR2(30)
--
-- The date the channel was last active
   ,last_active		DATE
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
  ,reason           	VARCHAR2(255)
--
-- The date that the job was submitted
  ,submit_time      	DATE
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
		        -- JC next constriant is actually too strict!
		        CONSTRAINT file_file_id_unique UNIQUE
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
-- The reason the file is in this state
  ,reason           	VARCHAR2(255)
--
-- the time at which the file was transferred
  ,transfer_time    	DATE
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
--
  ,CONSTRAINT       	file_job_id_file_id_pk
                    	PRIMARY KEY (job_id, file_id)
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

CREATE INDEX file_job_id ON t_file(job_id);
CREATE INDEX file_state ON t_file(file_state);
CREATE INDEX file_source_surl ON t_file(source_surl);

--
-- Schema version
--
DROP   TABLE t_schema_vers CASCADE CONSTRAINTS;
CREATE TABLE t_schema_vers (
  major NUMBER(2) NOT NULL,
  minor NUMBER(2) NOT NULL,
  patch NUMBER(2) NOT NULL
);
