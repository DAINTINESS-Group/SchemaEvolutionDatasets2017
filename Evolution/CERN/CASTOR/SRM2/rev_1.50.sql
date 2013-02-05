/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), castorReqId VARCHAR2(2048), overwriteOption NUMBER, protocol VARCHAR2(2048), euid NUMBER, egid NUMBER, lastCheck INTEGER, nextCheck INTEGER, proxyCert CLOB, removeSourceFiles NUMBER, rhHost VARCHAR2(2048), rhPort NUMBER, creationTime INTEGER, svcClass VARCHAR2(2048), id INTEGER CONSTRAINT PK_StageRequest_Id PRIMARY KEY, srmUser INTEGER, status INTEGER, requestType INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), dn VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER CONSTRAINT PK_SrmUser_Id PRIMARY KEY) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize INTEGER, id INTEGER CONSTRAINT PK_UserFile_Id PRIMARY KEY, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type StorageArea */
CREATE TABLE StorageArea (spaceToken VARCHAR2(2048), tokenDescription VARCHAR2(2048), storageLifetime INTEGER, svcClass VARCHAR2(2048), storageType NUMBER, id INTEGER CONSTRAINT PK_StorageArea_Id PRIMARY KEY, srmUser INTEGER, parent INTEGER, storageStatus INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type Pin */
CREATE TABLE Pin (expirationTime INTEGER, lifetimeUpdates NUMBER, id INTEGER CONSTRAINT PK_Pin_Id PRIMARY KEY, userFile INTEGER, srmUser INTEGER, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type SubRequest */
CREATE TABLE SubRequest (spaceToken VARCHAR2(2048), turl VARCHAR2(2048), expirationInterval INTEGER, castorFileName VARCHAR2(2048), reservedSize INTEGER, reason VARCHAR2(2048), svcClass VARCHAR2(2048), aborted NUMBER, errorCode NUMBER, surl VARCHAR2(2048), id INTEGER CONSTRAINT PK_SubRequest_Id PRIMARY KEY, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type CopySubRequest */
CREATE TABLE CopySubRequest (localSurl VARCHAR2(2048), remoteSurl VARCHAR2(2048), localRequestToken VARCHAR2(2048), remoteRequestToken VARCHAR2(2048), reason VARCHAR2(2048), tgtSpaceToken VARCHAR2(2048), tgtExtraInfo VARCHAR2(2048), id INTEGER CONSTRAINT PK_CopySubRequest_Id PRIMARY KEY, request INTEGER, remoteStatus INTEGER, localStatus INTEGER, tgtStorageType INTEGER, tgtRetentionPolicy INTEGER, tgtAccessLatency INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;


CREATE TABLE CastorVersion (schemaVersion VARCHAR2(20), release VARCHAR2(20));
INSERT INTO CastorVersion VALUES ('-', '2_7_12');

/* Fill Type2Obj metatable */
CREATE TABLE Type2Obj (type INTEGER CONSTRAINT I_Type2Obj_Type PRIMARY KEY NOT NULL, object VARCHAR2(100) NOT NULL, svcHandler VARCHAR2(100));
INSERT INTO Type2Obj (type, object) VALUES (0, 'INVALID');
INSERT INTO Type2Obj (type, object) VALUES (1002, 'StageRequest');
INSERT INTO Type2Obj (type, object) VALUES (1003, 'StorageArea');
INSERT INTO Type2Obj (type, object) VALUES (1004, 'SrmUser');
INSERT INTO Type2Obj (type, object) VALUES (1005, 'UserFile');
INSERT INTO Type2Obj (type, object) VALUES (1007, 'Pin');
INSERT INTO Type2Obj (type, object) VALUES (1008, 'SubRequest');
INSERT INTO Type2Obj (type, object) VALUES (1009, 'CopySubRequest');

/*******************************************************************
 *
 * @(#)RCSfile: oracleTrailer.sql,v  Revision: 1.46  Release Date: 2008/12/08 18:25:11  Author: itglp 
 *
 * This file contains SQL code that is not generated automatically
 * and is inserted at the end of the generated code
 *
 * @author Castor Dev team, castor-dev@cern.ch
 *******************************************************************/

/* A small table used to cross check code and DB versions */
UPDATE CastorVersion SET schemaVersion = '2_7_0';

/* Sequence for indices */
CREATE SEQUENCE ids_seq CACHE 300;

/* Simple int array type */
CREATE OR REPLACE TYPE "NUMLIST" IS TABLE OF NUMBER;
/

/* PL/SQL declaration for the castor package, used by the bulk interfaces */
CREATE OR REPLACE PACKAGE castor AS
 TYPE "cnumList" IS TABLE OF NUMBER index by binary_integer;
END castor;
/

/* Global temporary table to store ids temporarily in the bulkCreateObj procedures */
CREATE GLOBAL TEMPORARY TABLE bulkSelectHelper(objId NUMBER) ON COMMIT DELETE ROWS;

/* Helper temporary table for the cleanup procedure */
CREATE GLOBAL TEMPORARY TABLE CleanupReqHelper
  (id NUMBER NOT NULL, creationTime NUMBER NOT NULL)
    ON COMMIT PRESERVE ROWS;

/* SQL statements for object types */
CREATE TABLE Id2Type (id INTEGER CONSTRAINT I_Id2Type_Id PRIMARY KEY, type NUMBER) ENABLE ROW MOVEMENT;

/* Tables with CLOBS cannot be shrunk */
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE StageRequest DISABLE ROW MOVEMENT';
END;
/

/* Add constraints */
ALTER TABLE StageRequest MODIFY (status NOT NULL);
ALTER TABLE SubRequest MODIFY (status NOT NULL);

ALTER TABLE SrmUser ADD CONSTRAINT U_SrmUser_vo_dn_userId UNIQUE (vo, dn, userId);
ALTER TABLE SrmUser MODIFY (VO NOT NULL);

ALTER TABLE StorageArea ADD CONSTRAINT U_StorageArea_srmUser_spToken UNIQUE (srmUser, spaceToken);
ALTER TABLE StorageArea MODIFY (srmUser NOT NULL);

/* Indexes to speed up most used queries */
CREATE INDEX I_SubRequest_Status ON SubRequest (status);
CREATE INDEX I_SubRequest_Request ON SubRequest (request);
CREATE INDEX I_SubRequest_Turl on SubRequest (turl);

CREATE INDEX I_StageRequest_castorReqId on StageRequest (castorReqId);
CREATE INDEX I_StageRequest_Status ON StageRequest (status);

CREATE INDEX I_UserFile_castorFileName on UserFile (castorFileName);

CREATE INDEX I_Pin_srmUser on Pin (srmUser);
CREATE INDEX I_Pin_userFile on Pin (userFile);
CREATE INDEX I_Pin_request on Pin (request);


/* get current time as a time_t. Not that easy in ORACLE */
CREATE OR REPLACE FUNCTION getTime RETURN NUMBER IS
  epoch            TIMESTAMP WITH TIME ZONE;
  now              TIMESTAMP WITH TIME ZONE;
  interval         INTERVAL DAY(9) TO SECOND;
  interval_days    NUMBER;
  interval_hours   NUMBER;
  interval_minutes NUMBER;
  interval_seconds NUMBER;
BEGIN
  epoch := TO_TIMESTAMP_TZ('01-JAN-1970 00:00:00 00:00',
    'DD-MON-YYYY HH24:MI:SS TZH:TZM');
  now := SYSTIMESTAMP AT TIME ZONE '00:00';
  interval         := now - epoch;
  interval_days    := EXTRACT(DAY    FROM (interval));
  interval_hours   := EXTRACT(HOUR   FROM (interval));
  interval_minutes := EXTRACT(MINUTE FROM (interval));
  interval_seconds := EXTRACT(SECOND FROM (interval));

  RETURN interval_days * 24 * 60 * 60 + interval_hours * 60 * 60 +
    interval_minutes * 60 + interval_seconds;
END;
/


/* Generate a universally unique id (UUID) */
CREATE OR REPLACE FUNCTION uuidGen RETURN VARCHAR2 IS
  ret VARCHAR2(36);
BEGIN
  -- Note: the guid generator provided by ORACLE produces sequential uuid's, not
  -- random ones. The reason for this is because random uuid's are not good for
  -- indexing!
  RETURN lower(regexp_replace(sys_guid(), '(.{8})(.{4})(.{4})(.{4})(.{12})', '\1-\2-\3-\4-\5'));
END;
/


/* PL/SQL method to get the next StageRequest to do */
CREATE OR REPLACE PROCEDURE requestToDo(handler IN INTEGER, rId OUT INTEGER) AS
-- handler = 1 for stage requests (Put, Get, and BoL), 2 for copy requests (CopyPush and CopyPull)
LockError EXCEPTION;
PRAGMA EXCEPTION_INIT (LockError, -54);
-- for the time being this code is ugly to avoid a schema change. The proper solution will come with SRM 2.8-x in January
-- and includes a WHERE svcHandler = handler clause + request time ordering with the same tecnique of the stager
CURSOR c1 IS
   SELECT id FROM StageRequest
    WHERE status = 0  -- PENDING
      AND requestType IN (1, 2, 5)  -- Put, Get, BoL
    FOR UPDATE SKIP LOCKED;
CURSOR c2 IS
   SELECT id FROM StageRequest
    WHERE status = 0  -- PENDING
      AND requestType IN (3, 4)  -- CopyPush, CopyPull
    FOR UPDATE SKIP LOCKED;
BEGIN
  rId := 0;
  IF handler = 1 THEN
    OPEN c1;
    FETCH c1 INTO rId;
    UPDATE StageRequest SET status = 1 WHERE id = rId;  -- INPROGRESS
    CLOSE c1;
  ELSE
    OPEN c2;
    FETCH c2 INTO rId;
    UPDATE StageRequest SET status = 1 WHERE id = rId;  -- INPROGRESS
    CLOSE c2;
  END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
  -- just return rId = 0, nothing to do
  NULL;
WHEN LockError THEN
  -- We have observed ORA-00054 errors (resource busy and acquire with NOWAIT) even with
  -- the SKIP LOCKED clause. This is a workaround to ignore the error until we understand
  -- what to do, another thread will pick up the request so we don't do anything.
  NULL;
END;
/

/* PL/SQL method to get the next StageRequest to poll */
CREATE OR REPLACE PROCEDURE requestToPoll(rId OUT INTEGER) AS
LockError EXCEPTION;
PRAGMA EXCEPTION_INIT (LockError, -54);
CURSOR c IS
   SELECT id FROM StageRequest
    WHERE status = 2  -- READYTOPOLL
      AND requestType IN (2, 5)  -- Get, BoL
      AND nextCheck < getTime()
    FOR UPDATE SKIP LOCKED;
BEGIN
  rId := 0;
  OPEN c;
  FETCH c INTO rId;
  UPDATE StageRequest SET status = 3 WHERE id = rId;  -- POLLING
  CLOSE c;
EXCEPTION WHEN NO_DATA_FOUND THEN
  -- just return rId = 0, nothing to do
  NULL;
WHEN LockError THEN
  NULL;
END;
/


/* A little generic method to delete efficiently */
CREATE OR REPLACE PROCEDURE bulkDelete(sel IN VARCHAR2, tab IN VARCHAR2) AS
BEGIN
  EXECUTE IMMEDIATE
  'DECLARE
    CURSOR s IS '||sel||'
    ids NUMLIST;
  BEGIN
    OPEN s;
    LOOP
      FETCH s BULK COLLECT INTO ids LIMIT 10000;
      EXIT WHEN s%NOTFOUND;
      FORALL i IN ids.FIRST..ids.LAST
        DELETE FROM Id2Type WHERE id = ids(i);
      FORALL i IN ids.FIRST..ids.LAST
        DELETE FROM '||tab||' WHERE id = ids(i);
      COMMIT;
    END LOOP;
    CLOSE s;
  END;';
END;
/


/* Procedure for SRM database cleanup: 
 * Delete all stage and sub requests who are expired and which have no pins
 * left and which have no userfiles left. If the request is a PUT request
 * and the request did not complete successfully, then the file should be
 * removed from the stager and nameserver.
 */
CREATE OR REPLACE PROCEDURE cleanup(days IN INTEGER) AS
BEGIN
  -- Delete EXPIRED pins which are beyond their 'use by' date
  bulkDelete('SELECT id FROM Pin
               WHERE status = 4
                 AND expirationTime < getTime() - '|| days ||'*86400;', 'Pin');

  -- Delete GC candidate userfiles
  bulkDelete('SELECT id FROM UserFile WHERE status = 2;', 'UserFile');

  -- Drop old EXPIRED storage areas
  bulkDelete('SELECT id FROM StorageArea
               WHERE storageStatus = 4
                 AND storageLifeTime < getTime() - '|| days ||'*86400;', 'StorageArea');

  -- Select all completed requests candidate for deletion: this includes
  -- all Put requests (requestType = 1) and all requests for which
  -- no Pins exist anymore
  INSERT INTO CleanupReqHelper
    (SELECT id, nvl(creationTime, 0) FROM StageRequest R
      WHERE (requestType = 1  -- Put
          OR NOT EXISTS
            (SELECT 'x' FROM Pin WHERE request = R.id))
        AND status = 4);  -- DONE
  -- Now keep the requests for which max(expInterval) over their
  -- subRequests + creationTime is greater than getTime() - days
  DELETE FROM CleanupReqHelper
   WHERE id IN (
     SELECT R.id FROM CleanupReqHelper R, SubRequest
      WHERE R.id = SubRequest.request
      GROUP BY R.id, R.creationTime
      HAVING max(SubRequest.expirationInterval) + R.creationTime > getTime() - days*86400);
  COMMIT;
  -- Finally delete remaining requests and associated subRequests
  bulkDelete('SELECT SR.id FROM SubRequest SR, CleanupReqHelper R
               WHERE SR.request = R.id;', 'SubRequest');
  bulkDelete('SELECT SR.id FROM CopySubRequest SR, CleanupReqHelper R
               WHERE SR.request = R.id;', 'CopySubRequest');
  bulkDelete('SELECT id FROM CleanupReqHelper;', 'StageRequest');
  DELETE FROM CleanupReqHelper;
  COMMIT;
END;
/


/* Procedure for SRM garbage collection */
CREATE OR REPLACE PROCEDURE garbageCollect AS
BEGIN
  -- First run GC
  -- expire pins
  UPDATE Pin SET status = 4  -- EXPIRED
   WHERE expirationTime < getTime();
  COMMIT;
  -- expire files
  UPDATE UserFile SET status = 2 WHERE NOT EXISTS
    (SELECT 'x' FROM Pin
      WHERE userFile = UserFile.id
        AND status IN (0, 1, 2));   -- NEW, PINNED, EXTENDED
  COMMIT;
  -- expire spaces
  UPDATE StorageArea SET storageStatus = 4  -- EXPIRED
   WHERE storageLifeTime < getTime();
  COMMIT;

  -- Now perform the cleanup
  cleanup(7);

  -- Finally shrink tables
  FOR t IN (SELECT table_name FROM user_tables
             WHERE row_movement = 'ENABLED'
               AND temporary = 'N'
               AND table_name NOT IN ('USERFILE', 'SRMUSER'))
  LOOP
    EXECUTE IMMEDIATE 'ALTER TABLE '|| t.table_name ||' SHRINK SPACE CASCADE';
  END LOOP;
END;
/


/* Database jobs */
BEGIN
  -- Remove database jobs before recreating them
  FOR j IN (SELECT job_name FROM user_scheduler_jobs
             WHERE job_name IN ('GARBAGECOLLECTJOB'))
  LOOP
    DBMS_SCHEDULER.DROP_JOB(j.job_name, TRUE);
  END LOOP;
  
  -- Create a db job to be run once a day executing the garbageCollect procedure
  DBMS_SCHEDULER.CREATE_JOB(
      JOB_NAME        => 'GarbageCollectJob',
      JOB_TYPE        => 'PLSQL_BLOCK',
      JOB_ACTION      => 'BEGIN garbageCollect(); END;',
      START_DATE      => SYSDATE,
      REPEAT_INTERVAL => 'FREQ=HOURLY; INTERVAL=24',
      ENABLED         => TRUE,
      COMMENTS        => 'Cleanup of terminated or expired entities');
END;
/
