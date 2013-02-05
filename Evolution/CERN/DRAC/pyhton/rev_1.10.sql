-----------------------------
-- file : Create JobDB Table
-- date : 26/09/03
-- Auteur: Vincent Garonne
-----------------------------

--------------------------------------------------------------------------------
-- DROP TABLE IF EXISTS JobDB;
-- DROP DATABASE IF EXISTS JobDB;
--------------------------------------------------------------------------------
-- CREATE DATABASE JobDB;
-- mv /var/lib/mysql/JobDB /var/lib/mysql/test
-- source /lhcb/users/garonne/Dirac.2.0/scripts/DB.rq
--------------------------------------------------------------------------------
use mysql;
delete from user where user='Dirac';

--
--
-- INSERT INTO user (Host,User,Password) VALUES('localhost','Dirac',PASSWORD ('must_be_set'));
-- INSERT INTO user (Host,User,Password) VALUES('lxgate03.cern.ch','Dirac',PASSWORD ('must_be_set'));
-- GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON dirac.* TO Dirac IDENTIFIED BY 'must_be_set';
-- GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON JobDB.* TO Dirac IDENTIFIED BY 'must_be_set';
-- GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON test.* TO Dirac IDENTIFIED BY 'must_be_set';
-- 
-- DELETE FROM user WHERE user="Ian";
-- INSERT INTO user (Host,User,Password) VALUES('%','Ian',PASSWORD ('must_be_set'));
-- INSERT INTO user (Host,User,Password) VALUES('localhost','Ian',PASSWORD ('must_be_set'));
-- INSERT INTO user (Host,User,Password) VALUES('grid.physics.ox.ac.uk','Ian',PASSWORD ('must_be_set'));
USE JobDB;
-- USE test;

------------------------------------------------------------------------------- 
--USE JobDB;
USE test;
-- USE oxdevel;

--------------------------------------------------------------------------------
drop table if exists Job;
CREATE TABLE Job (
    JobID integer not null auto_increment primary key,
    JDL BLOB,
    JobType varchar(100),
    Type  enum ("Normal",
                "Interactive",
                "Checkpointable",
                "MPICH",
                "Partitionable",
                "Checkpointable,
                Interactive",
    SubmissionTime time,
    ProductionId     char(8),
    JobName          varchar(32),
    LastUpdate       TIMESTAMP,
    ApplicationStatus varchar(128),
    OutputSandbox enum ('True', 'False') not null,
    Status enum        ('submitted',
                        'running',
                        'waiting',
                        'waitingdata',
                        'ready',
                        'done',
                        'failed' ) not null
                        'scheduled',           


                        'queued',
                        'failed',
drop table if exists InputSandbox;
CREATE TABLE InputSandbox (
);
--------------------------------------------------------------------------------

drop table if exists InputData;
CREATE TABLE InputData (
    JobID integer not null,
    file varchar(100),
    PRIMARY KEY (JobID, file),
drop table if exists OutputSandbox;
CREATE TABLE OutputSandbox (

--------------------------------------------------------------------------------

drop table if exists OutputData;
CREATE TABLE OutputData (
    JobID integer not null,
    file varchar(100),
    PRIMARY KEY (JobID, file),
    FOREIGN KEY(JobID) REFERENCES Job(JobID)
);

--------------------------------------------------------------------------------

    name varchar(100)
    TaskQueueId integer not null auto_increment primary key,
    name        varchar(100),  
    Private     enum ('True', 'False') not null,
    Priority    integer,
    Requirements BLOB
);

    OptimId integer not null auto_increment primary key,
    name varchar(100)
-- TaskQueueID integer not null auto_increment,
CREATE TABLE  Optimizer(
    OptimId  integer not null auto_increment primary key,
    name     varchar(100),
    Priority integer
);

--------------------------------------------------------------------------------
drop table if exists OptToQueue;
CREATE TABLE OptToQueue (
    OptimId     integer not null,
    TaskQueueId integer not null,
    PRIMARY KEY (OptimId, TaskQueueId),
    FOREIGN KEY(OptimId) REFERENCES Optimizer(OptimId),
    FOREIGN KEY(TaskQueueId) REFERENCES TaskQueues(TaskQueueId)
);

--------------------------------------------------------------------------------
drop table if exists TaskQueue;
CREATE TABLE TaskQueue (
    TaskQueueId integer not null,
    JobID       integer not null,
    Rank        integer,
    PRIMARY KEY (JobID, TaskQueueId),
    FOREIGN KEY(JobID) REFERENCES Job(JobID),
    FOREIGN KEY(TaskQueueId) REFERENCES TaskQueues(TaskQueueId)
);

--------------------------------------------------------------------------------
drop table if exists JobParameters;
CREATE TABLE JobParameters (
-- ALTER  TABLE JobStatus ADD PRIMARY KEY(JobID, Name);
    Name varchar(100) not null,
    Value BLOB  not null,
    FOREIGN KEY(JobID) REFERENCES Job(JobID)
);
ALTER  TABLE JobParameters ADD PRIMARY KEY(JobID, Name);

--------------------------------------------------------------------------------
drop table if exists LogInfos;
CREATE TABLE LogInfos (
    JobID integer not null,
    Event varchar(100) not null,
    Date Date,
    Time time,
    FOREIGN KEY(JobID) REFERENCES Job(JobID)
);

--------------------------------------------------------------------------------
DROP TABLE IF EXISTS InformationService;

CREATE TABLE InformationService (
    Profile varchar(100),
    Item    varchar(100) NOT NULL,
    Value   varchar(100) NOT NULL,
    PRIMARY KEY (Profile, Item)
);

--------------------------------------------------------------------------------
    Value  BLOB NOT NULL,
CREATE TABLE ISandbox (
    JobID  integer not null,
    File   varchar(100) NOT NULL,
    Value  LONGBLOB NOT NULL,
    Type  enum  ('ascii', 'binary') not null,
    PRIMARY KEY (JobID, File)
);
--------------------------------------------------------------------------------
    Value  BLOB NOT NULL,
CREATE TABLE OSandbox (
    JobID  integer not null,
    File   varchar(100) NOT NULL,
    Value  LONGBLOB NOT NULL,
    Type  enum  ('ascii', 'binary') not null,
    PRIMARY KEY (JobID, File)
);
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS SandboxReady;
CREATE TABLE SandboxReady (
    JobID  integer not null,
);
INSERT INTO  CommonMask (Mask, Date, Time) VALUES ('[Requirements = true;]',CURDATE(),CURTIME());
--------------------------------------------------------------------------------
--DROP FUNCTION  metamatch;
--CREATE FUNCTION metamatch RETURNS INTEGER SONAME "libudf_example.so";

--------------------------------------------------------------------------------
