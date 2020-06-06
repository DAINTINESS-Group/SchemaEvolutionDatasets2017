/* SQL statements for type Request */
CREATE TABLE Request (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, owner INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, lifetimeUpdates NUMBER, owner INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER PRIMARY KEY) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize NUMBER, lifeTime NUMBER, id INTEGER PRIMARY KEY, ownedBy INTEGER, ownerPermission INTEGER, otherPermission INTEGER) INITRANS 50 PCTFREE 50;
CREATE TABLE UserFile2StageRequest (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StageRequest_C on UserFile2StageRequest (child);
CREATE INDEX I_UserFile2StageRequest_P on UserFile2StageRequest (parent);
CREATE TABLE UserFile2StorageReques (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StorageReques_C on UserFile2StorageReques (child);
CREATE INDEX I_UserFile2StorageReques_P on UserFile2StorageReques (parent);

/* SQL statements for type RequestStatus */
CREATE TABLE RequestStatus (dateStamp VARCHAR2(2048), id INTEGER PRIMARY KEY, request INTEGER, currentStatus INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPermission */
CREATE TABLE UserPermission (id INTEGER PRIMARY KEY, permissionOwner INTEGER, fileName INTEGER, permission INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPin */
CREATE TABLE UserPin (id INTEGER PRIMARY KEY, pinOwner INTEGER, pins INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StorageRequest */
CREATE TABLE StorageRequest (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, spaceToken NUMBER, tokenDescription VARCHAR2(2048), storageAllocated NUMBER, storageUsed NUMBER, storageLifetime NUMBER, numberOfUpdates NUMBER, owner INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type FilePin */
CREATE TABLE FilePin (id INTEGER PRIMARY KEY, fileName INTEGER) INITRANS 50 PCTFREE 50;

ALTER TABLE UserFile2StageRequest
  ADD CONSTRAINT fk_UserFile2StageRequest_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StageRequest_C FOREIGN KEY (Child) REFERENCES StageRequest (id);
ALTER TABLE UserFile2StorageReques
  ADD CONSTRAINT fk_UserFile2StorageReques_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StorageReques_C FOREIGN KEY (Child) REFERENCES StorageRequest (id);
/* SQL statements for type Request */
CREATE TABLE Request (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, owner INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StageRequest */
CREATE TABLE StageRequest (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, lifetimeUpdates NUMBER, owner INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type SrmUser */
CREATE TABLE SrmUser (userID VARCHAR2(2048), vo VARCHAR2(2048), castorUser VARCHAR2(2048), id INTEGER PRIMARY KEY) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserFile */
CREATE TABLE UserFile (castorFileName VARCHAR2(2048), fileSize NUMBER, lifeTime NUMBER, id INTEGER PRIMARY KEY, ownedBy INTEGER, ownerPermission INTEGER, otherPermission INTEGER) INITRANS 50 PCTFREE 50;
CREATE TABLE UserFile2StageRequest (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StageRequest_C on UserFile2StageRequest (child);
CREATE INDEX I_UserFile2StageRequest_P on UserFile2StageRequest (parent);
CREATE TABLE UserFile2StorageReques (Parent INTEGER, Child INTEGER) INITRANS 50 PCTFREE 50;
CREATE INDEX I_UserFile2StorageReques_C on UserFile2StorageReques (child);
CREATE INDEX I_UserFile2StorageReques_P on UserFile2StorageReques (parent);

/* SQL statements for type RequestStatus */
CREATE TABLE RequestStatus (dateStamp VARCHAR2(2048), id INTEGER PRIMARY KEY, request INTEGER, currentStatus INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPermission */
CREATE TABLE UserPermission (id INTEGER PRIMARY KEY, permissionOwner INTEGER, fileName INTEGER, permission INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type UserPin */
CREATE TABLE UserPin (id INTEGER PRIMARY KEY, pinOwner INTEGER, pins INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type StorageRequest */
CREATE TABLE StorageRequest (requestDesc VARCHAR2(2048), expires VARCHAR2(2048), requestType VARCHAR2(2048), castorRequestId NUMBER, id INTEGER PRIMARY KEY, spaceToken NUMBER, tokenDescription VARCHAR2(2048), storageAllocated NUMBER, storageUsed NUMBER, storageLifetime NUMBER, numberOfUpdates NUMBER, owner INTEGER, status INTEGER) INITRANS 50 PCTFREE 50;

/* SQL statements for type FilePin */
CREATE TABLE FilePin (id INTEGER PRIMARY KEY, fileName INTEGER) INITRANS 50 PCTFREE 50;

ALTER TABLE UserFile2StageRequest
  ADD CONSTRAINT fk_UserFile2StageRequest_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StageRequest_C FOREIGN KEY (Child) REFERENCES StageRequest (id);
ALTER TABLE UserFile2StorageReques
  ADD CONSTRAINT fk_UserFile2StorageReques_P FOREIGN KEY (Parent) REFERENCES UserFile (id)
  ADD CONSTRAINT fk_UserFile2StorageReques_C FOREIGN KEY (Child) REFERENCES StorageRequest (id);
