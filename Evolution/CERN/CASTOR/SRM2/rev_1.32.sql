/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), castorReqId VARCHAR2(2048), overwriteOption NUMBER, protocol VARCHAR2(2048), euid NUMBER, egid NUMBER, lastCheck INTEGER, nextCheck INTEGER, proxyFilePath VARCHAR2(2048), removeSourceFiles NUMBER, rhHost VARCHAR2(2048), rhPort NUMBER, svcClass VARCHAR2(2048), creationTime INTEGER, id INTEGER CONSTRAINT I_StageRequest_Id PRIMARY KEY, srmUser INTEGER, status INTEGER, requestType INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), dn VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER CONSTRAINT I_SrmUser_Id PRIMARY KEY) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize INTEGER, id INTEGER CONSTRAINT I_UserFile_Id PRIMARY KEY, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StorageArea */
CREATE TABLE StorageArea (spaceToken VARCHAR2(2048), tokenDescription VARCHAR2(2048), storageLifetime INTEGER, svcClass VARCHAR2(2048), storageType NUMBER, id INTEGER CONSTRAINT I_StorageArea_Id PRIMARY KEY, srmUser INTEGER, parent INTEGER, storageStatus INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type Pin */
CREATE TABLE Pin (expirationTime INTEGER, lifetimeUpdates NUMBER, id INTEGER CONSTRAINT I_Pin_Id PRIMARY KEY, userFile INTEGER, srmUser INTEGER, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type SubRequest */
CREATE TABLE SubRequest (spaceToken VARCHAR2(2048), turl VARCHAR2(2048), expirationInterval INTEGER, castorFileName VARCHAR2(2048), reservedSize INTEGER, svcClass VARCHAR2(2048), reason VARCHAR2(2048), errorCode NUMBER, aborted NUMBER, id INTEGER CONSTRAINT I_SubRequest_Id PRIMARY KEY, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type CopySubRequest */
CREATE TABLE CopySubRequest (localSurl VARCHAR2(2048), remoteSurl VARCHAR2(2048), localRequestToken VARCHAR2(2048), remoteRequestToken VARCHAR2(2048), reason VARCHAR2(2048), tgtSpaceToken VARCHAR2(2048), tgtExtraInfo VARCHAR2(2048), id INTEGER CONSTRAINT I_CopySubRequest_Id PRIMARY KEY, request INTEGER, remoteStatus INTEGER, localStatus INTEGER, tgtStorageType INTEGER, tgtRetentionPolicy INTEGER, tgtAccessLatency INTEGER) INITRANS 50 PCTFREE 50;


CREATE TABLE CastorVersion (schemaVersion VARCHAR2(20), release VARCHAR2(20));
INSERT INTO CastorVersion VALUES ('-', '1_0_13');

/*******************************************************************
 *
 * @(#)RCSfile: oracleTrailer.sql,v  Revision: 1.15  Release Date: 2007/03/30 14:34:11  Author: itglp 
 *
 * This file contains SQL code that is not generated automatically
 * and is inserted at the end of the generated code
 *
 * @author Castor Dev team, castor-dev@cern.ch
 *******************************************************************/

/* A small table used to cross check code and DB versions */
UPDATE CastorVersion SET schemaVersion = '2_1_2_4';

/* Sequence for indices */
CREATE SEQUENCE ids_seq CACHE 300;

/* SQL statements for object types */
CREATE TABLE Id2Type (id INTEGER PRIMARY KEY, type NUMBER);
CREATE INDEX I_Id2Type_typeId on Id2Type (type, id);

/* get current time as a time_t. Not that easy in ORACLE */
CREATE OR REPLACE FUNCTION getTime RETURN NUMBER IS
  ret NUMBER;
BEGIN
  SELECT (SYSDATE - to_date('01-jan-1970 01:00:00','dd-mon-yyyy HH:MI:SS')) * (24*60*60) INTO ret FROM DUAL;
  RETURN ret;
END;

CREATE INDEX I_UserFile_castorFileName on UserFile (castorFileName);
CREATE INDEX I_SubRequest_turl on SubRequest (turl);
CREATE INDEX I_StageRequest_castorReqId on StageRequest (castorReqId);

/* Add constraints */
ALTER TABLE SrmUser ADD UNIQUE (DN, VO);
ALTER TABLE SrmUser MODIFY (VO NOT NULL);

ALTER TABLE SubRequest MODIFY (svcClass NOT NULL);

ALTER TABLE StorageArea MODIFY (srmUser NOT NULL);
ALTER TABLE StorageArea ADD UNIQUE (srmUser, tokenDescription);
