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
-- Source site name
   ,source_site        	VARCHAR2(100)
			CONSTRAINT channel_source_site_not_null NOT NULL
--
-- Destination site name
   ,dest_site        	VARCHAR2(100)
	                CONSTRAINT channel_dest_site_not_null NOT NULL
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
   ,nofiles             INTEGER
--
-- The target throughput for the system (Mbits/s)
   ,nominal_throughput	NUMBER
--
-- The state of the channel ("Active", "Inactive", "Drain", "Stopped")
   ,channel_state	VARCHAR2(30)
--
-- The time the channel was last active
   ,last_active		TIMESTAMP(0)
);

--
-- The Channel VO share table stores the percentage of the channel resources 
-- available for a VO
--
DROP TABLE t_channel_vo_share CASCADE CONSTRAINTS;
CREATE TABLE t_channel_vo_share (
--
-- the name of the channel
   channel_name         VARCHAR2(32)
                    	CONSTRAINT channel_vo_share_ch_not_null NOT NULL
--
-- The name of the VO
  ,vo_name              VARCHAR2(50)
                    	CONSTRAINT channel_vo_share_vo_not_null NOT NULL
--
-- The percentage of the channel resources associated to the VO
   ,channel_share       INTEGER DEFAULT 0
--
-- Set primary key
   ,CONSTRAINT channel_vo_share_pk PRIMARY KEY (channel_name, vo_name)
);

--
-- Store Channel ACL
--
DROP TABLE t_channel_acl CASCADE CONSTRAINTS;
CREATE TABLE t_channel_acl (
--
-- the name of the channel
   channel_name         VARCHAR2(32)
                    	CONSTRAINT channel_acl_ch_name_not_null NOT NULL
--
-- The principal name
  ,principal            VARCHAR2(255)
                    	CONSTRAINT channel_acl_pr_not_null NOT NULL
--
-- Set Primary Key
  ,CONSTRAINT channel_acl_pk PRIMARY KEY (channel_name, principal)
);

