-- 
-- this requires one parameter - the INDEX tablespace name

--
-- channels in the system
--
DROP TABLE t_channel CASCADE CONSTRAINTS;
CREATE TABLE t_channel (
   channel_name  VARCHAR2(32)
	         CONSTRAINT channel_channel_name_not_null NOT NULL
                 CONSTRAINT channel_channel_name_id_pk PRIMARY KEY
  ,domain_a      VARCHAR2(100)
	         CONSTRAINT channel_domain_a_not_null NOT NULL
   ,domain_b     VARCHAR2(100)
	         CONSTRAINT channel_domain_b_not_null NOT NULL
   ,contact      VARCHAR2(255)
-- bandwidth in Mb/s
   ,bandwidth    INTEGER
   ,state        VARCHAR2(30)
   ,last_active  DATE
);

--CREATE INDEX channel_state on t_channel(state);

--
-- t_job contains the list of jobs currently in the transfer database.
--
DROP TABLE t_job CASCADE CONSTRAINTS;
CREATE TABLE t_job (
--
-- the job_id is a IETF UUID in string form.  
  job_id	        CHAR(36) 
                        CONSTRAINT job_job_id_not_null NOT NULL
                        CONSTRAINT job_job_id_pk PRIMARY KEY
  --
  -- The state a job is currently in
  ,job_state		VARCHAR2(9) 
                        CONSTRAINT job_job_state_not_null NOT NULL
  --
  -- transport specific parameters
  ,job_params           VARCHAR2(250)
  --	
  -- the DN of the user starting the job - they are the only one 
  -- who can sumbit/cancel
  ,user_dn              VARCHAR2(1024) NOT NULL
  --
  -- the DN of the agent currently servicing the job
  ,agent_dn             VARCHAR2(1024) NOT NULL
  --
  -- the user credentials passphrase. This is passed to the movement service in 
  -- order to retrieve the appropriate user proxy to do the transfers
  ,user_cred            VARCHAR2(250)
  --
  -- the name of the transfer channel for this job
  ,channel_name         VARCHAR2(32)
			REFERENCES t_channel(channel_name)
  ,reason               VARCHAR2(255)
  ,submit_time          DATE
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
 -- job_id (used in joins with file table)
   ,job_id		CHAR(36) 
                        CONSTRAINT file_job_id_not_null NOT NULL
                        REFERENCES t_job(job_id)
 -- the state of this file
  ,file_state		VARCHAR2(29) 
                        CONSTRAINT file_state_not_null NOT NULL
 -- The Source
  ,source_surl	        VARCHAR2(1100)
                        CONSTRAINT file_source_surl_not_null NOT NULL
 -- The Destination
  ,dest_surl		VARCHAR2(1100) 
                        CONSTRAINT file_dest_surl_not_null NOT NULL
 -- The transport specific paramaters for the file transfer
  ,file_params		VARCHAR2(250)
-- The agent who is transferring the file. This is only valid when the file
-- is in 'Active' state
  ,agent_dn		VARCHAR2(1024)
  ,reason               VARCHAR2(255)
  ,transfer_time        DATE
-- the time at which the file was transferred
  ,duration             NUMBER
-- the transfer duration in seconds
  ,CONSTRAINT           file_job_id_file_id_pk
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
-- A logging table which tracks interactions with the t_job and t_file table
--
-- The could be done using Workspace Manager, but it isn't installed on the test
-- nodes.  Fake it using triggers (not timestamps will be modification 
-- timestamps, not commit timestamps).  
--
DROP TABLE t_job_log;
CREATE TABLE t_job_log (
	job_id 	        CHAR(36) 
                        CONSTRAINT job_log_job_id_not_null NOT NULL
	,file_id 	INTEGER
	,job_state	VARCHAR2(9)
	,file_state	VARCHAR2(9)
	,timestamp	DATE
	,dn             VARCHAR2(1024)
);

-- Schema version

DROP   TABLE t_schema_vers CASCADE CONSTRAINTS;
CREATE TABLE t_schema_vers (
  major NUMBER(2) NOT NULL,
  minor NUMBER(2) NOT NULL,
  patch NUMBER(2) NOT NULL
);

--
-- Triggers from http://asktom.oracle.com/~tkyte/Mutate/
--

-- this package is used to maintain our state.  We will save the rowids of
-- newly inserted / updated rows in this package.  We declare 2 arrays --
-- one will hold our new rows rowids (newRows).  The other is used to reset
-- this it is an 'empty' array

create or replace package job_log_state_pkg
as
          type ridArray is table of rowid index by binary_integer;

          job_newRows ridArray;
          file_newRows ridArray;

          empty   ridArray;
end;
/

-- We must set the state of the above package to some known, consistent
-- state before we being processing the row triggers.  This trigger is
-- mandatory, we *cannot* rely on the AFTER trigger to reset the package
-- state.  This is because during a multi-row insert or update, the ROW
-- trigger may fire but the AFTER tirgger does not have to fire -- if the
-- second row in an update fails due to some constraint error -- the row
-- trigger will have fired 2 times but the AFTER trigger (which we relied on
-- to reset the package) will never fire.  That would leave 2 erroneous
-- rowids in the newRows array for the next insert/update to see.
-- Therefore, before the insert / update takes place, we 'reset'

create or replace trigger t_job_bi
before insert or update on t_job
begin
        job_log_state_pkg.job_newRows := job_log_state_pkg.empty;
end;
/ 

create or replace trigger t_file_bi
before insert or update on t_file
begin
        job_log_state_pkg.file_newRows := job_log_state_pkg.empty;
end;
/ 

-- This trigger simply captures the rowid of the affected row and saves it
-- in the newRows array.

create or replace trigger t_job_aifer
  after insert or update of job_state on t_job for each row
begin
       job_log_state_pkg.job_newRows( job_log_state_pkg.job_newRows.count+1 ) := :new.rowid;
end;
/ 

create or replace trigger t_file_aifer
  after insert or update of file_state on t_file for each row
begin
       job_log_state_pkg.file_newRows( job_log_state_pkg.file_newRows.count+1 ) := :new.rowid;
end;
/ 

-- this trigger processes the new rows.  We simply loop over the newRows
-- array processing each newly inserted/modified row in turn.

create or replace trigger t_job_ai
  after insert or update of job_state on t_job
  begin
          for i in 1 .. job_log_state_pkg.job_newRows.count loop
                  insert into t_job_log
                  select job_id, NULL, job_state, NULL, sysdate, user_dn
                    from t_job where rowid = job_log_state_pkg.job_newRows(i);
          end loop;
  end;
/ 

create or replace trigger t_file_ai
  after insert or update of file_state on t_file
  begin
          for i in 1 .. job_log_state_pkg.file_newRows.count loop
                  insert into t_job_log
                  select job_id, file_id, NULL, file_state, sysdate, agent_dn
                    from t_file where rowid = job_log_state_pkg.file_newRows(i);
          end loop;
  end;
/ 
