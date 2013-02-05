--
-- @author: vincent.garonne@cern.ch
-- @contact: atlas-dq2-dev@cern.ch
-- @since: 0.1.0
-- @version: 

-- how to convert this template:
-- sed -e "s/\${PREFIX}/<some initials>/g" schema-binky-oracle.sql
--

----------------------------------
-- ${PREFIX}t_location
----------------------------------

--/
DROP TABLE ${PREFIX}t_locations;

DROP SEQUENCE ${PREFIX}locations_seq;

CREATE SEQUENCE  ${PREFIX}locations_seq  start with 1  increment by 1  nomaxvalue;

CREATE TABLE ${PREFIX}t_locations (
	locationid   INT NOT NULL, 
	location     VARCHAR(50),
	CONSTRAINT ${PREFIX}pk_locations  PRIMARY KEY(locationid)
)

CREATE UNIQUE INDEX ${PREFIX}idx_locations ON ${PREFIX}t_locations(location);

INSERT INTO ${PREFIX}t_locations  (locationid, location) VALUES (${PREFIX}locations_seq.nextval, 'CERN-PROD_TZERO')

INSERT INTO ${PREFIX}t_locations  (locationid, location) VALUES (${PREFIX}locations_seq.nextval, 'CERN-PROD_DATADISK')

/

----------------------------------
-- ${PREFIX}t_location_protocol
----------------------------------

--/
DROP TABLE ${PREFIX}t_location_protocol;

DROP SEQUENCE ${PREFIX}location_protocol_seq;

CREATE SEQUENCE  ${PREFIX}location_protocol_seq start with 1  increment by 1  nomaxvalue;

CREATE TABLE ${PREFIX}t_location_protocol (
	locationid   INT NOT NULL, 
	protocolId   INT NOT NULL, 
	CONSTRAINT ${PREFIX}pk_location_protocol  PRIMARY KEY(locationid, protocolId)
)


/

----------------------------------
-- ${PREFIX}t_protocol
----------------------------------

--/
DROP TABLE ${PREFIX}t_protocol;

DROP SEQUENCE ${PREFIX}protocol_seq;

CREATE SEQUENCE  ${PREFIX}protocol_seq  start with 1  increment by 1  nomaxvalue;

CREATE TABLE ${PREFIX}t_protocol (
	protocolid   INT NOT NULL, 
	protocol     VARCHAR(50),
	CONSTRAINT ${PREFIX}pk_protocol  PRIMARY KEY(protocolid)
)

CREATE UNIQUE INDEX ${PREFIX}idx_protocol ON ${PREFIX}t_protocol(protocol);


/


----------------------------------
-- ${PREFIX}t_owner
----------------------------------

--/
CREATE SEQUENCE ${PREFIX}owners_seq  start with 1  increment by 1  nomaxvalue

create table ${PREFIX}t_owners
(
    ownerID   INT  NOT NULL, 
    owner     VARCHAR2(500) NOT NULL,
    id        RAW(16) NOT NULL,
    CONSTRAINT ${PREFIX}pk_users  PRIMARY KEY(ownerID)
)

CREATE UNIQUE INDEX ${PREFIX}idx_owners ON  ${PREFIX}t_owners (owner)

/


----------------------------------
-- ${PREFIX}t_group
----------------------------------


--/

CREATE SEQUENCE ${PREFIX}group_seq  start with 1  increment by 1  nomaxvalue

create table ${PREFIX}t_group
(
    groupID   INT  NOT NULL, 
    groupName     VARCHAR2(500) NOT NULL,
    CONSTRAINT ${PREFIX}pk_group  PRIMARY KEY(groupID)
)

CREATE UNIQUE INDEX ${PREFIX}idx_group ON  ${PREFIX}t_group (groupName)


/

----------------------------------
-- ${PREFIX}t_owner_group
----------------------------------

--/

CREATE TABLE ${PREFIX}t_owner_group
(
    groupID   INT  NOT NULL, 
    ownerID   INT  NOT NULL, 
            
    CONSTRAINT ${PREFIX}pk_owner_group PRIMARY KEY(groupID, ownerID)
)

/

----------------------------------
-- ${PREFIX}t_dataset_request
----------------------------------

DROP TABlE ${PREFIX}t_dataset_request

CREATE TABLE ${PREFIX}t_dataset_request (
  duid         RAW(16) NOT NULL,
  locationId   INT     NOT NULL,
  ownerId      INT,
  groupId      INT,
  lifetime     DATE DEFAULT NULL,    
  creationdate DATE DEFAULT       SYSDATE NOT NULL,
  CONSTRAINT  ${PREFIX}pk_dataset_request PRIMARY KEY (duid, locationId, ownerId, groupId)
)