--
-- Store VO ACL
--
DROP TABLE t_vo_acl CASCADE CONSTRAINTS;
CREATE TABLE t_vo_acl (
--
-- the name of the VO
   vo_name		VARCHAR2(32)
			CONSTRAINT vo_acl_vo_name_not_null NOT NULL
--
-- The principal name
  ,principal            VARCHAR2(255)
                    	CONSTRAINT vo_acl_pr_not_null NOT NULL
--
-- Set Primary Key
  ,CONSTRAINT vo_acl_pk PRIMARY KEY (vo_name, principal)
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
   ,job_state       	VARCHAR2(13)
                    	CONSTRAINT job_job_state_not_null NOT NULL
--
-- Transport specific parameters
  ,job_params       	VARCHAR2(255)
--
-- Source Site/SE name - the source cluster name
  ,source               VARCHAR2(255)
--
-- Dest Site/SE name - the destination cluster name
  ,dest                 VARCHAR2(255)
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
  ,user_cred        	VARCHAR2(255)
--
-- Blob to store user capabilites and groups
  ,voms_cred            BLOB
--
-- The VO that owns this job
  ,vo_name              VARCHAR2(50)
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
--
-- Priority for Intra-VO Scheduling
  ,priority      	INTEGER DEFAULT 3
--
-- Internal job parameters,used to pass job specific data from the
-- WS to the agent
  ,internal_job_params  VARCHAR2(255)
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
		        CONSTRAINT file_file_id_pk PRIMARY KEY
--
-- job_id (used in joins with file table)
   ,job_id		CHAR(36)
                    	CONSTRAINT file_job_id_not_null NOT NULL
                    	REFERENCES t_job(job_id)
--
-- The state of this file
  ,file_state		VARCHAR2(29)
                    	CONSTRAINT file_file_state_not_null NOT NULL
--
-- The Source Logical Name
  ,logical_name      	VARCHAR2(1100)
--
-- The Source
  ,source_surl      	VARCHAR2(1100)
--
-- The Destination
  ,dest_surl		VARCHAR2(1100)
--
-- The agent who is transferring the file. This is only valid when the file
-- is in 'Active' state
  ,agent_dn		VARCHAR2(1024)
--
-- The class for the reason field
  ,reason_class		VARCHAR2(32)
--
-- The reason the file is in this state
  ,reason           	VARCHAR2(1024)
--
-- Number of Failures
  ,num_failures         INTEGER
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

--
-- t_transfer table stores the data related to a file transfer
--
DROP TABLE t_transfer CASCADE CONSTRAINTS;
CREATE TABLE t_transfer (
--
-- transfer request id
   request_id           VARCHAR2(255)
                        CONSTRAINT transfer_req_id_not_null NOT NULL
--
-- Identifier of the file to transfer
  ,file_id              INTEGER
		        CONSTRAINT transfer_file_id_not_null NOT NULL
		        REFERENCES t_file(file_id)
-- 
-- transfer identifier within the request. It could be used for ordering
  ,transfer_id          INTEGER
                        CONSTRAINT transfer_tr_id_not_null NOT NULL
--
-- The state of this file
  ,transfer_state       VARCHAR2(29)
                        CONSTRAINT transfer_tr_state_not_null NOT NULL
--
-- The Source TURL
  ,source_turl          VARCHAR2(1100)
--
-- The Destination TURL
  ,dest_turl            VARCHAR2(1100)
--
-- the time at which the file was transferred
  ,transfer_time        TIMESTAMP(0)
--
-- the transfer duration in seconds
  ,duration             NUMBER(12,2)
--
-- the number of bytes written to the destination
  ,bytes_written        INTEGER
--
-- The class for the reason field
  ,reason_class         VARCHAR2(32)
--
-- The reason the transfer is in this state
  ,reason               VARCHAR2(1024)
--
-- Set primary key
   ,CONSTRAINT transfer_pk PRIMARY KEY (request_id, file_id)
);

-- 
-- t_trace table traces the transfers' execution
--
DROP TABLE t_trace CASCADE CONSTRAINTS;
CREATE TABLE t_trace (
--
-- message_id is a unique identifier for the entry.
-- It is created automatically.
   trace_id	        INTEGER
			CONSTRAINT trace_trace_id_not_null NOT NULL
		        CONSTRAINT trace_trace_id_pk PRIMARY KEY
--
-- transfer request id
   ,request_id          VARCHAR2(255)
--
-- Identifier of the file to transfer
   ,file_id             INTEGER
--
-- trace timestamp
   ,trace_timestamp     TIMESTAMP(0) DEFAULT SYSTIMESTAMP
--
-- trace content
   ,content             CLOB
-- 
-- Set Constraint
   ,CONSTRAINT trace_transfer_fk FOREIGN KEY (request_id, file_id)
    REFERENCES t_transfer(request_id,file_id)
);
--
-- autoinc sequence on trace_trace_id
--
DROP SEQUENCE trace_trace_id_seq;
CREATE SEQUENCE trace_trace_id_seq;

CREATE OR REPLACE TRIGGER trace_trace_id_auto_inc
BEFORE INSERT ON t_trace
FOR EACH ROW
WHEN (new.trace_id IS NULL)
BEGIN
  SELECT trace_trace_id_seq.nextval
  INTO   :new.trace_trace_id from dual;
END;
/

--
--
-- Index Section 
--
--

-- t_channel indexes:
-- t_channel(channel_name) is primary key
CREATE INDEX channel_channel_state ON t_channel(channel_state);

-- t_channel_vo_share indexes:
-- t_channel_vo_share(channel_name,vo_name) is primary key
CREATE INDEX channel_vo_share_channel_name ON t_channel_vo_share(channel_name); 

-- t_channel_acl indexes:
-- t_channel_acl(channel_name,principal) is primary key
CREATE INDEX channel_acl_channel_name ON t_channel_acl(channel_name);

-- t_vo_acl indexes:
-- t_vo_acl(vo_name,principal) is primary key
CREATE INDEX vo_acl_vo_name ON t_vo_acl(vo_name);

-- t_job indexes:
-- t_job(job_id) is primary key
CREATE INDEX job_job_state    ON t_job(job_state);
CREATE INDEX job_channel_name ON t_job(channel_name);
CREATE INDEX job_vo_name      ON t_job(vo_name);

-- t_file indexes:
-- t_file(file_id) is primary key
CREATE INDEX file_job_id     ON t_file(job_id);
CREATE INDEX file_file_state ON t_file(file_state);

-- t_transfer indexes:
-- t_transfer(transfer_unique_id) is primary key
-- Probably unique index is not need it: commented out
-- CREATE UNIQUE INDEX transfer_unique_idx ON t_transfer(request_id,transfer_id);
CREATE INDEX transfer_request_id        ON t_transfer(request_id);
CREATE INDEX transfer_file_id           ON t_transfer(file_id);
CREATE INDEX transfer_transfer_state    ON t_transfer(transfer_state);

-- t_trace indexes:
-- t_trace(trace_id) is primary key
CREATE INDEX trace_transfer_unique_id ON t_trace(request_id,file_id);

-- 
--
-- Schema version
--
DROP   TABLE t_schema_vers CASCADE CONSTRAINTS;
CREATE TABLE t_schema_vers (
  major NUMBER(2) NOT NULL,
  minor NUMBER(2) NOT NULL,
  patch NUMBER(2) NOT NULL
);
INSERT INTO t_schema_vers (major,minor,patch) VALUES (2,0,0);
