/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), expirationTime INTEGER, expirationInterval NUMBER, castorReqId VARCHAR2(2048), lifetimeUpdates NUMBER, overwriteOption NUMBER, protocol VARCHAR2(2048), id INTEGER PRIMARY KEY, srmUser INTEGER, requestType INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER PRIMARY KEY) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize INTEGER, spaceToken VARCHAR2(2048), turl VARCHAR2(2048), id INTEGER PRIMARY KEY, srmUser INTEGER, ownerPermission INTEGER, otherPermission INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;
CREATE TABLE UserFile2StorageArea (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StorageArea_C on UserFile2StorageArea (child);
CREATE INDEX I_UserFile2StorageArea_P on UserFile2StorageArea (parent);
CREATE TABLE UserFile2StageRequest (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StageRequest_C on UserFile2StageRequest (child);
CREATE INDEX I_UserFile2StageRequest_P on UserFile2StageRequest (parent);

/* SQL statements for type RequestStatusHistory */
CREATE TABLE RequestStatusHistory (dateStamp VARCHAR2(2048), id INTEGER PRIMARY KEY, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPermission */
CREATE TABLE UserPermission (id INTEGER PRIMARY KEY, permissionOwner INTEGER, userFile INTEGER, permission INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPin */
CREATE TABLE UserPin (id INTEGER PRIMARY KEY, pinOwner INTEGER, pins INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StorageArea */
CREATE TABLE StorageArea (spaceToken VARCHAR2(2048), tokenDescription VARCHAR2(2048), storageAllocated NUMBER, storageUsed NUMBER, storageLifetime NUMBER, numberOfUpdates NUMBER, id INTEGER PRIMARY KEY, srmUser INTEGER, storageStatus INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type FilePin */
CREATE TABLE FilePin (expirationTime INTEGER, id INTEGER PRIMARY KEY, userFile INTEGER) INITRANS 50 PCTFREE 50;

ALTER TABLE UserFile2StorageArea
  ADD CONSTRAINT fk_UserFile2StorageArea_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StorageArea_C FOREIGN KEY (Child) REFERENCES StorageArea (id);
ALTER TABLE UserFile2StageRequest
  ADD CONSTRAINT fk_UserFile2StageRequest_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StageRequest_C FOREIGN KEY (Child) REFERENCES StageRequest (id);
/* This file contains SQL code that is not generated automatically */
/* and is inserted at the end of the generated code                */

/* A small table used to cross check code and DB versions */
CREATE TABLE CastorVersion (version VARCHAR2(2048));
INSERT INTO CastorVersion VALUES ('2_0_0_65');

/* Sequence for indices */
CREATE SEQUENCE ids_seq;

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

/* Add unique constraint on users */
ALTER TABLE SrmUser ADD UNIQUE (userID, VO); 

