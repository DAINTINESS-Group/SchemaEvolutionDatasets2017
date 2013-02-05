/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), castorReqId VARCHAR2(2048), overwriteOption NUMBER, protocol VARCHAR2(2048), euid NUMBER, egid NUMBER, lastCheck INTEGER, nextCheck INTEGER, proxyFilePath CLOB, removeSourceFiles NUMBER, rhHost VARCHAR2(2048), rhPort NUMBER, creationTime INTEGER, svcClass VARCHAR2(2048), id INTEGER CONSTRAINT I_StageRequest_Id PRIMARY KEY, srmUser INTEGER, status INTEGER, requestType INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), dn VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER CONSTRAINT I_SrmUser_Id PRIMARY KEY) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize INTEGER, id INTEGER CONSTRAINT I_UserFile_Id PRIMARY KEY, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type StorageArea */
CREATE TABLE StorageArea (spaceToken VARCHAR2(2048), tokenDescription VARCHAR2(2048), storageLifetime INTEGER, svcClass VARCHAR2(2048), storageType NUMBER, id INTEGER CONSTRAINT I_StorageArea_Id PRIMARY KEY, srmUser INTEGER, parent INTEGER, storageStatus INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type Pin */
CREATE TABLE Pin (expirationTime INTEGER, lifetimeUpdates NUMBER, id INTEGER CONSTRAINT I_Pin_Id PRIMARY KEY, userFile INTEGER, srmUser INTEGER, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type SubRequest */
CREATE TABLE SubRequest (spaceToken VARCHAR2(2048), turl VARCHAR2(2048), expirationInterval INTEGER, castorFileName VARCHAR2(2048), reservedSize INTEGER, reason VARCHAR2(2048), svcClass VARCHAR2(2048), aborted NUMBER, errorCode NUMBER, surl VARCHAR2(2048), id INTEGER CONSTRAINT I_SubRequest_Id PRIMARY KEY, request INTEGER, status INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;

/* SQL statements for type CopySubRequest */
CREATE TABLE CopySubRequest (localSurl VARCHAR2(2048), remoteSurl VARCHAR2(2048), localRequestToken VARCHAR2(2048), remoteRequestToken VARCHAR2(2048), reason VARCHAR2(2048), tgtSpaceToken VARCHAR2(2048), tgtExtraInfo VARCHAR2(2048), id INTEGER CONSTRAINT I_CopySubRequest_Id PRIMARY KEY, request INTEGER, remoteStatus INTEGER, localStatus INTEGER, tgtStorageType INTEGER, tgtRetentionPolicy INTEGER, tgtAccessLatency INTEGER) INITRANS 50 PCTFREE 50 ENABLE ROW MOVEMENT;


CREATE TABLE CastorVersion (schemaVersion VARCHAR2(20), release VARCHAR2(20));
INSERT INTO CastorVersion VALUES ('-', 'v1_3_11');

/*******************************************************************
 *
 * @(#)RCSfile: oracleTrailer.sql,v  Revision: 1.24  Release Date: 2007/10/09 13:29:11  Author: itglp 
 *
 * This file contains SQL code that is not generated automatically
 * and is inserted at the end of the generated code
 *
 * @author Castor Dev team, castor-dev@cern.ch
 *******************************************************************/

/* A small table used to cross check code and DB versions */
UPDATE CastorVersion SET schemaVersion = '2_1_3_16';

/* Sequence for indices */
CREATE SEQUENCE ids_seq CACHE 300;

/* SQL statements for object types */
CREATE TABLE Id2Type (id INTEGER PRIMARY KEY, type NUMBER);
CREATE INDEX I_Id2Type_typeId on Id2Type (type, id);

/* Indexes to speed up most used queries */
CREATE INDEX I_SubRequest_Status ON SubRequest (status);
CREATE INDEX I_SubRequest_Request ON SubRequest (request);


/* get current time as a time_t. Not that easy in ORACLE */
CREATE OR REPLACE FUNCTION getTime RETURN NUMBER IS
  ret NUMBER;
BEGIN
  SELECT (SYSDATE - to_date('01-jan-1970 01:00:00','dd-mon-yyyy HH:MI:SS')) * (24*60*60) INTO ret FROM DUAL;
  RETURN ret;
END;

--CREATE OR REPLACE TYPE "NUMLIST" IS TABLE OF NUMBER;

CREATE INDEX I_UserFile_castorFileName on UserFile (castorFileName);
CREATE INDEX I_SubRequest_turl on SubRequest (turl);
CREATE INDEX I_StageRequest_castorReqId on StageRequest (castorReqId);

/* Add constraints */
ALTER TABLE SrmUser ADD CONSTRAINT U_SrmUser_UserIdDNVO UNIQUE (userId, DN, VO);
ALTER TABLE SrmUser MODIFY (VO NOT NULL);

ALTER TABLE StorageArea MODIFY (srmUser NOT NULL);
ALTER TABLE StorageArea ADD CONSTRAINT U_StorageArea_srmUserSpToken UNIQUE (srmUser, spaceToken);


/* Procedure for SRM garbage collection */
/*
CREATE OR REPLACE PROCEDURE cleanup( days IN INTEGER ) AS
    pinIds numlist;
    fileIds numlist;
    reqIds numlist;
    srIds numlist;
    oldReq numlist;
    nb1 INTEGER;
    nb2 INTEGER;
    i NUMBER;
    req NUMBER;
    et INTEGER;
    ct INTEGER;
    count INTEGER;
BEGIN
    -- Finally PUT requests do not generate pins.  In this case, we delete
    -- entries which expired 'days' ago
    -- To limit possible table joins and reduce chance of row locking, we
    -- first get requests that were created 'days' or more ago
    SELECT id
      BULK COLLECT INTO oldReq
      FROM stagerequest
     WHERE creationtime < ( gettime ( ) - ( days * 24 * 60 * 60 ) )
       AND requesttype = 1;
    -- Now loop over these requests, get the maximum expiration interval
    -- from the subrequest table, and if creationtime + expInterval
    FOR req IN oldReq.FIRST ..oldReq.LAST LOOP
      SELECT MAX ( expirationInterval )
        INTO et
        FROM subrequest
       WHERE request = oldReq ( req );
      SELECT creationtime
        INTO ct
        FROM stagerequest
       WHERE id = oldReq ( req );
      IF ( ( ct + et + ( days * 24 * 60 * 60 ) ) < gettime ( ) ) THEN
          DELETE FROM stagerequest
           WHERE id = oldReq ( req );
          DELETE FROM id2type
           WHERE id = oldReq ( req );
             DELETE FROM subrequest
              WHERE request = oldReq ( req )
          RETURNING id
               BULK COLLECT INTO srIds;
          DELETE FROM id2type
           WHERE id IN ( SELECT *
               FROM TABLE ( srIds ) );
      END IF;
    END LOOP;

    --  Delete any pins which don't have a parent since they are useless
    --      and are a hangover from a previous implementation
    DELETE FROM pin
     WHERE request = 0;
    -- Now delete expired pins which are beyond their 'use by' date, but collect
    -- the associated userfile and
       DELETE FROM pin
        WHERE status = 4
          AND expirationtime < ( gettime ( ) - ( days * 24 * 60 * 60 ) )
    RETURNING id,
	      userfile,
	      request
         BULK COLLECT INTO pinIds,
	      fileIds,
	      reqIds;
    -- Delete the corresponding entries from ID2TYPE
    DELETE FROM id2type
     WHERE id IN ( SELECT *
		     FROM TABLE ( pinIds ) );
    -- Loop over all userfile IDs returned and check how many
    -- pin entries are left for that id.  If there aren't any
    -- more pins, then we can safely delete the corresponding
    -- userfile entry and, of course, the corresponding ID2TYPE
    -- entry
    -- We need to be a buit careful here in case there were no results.
    -- This causes an exception which we need to ignore.
    BEGIN
      FOR i IN fileIds.FIRST ..fileIds.LAST LOOP
          SELECT count ( * )
            INTO nb1
            FROM pin
           WHERE userfile = fileIds ( i );
          IF ( nb1 = 0 ) THEN
        DELETE FROM userfile
         WHERE id = fileIds ( i );
        DELETE FROM id2type
         WHERE id = fileIds ( i );
          END IF;
      END LOOP;
    
      FOR req IN reqIds.FIRST ..reqIds.LAST LOOP
          SELECT count ( * )
            INTO nb2
            FROM pin
           WHERE request = reqIds ( req );
          IF ( nb2 = 0 ) THEN
            -- Check if the request has expired.  We need to get the creation time from the
            -- stagerequest table and the expiration interval from the subrequest table
            SELECT MAX ( expirationInterval )
              INTO et
              FROM subrequest
             WHERE request = reqIds ( req );
            SELECT creationtime
              INTO ct
              FROM stagerequest
             WHERE id = reqIds ( req );
            IF ( ( et + ct ) > ( gettime ( ) + ( days * 24 * 60 * 60 ) ) ) THEN
                DELETE FROM stagerequest
                 WHERE id = reqIds ( req );
                DELETE FROM id2type
                 WHERE id = reqIds ( req );
                   DELETE FROM subrequest
                    WHERE request = reqIds ( req )
                RETURNING id
                     BULK COLLECT INTO srIds;
                DELETE FROM id2type
                 WHERE id IN ( SELECT *
                     FROM TABLE ( srIds ) );
            END IF;
          END IF;
      END LOOP;

  	EXCEPTION
	    WHEN VALUE_ERROR THEN
	  	--       raise_application_error ( -20101, 
		  --           'Number converion error for i= ' || i || ', fileId[0]=' || fileIds.first);
		  NULL;
    END;
END;
*/
