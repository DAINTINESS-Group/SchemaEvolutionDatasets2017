-- $Header: /afs/cern.ch/project/cvs/reps/dirac/DIRAC3/DIRAC/ProductionManagementSystem/DB/ProductionDB.sql,v 1.19 2009/08/06 20:19:46 atsareg Exp $
--------------------------------------------------------------------------------
--
--  Schema definition for the ProductionDB database - containing Productions and WorkFlows (Templates)
--  history ( logging ) information
---
--------------------------------------------------------------------------------
DROP DATABASE IF EXISTS ProductionDB;
CREATE DATABASE ProductionDB;
--------------------------------------------------------------------------------

-- Database owner definition
USE mysql;

-- Must set passwords for database user by replacing "must_be_set".
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON ProductionDB.* TO Dirac@localhost IDENTIFIED BY 'must_be_set';
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON ProductionDB.* TO Dirac@'%' IDENTIFIED BY 'must_be_set';
FLUSH PRIVILEGES;

-------------------------------------------------------------------------------
USE ProductionDB;
-------------------------------------------------------------------------------
-- This table keeps Workflow for the purpose of creating Productions
-- WFName - name of the WF taken from the xml field "name"
-- WFParent - name of the parent Workflow used to create the current one.
--            taken from the XML field "type"
-- Description - short description of the workflow taken from the field "descr_short" of XML
-- PublisherDN - last persone to update WF
-- PublishingTime - time stamp
-- Body - XML body of the Workflow
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS Workflows;
CREATE TABLE Workflows (
    WFName VARCHAR(255) NOT NULL,
    WFParent VARCHAR(255),
    Description  VARCHAR(255),
    LongDescription  BLOB,
    AuthorDN VARCHAR(255) NOT NULL,
    AuthorGroup VARCHAR(255) NOT NULL,
    PublishingTime TIMESTAMP,
    Body BLOB,
    PRIMARY KEY(WFName)
);

--------------------------------------------------------------------------------
-- This table store additional fields required by the Production
-- TransformationID - Transformation ID referes to Transformations table
-- Parent - name of the Parent Workflow
-- GroupSize - number of files per Transformation
-- Body - XML body of the Workflow.
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS ProductionParameters;
CREATE TABLE ProductionParameters (
    TransformationID INTEGER NOT NULL,
    GroupSize INT NOT NULL DEFAULT 1,
    Parent VARCHAR(255) DEFAULT '',
    InheritedFrom INTEGER DEFAULT 0,
    Body BLOB,
    MaxNumberOfJobs INT NOT NULL DEFAULT 0,
    EventsPerJob INT NOT NULL DEFAULT 0,
    PRIMARY KEY(TransformationID)
);

DROP TABLE IF EXISTS ProductionRequests;
CREATE TABLE ProductionRequests (
    RequestID INTEGER NOT NULL AUTO_INCREMENT,
    RequestName VARCHAR(128) DEFAULT "Unknown",
    INDEX(RequestName),
    RequestType VARCHAR(32) DEFAULT "Simulation",
    NumberOfEvents INTEGER DEFAULT 0,
    EventType VARCHAR(128) DEFAULT "Default",
    CPUPerEvent DOUBLE DEFAULT 0.0,
    CreationTime DATETIME,
    ProductionID INTEGER NOT NULL DEFAULT 0,
    Description BLOB,
    Status VARCHAR(32) DEFAULT "New",
    PRIMARY KEY(RequestID)
);

-- The JobID being the secondary column in the Primary Key insures that it is
-- incremented independently for each distinct TransformationID value, but only 
-- for MyISAM type of tables

DROP TABLE IF EXISTS Jobs;
CREATE TABLE Jobs (
JobID INTEGER NOT NULL AUTO_INCREMENT,
TransformationID INTEGER NOT NULL,
WmsStatus char(16) DEFAULT 'Created',
JobWmsID char(16) DEFAULT '',
TargetSE char(32) DEFAULT 'Unknown',
CreationTime DATETIME NOT NULL,
LastUpdateTime DATETIME NOT NULL,
PRIMARY KEY(TransformationID,JobID),
INDEX(WmsStatus)
);

DROP TABLE IF EXISTS JobInputs;
CREATE TABLE JobInputs (
TransformationID INTEGER NOT NULL,
JobID INTEGER NOT NULL,
InputVector BLOB,
PRIMARY KEY(TransformationID,JobID)
);

--------------------------------------------------------------------------------
--
-- Added the standard base class database tables here
--
--------------------------------------------------------------------------------
SOURCE DIRAC/Core/Transformation/TransformationDB.sql
