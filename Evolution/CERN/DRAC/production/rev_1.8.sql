-- $Header: /afs/cern.ch/project/cvs/reps/dirac/DIRAC3/DIRAC/ProductionManagementSystem/DB/ProductionDB.sql,v 1.8 2008/02/20 12:02:05 gkuznets Exp $
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
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON ProductionDB.* TO Dirac@volhcb03.cern.ch IDENTIFIED BY 'must_be_set';
GRANT SELECT,INSERT,LOCK TABLES,UPDATE,DELETE,CREATE,DROP,ALTER ON ProductionDB.* TO Dirac@'%' IDENTIFIED BY 'must_be_set';
FLUSH PRIVILEGES;

-------------------------------------------------------------------------------
USE ProductionRepositoryDB;
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
    GroupSize INT NOT NULL DEFAULT 0,
    Parent VARCHAR(255) DEFAULT '',
    Body BLOB,
    PRIMARY KEY(TransformationID)
);

--------------------------------------------------------------------------------
-- For each row in the Productions table we going to have associated Job table
-- JobID - job index within production
-- WwsStatus - job status in the WMS, for example:
--   Created - newly created job
--   Reserved - prepeared for submission
--   Submitted - job submitted to WMS
--   Runing -
--   Failed -
--   Done - job finished
-- JobWmsID - index of this job in the WMS
--------------------------------------------------------------------------------
DROP TABLE IF EXISTS Jobs_<ProductionID>;
CREATE TABLE  Jobs_<ProductionID>(
  JobID INTEGER NOT NULL AUTO_INCREMENT,
  WmsStatus char(16) DEFAULT 'CREATED',
  JobWmsID char(16),
  TimeStamp TIMESTAMP,
  InputVector BLOB,
  PRIMARY KEY(JobID),
  INDEX(WmsStatus)
);
CREATE TABLE Jobs_%s(
JobID INTEGER NOT NULL AUTO_INCREMENT,
WmsStatus char(16) DEFAULT 'Created',
JobWmsID char(16),
#CreationTime DATETIME NOT NULL DEFAULT NOW(),
#LastUpdateTime DATETIME NOT NULL DEFAULT NOW(),
InputVector BLOB,
PRIMARY KEY(JobID),
INDEX(WmsStatus)
);

--------------------------------------------------------------------------------
--
-- Added the standard base class database tables here
--
--------------------------------------------------------------------------------
SOURCE TransformationDB.sql