PARTITION BY LIST (locationId) 
(
	 PARTITION partition_1    VALUES (1), 
	 PARTITION partition_2     VALUES (2)	 
);
 
--- TO DO: Try to fix the problem when using site name as partition name
  
CREATE INDEX idx_${PREFIX}t_dataset_request ON ${PREFIX}t_dataset_request (lifetime)

ALTER TABLE ${PREFIX}t_dataset_request  ADD PARTITION q1_nonmainlandŽ VALUES (3,4)



----------------------------------
-- ${PREFIX}t_file_request
----------------------------------

DROP TABlE ${PREFIX}t_file_request

CREATE TABLE ${PREFIX}t_file_request (
  duid         RAW(16) NOT NULL,
  fileId       RAW(16) NOT NULL,
  locationId   INT     NOT NULL,
  CONSTRAINT  ${PREFIX}pk_file_request PRIMARY KEY (duid, locationId, fileId)
)
PARTITION BY LIST (locationId) 
(
	 PARTITION partition_1    VALUES (1), 
	 PARTITION partition_2    VALUES (2)	 
)

-- ORGANIZATION INDEX
-- PCTFREE 0
-- COMPRESS 2;


CREATE INDEX idx2_${PREFIX}t_file_request ON ${PREFIX}t_file_request (duid, fileId)

----------------------
-- ${PREFIX}t_file_replica
----------------------

DROP TABlE ${PREFIX}t_file_replica

CREATE TABLE ${PREFIX}t_file_replica (
	  fileId                RAW(16) NOT NULL,
 	  locationId            INT     NOT NULL, 	  

	  requestType           NUMBER(1) DEFAULT 0 CHECK (requestType IN (0,1,2)),
	  requestTypeTimestamp  DATE DEFAULT SYSDATE NOT NULL,
	  
	  requestState          NUMBER(1) DEFAULT 0 CHECK (requestState IN (0,1,2, 3, 4, 5, 6, 7, 8)),
	  requestStateTimestamp  DATE DEFAULT SYSDATE NOT NULL,


	  replicaState NUMBER(1) DEFAULT 0 CHECK (replicaState IN (0,1,2)),
	  replicaStateTimestamp  DATE DEFAULT SYSDATE NOT NULL,
	  
	  guid     CHAR(36) NOT NULL,
	  lfn      CHAR(255) NOT NULL,	  
	  
	  basepath CHAR(255) NULL,
	  fname    CHAR(255) NULL,

	  filesize NUMBER(11) NULL,
	  checksum VARCHAR2(100) NULL,

	  counter   INT DEFAULT 0,		
	  attemptNr INT,

	  orignalOwnerId      INT,
	  originalGroupId      INT,

	  errorId INT,
	  description VARCHAR2(500) NULL,	  
	  
	  creationdate DATE DEFAULT SYSDATE NOT NULL,	  
	  	  
	  CONSTRAINT  ${PREFIX}pk_file_replica PRIMARY KEY (fileId, locationId)
)
PARTITION BY LIST (locationId) 
(
	 PARTITION partition_1    VALUES (1), 
	 PARTITION partition_2    VALUES (2)	 
)

-- Function-Based Indexes

