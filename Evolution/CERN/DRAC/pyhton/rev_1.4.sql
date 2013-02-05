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
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON test.* TO Dirac IDENTIFIED BY 'Dirac';
-- INSERT INTO user (Host,User,Password) VALUES('localhost','Dirac',PASSWORD ('must_be_set'));
-- GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON dirac.* TO Dirac IDENTIFIED BY 'must_be_set';
-- GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON JobDB.* TO Dirac IDENTIFIED BY 'must_be_set';
INSERT INTO user (Host,User,Password) VALUES('marsanne.in2p3.fr','Ian',PASSWORD ('Ian'));
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON unittest.* TO Ian IDENTIFIED BY 'Ian';
-- DELETE FROM user WHERE user="Ian";
-- INSERT INTO user (Host,User,Password) VALUES('%','Ian',PASSWORD ('must_be_set'));
-- INSERT INTO user (Host,User,Password) VALUES('localhost','Ian',PASSWORD ('must_be_set'));



--------------------------------------------------------------------------------
-- USE  JobDB;
USE test;


------------------------------------------------------------------------------- 
--USE JobDB;
CREATE TABLE Job (   JobID integer not null auto_increment primary key
                   , JDL BLOB
                   , JobType varchar(100)
                   , Type  enum ("Normal", "Interactive", "Checkpointable", "MPICH", "Partitionable", "Checkpointable, Interactive", "Checpointable, MPICH") not null
		   , Site varchar(100)		   
		   , Owner varchar(100)
		   , SubmissionDate Date
		   , SubmissionTime time
                   , InputSandBox  enum ('True', 'False') not null
                   , OutputSandbox enum ('True', 'False') not null
                   , Status enum        ('submitted',
		   'running','waiting','ready', 'done',
		   'rescheduled','outputready', 'matched', 'scheduled',		   
		   'queued', 'failed' ) not null);


                        'queued',
drop table if exists InputSandbox;
CREATE TABLE InputSandbox (JobID integer not null, file varchar(100));
ALTER  TABLE InputSandbox ADD FOREIGN KEY(JobID) REFERENCES Job(JobID);
ALTER  TABLE InputSandbox ADD PRIMARY KEY (JobID, file);
    JobID integer not null,
    file varchar(100),
drop table if exists OutputSandbox;
CREATE TABLE OutputSandbox (JobID integer not null, file varchar(100));
ALTER  TABLE OutputSandbox ADD FOREIGN KEY(JobID) REFERENCES Job(JobID);
ALTER  TABLE OutputSandbox ADD PRIMARY KEY (JobID, file);
    JobID integer not null,
    file varchar(100),
    FOREIGN KEY(JobID) REFERENCES Job(JobID)
);

CREATE TABLE TaskQueues (TaskQueueId integer not null auto_increment primary key, name varchar(100));
    name        varchar(100),  
    Private     enum ('True', 'False') not null,
    Requirements BLOB
);
CREATE TABLE  Optimizer(OptimId integer not null auto_increment primary key, name varchar(100));
CREATE TABLE  Optimizer(
    OptimId  integer not null auto_increment primary key,
    name     varchar(100),
CREATE TABLE OptToQueue (OptimId integer not null, TaskQueueId integer not null);
ALTER  TABLE OptToQueue ADD FOREIGN KEY(OptimId) REFERENCES Optimizer(OptimId);
ALTER  TABLE OptToQueue ADD FOREIGN KEY(TaskQueueId) REFERENCES TaskQueues(TaskQueueId);
ALTER  TABLE OptToQueue ADD PRIMARY KEY (OptimId, TaskQueueId);
    TaskQueueId integer not null,
    PRIMARY KEY (OptimId, TaskQueueId),
    FOREIGN KEY(OptimId) REFERENCES Optimizer(OptimId),
CREATE TABLE TaskQueue (TaskQueueId integer not null, JobID integer not null, Rank integer);
ALTER  TABLE TaskQueue ADD FOREIGN KEY(JobID) REFERENCES Job(JobID);
ALTER  TABLE TaskQueue ADD FOREIGN KEY(TaskQueueId) REFERENCES TaskQueues(TaskQueueId);
ALTER  TABLE TaskQueue ADD PRIMARY KEY (JobID, TaskQueueId);
    Rank        integer,
    PRIMARY KEY (JobID, TaskQueueId),
    FOREIGN KEY(JobID) REFERENCES Job(JobID),
CREATE TABLE JobParameters (JobID integer not null, Name varchar(100) not null, Value BLOB  not null);
ALTER  TABLE JobParameters ADD FOREIGN KEY(JobID) REFERENCES Job(JobID);
-- ALTER  TABLE JobStatus ADD PRIMARY KEY(JobID, Name);
    Name varchar(100) not null,
    Value BLOB  not null,
    Time time,
    FOREIGN KEY(JobID) REFERENCES Job(JobID)
CREATE TABLE InformationService (   Profile varchar(100),
                                    Item    varchar(100) NOT NULL,
                                    Value   varchar(100) NOT NULL);
    Profile varchar(100),
ALTER  TABLE InformationService ADD PRIMARY KEY (Profile, Item);
    Value   varchar(100) NOT NULL,
    File   varchar(100) NOT NULL,
--------------------------------------------------------------------------------
--DROP FUNCTION  metamatch;
--CREATE FUNCTION metamatch RETURNS INTEGER SONAME "libudf_example.so";

--------------------------------------------------------------------------------