DROP INDEX idx_${PREFIX_t_file_replica 

CREATE INDEX idx_${PREFIX}t_file_replica  ON  ${PREFIX}t_file_replica
(CASE
 WHEN requestType=0 AND requestState=0 THEN 0
 WHEN requestType=1 AND requestState=3 THEN 1
 WHEN requestType=2 AND requestState=4 THEN 2
 ELSE NULL END)
COMPUTE STATISTICS;

-- (decode (requestType, 1,1, 2,2, NULL, decode (requestState, 3,3, 4,4, NULL), )

-- Query to get copy request
-- SELECT * FROM  ${PREFIX}t_file_replica
-- WHERE (CASE
--  WHEN requestType=1 AND requestState=3 THEN 1
--  WHEN requestType=2 AND requestState=4 THEN 2
--  ELSE NULL END) = 1 

-- Query to get deletion request
-- SELECT * FROM  ${PREFIX}t_file_replica
-- WHERE (CASE
--  WHEN requestType=1 AND requestState=3 THEN 1
--  WHEN requestType=2 AND requestState=4 THEN 2
--  ELSE NULL END) = 2

-- References: 
-- [1] http://richardfoote.wordpress.com/2008/01/28/index-only-values-of-interest-little-wonder/
-- [2] http://awads.net/wp/2005/07/08/case-used-in-create-index/

--/
 BEGIN
       DBMS_ERRLOG.CREATE_ERROR_LOG(
          dml_table_name      => '${PREFIX}t_file_replica'
          );
    END;
/

-- errors will be logged into the ERR$_${PREFIX}_T_FILE_REPLICA table

-- INSERT IGNORE, References: 
-- [1] http://halisway.blogspot.com/2007/04/how-to-do-insert-ignore-in-oracle.html

DROP MATERIALIZED VIEW ${PREFIX}_t_file_replica_mv

CREATE MATERIALIZED VIEW ${PREFIX}_t_file_replica_mv
refresh ON COMMIT complete
AS SELECT locationID,  replicastate, sum(filesize) as bytes, count(*) as N
FROM ${PREFIX}_t_file_replica
GROUP BY locationID, replicastate ;

-- refresh complete 
-- refresh FAST
-- refresh ON COMMIT complete

-- SELECT  location, decode (replicastate, 0, 'UNKNOW', 1, 'FOUND', 3, 'MISSING'), bytes, n 
-- FROM  v1_t_file_replica_mv, v1_t_locations
-- WHERE  v1_t_file_replica_mv.locationId = v1_t_locations.locationId

----------------------
-- ${PREFIX}t_log
----------------------

DROP TABlE ${PREFIX}t_log

CREATE TABLE ${PREFIX}t_log (
	requestType		     VARCHAR2 (200),
	requestArgs		     VARCHAR2 (500),
	DN 	                 VARCHAR2 (200),
	dsn                  VARCHAR2 (200),
	status               NUMBER(3),
	
	location             VARCHAR(50),       
	groupName            VARCHAR(50),
		
	beginning  		     TIMESTAMP,
	termination          TIMESTAMP,
	requestSize 	     NUMBER(3)
)


----------------------
-- ${PREFIX}t_callback
----------------------

DROP TABLE ${PREFIX}t_callback

CREATE TABLE ${PREFIX}t_callback (

  duid         RAW(16) NOT NULL,
  locationId   INT     NOT NULL,

  type		         VARCHAR2 (500),  
  endpoint		     VARCHAR2 (500),
  payload		     VARCHAR2 (500),

  state          NUMBER(1) DEFAULT 0 CHECK (state IN (0,1,2,3)),
  stateTimestamp  DATE DEFAULT SYSDATE NOT NULL,
  creationDate DATE DEFAULT SYSDATE NOT NULL,
   	     
  CONSTRAINT  ${PREFIX}t_callback PRIMARY KEY (duid, locationId, type, endpoint)  
)

CREATE INDEX idx_${PREFIX}t_callback  ON  ${PREFIX}t_callback 
( DECODE (state, 0,0, 1,1, 2,2, NULL))
COMPUTE STATISTICS;


----------------------
-- Triggers
----------------------


----------------------
-- ${PREFIX}increment_counter
----------------------

DROP TRIGGER ${PREFIX}increment_counter

--/
CREATE OR REPLACE TRIGGER  ${PREFIX}update_counter
   AFTER INSERT
   ON  ${PREFIX}t_file_request
       FOR EACH ROW
       BEGIN
            UPDATE ${PREFIX}t_file_replica set counter=counter+1
            WHERE fileId = :new.fileID  AND locationID = :new.locationId;
		END;
/


----------------------
-- ${PREFIX}decrement_counter
----------------------

DROP TRIGGER ${PREFIX}decrement_counter

--/
CREATE OR REPLACE TRIGGER  ${PREFIX}decrement_counter
   AFTER DELETE
   ON  ${PREFIX}t_file_request
       FOR EACH ROW
       BEGIN
            UPDATE ${PREFIX}t_file_replica set counter=counter-1
            WHERE fileId = :new.fileID  AND locationID = :new.locationId;
        END;
END;
/

----------------------
-- ${PREFIX}update_requestType
----------------------

DROP TRIGGER  ${PREFIX}update_requestType
--/
CREATE OR REPLACE TRIGGER  ${PREFIX}update_requestType
 before UPDATE
   OF counter
   ON  ${PREFIX}t_file_replica
       FOR EACH ROW
       BEGIN
        IF (:new.counter = 0 and :old.counter = 1) THEN
       			  :new.requestType          :=  2 ; 
       			  :new.requestTypeTimestamp := sysdate ;
        END IF;    
        
        IF (:new.counter = 1 and :old.counter = 0) THEN
       			  :new.requestType          :=  1 ; 
       			  :new.requestTypeTimestamp := sysdate ;
        END IF;    
END;
/ 
