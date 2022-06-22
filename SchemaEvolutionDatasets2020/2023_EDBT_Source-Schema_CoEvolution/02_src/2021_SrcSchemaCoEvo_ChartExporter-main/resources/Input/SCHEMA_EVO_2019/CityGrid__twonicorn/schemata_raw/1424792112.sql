use twonicorn;

### 
### TABLE: applications
###   This contains definitions of applications. Each application has at most one config
###   and one artifact
###
# Do we need a way to turn off deployments? i.e. cancel (temporarily or not) all 'current's?
# add build/deploy job and runbook URLs for reference?
DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `application_id`         mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `application_name`       varchar(200) COLLATE utf8_bin NOT NULL,
  `nodegroup`              char(20) COLLATE utf8_bin NOT NULL,
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

###
### TABLE: applications_audit
###   This audit trail for applications
###
DROP TABLE IF EXISTS `applications_audit`;
CREATE TABLE `applications_audit` (
  `id`                     mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `application_id`         mediumint(9) UNSIGNED NOT NULL,
  `application_name`       varchar(200) COLLATE utf8_bin NOT NULL,
  `nodegroup`              char(20) COLLATE utf8_bin NOT NULL,
  `user`                   varchar(200) COLLATE utf8_bin NOT NULL,
  `updated`                timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DELIMITER //
CREATE TRIGGER applications_trigger_insert AFTER INSERT ON applications
FOR EACH ROW BEGIN
INSERT INTO applications_audit(application_id,application_name,nodegroup,user,updated) VALUES (NEW.application_id,NEW.application_name,NEW.nodegroup,NEW.user,NEW.updated);
END //

CREATE TRIGGER applications_trigger_update AFTER UPDATE ON applications
FOR EACH ROW BEGIN
   IF NEW.updated <> OLD.updated THEN
      INSERT INTO applications_audit(application_id,application_name,nodegroup,user,updated) VALUES (NEW.application_id,NEW.application_name,NEW.nodegroup,NEW.user,NEW.updated);
   END IF;
END //

DELIMITER ;

### 
### TABLE: deploys
###   This contains metadata for the actual artifact files.
###
DROP TABLE IF EXISTS `deploys`;
CREATE TABLE `deploys` (
  `deploy_id`              mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `application_id`         mediumint(9) UNSIGNED NOT NULL,
  `artifact_type_id`       mediumint(9) UNSIGNED NOT NULL,
  `package_name`           char(100) COLLATE utf8_bin,    # Required for deploys that are deployed using a native package management tool (yum, pip, apt, etc.)
  `deploy_path`            char(100) COLLATE utf8_bin NOT NULL,    # this also stands in for human-readable name!
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

###
### TABLE: deploys_audit
###   This audit trail for deploys
###
DROP TABLE IF EXISTS `deploys_audit`;
CREATE TABLE `deploys_audit` (
  `id`                     mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `deploy_id`              mediumint(9) UNSIGNED NOT NULL,
  `application_id`         mediumint(9) UNSIGNED NOT NULL,
  `artifact_type_id`       mediumint(9) UNSIGNED NOT NULL,
  `package_name`           char(100) COLLATE utf8_bin,    # Required for deploys that are deployed using a native package management tool (yum, pip, apt, etc.)
  `deploy_path`            char(100) COLLATE utf8_bin NOT NULL,    # this also stands in for human-readable name!
  `user`                   varchar(200) COLLATE utf8_bin NOT NULL,
  `updated`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DELIMITER //
CREATE TRIGGER deploys_trigger_insert AFTER INSERT ON deploys
FOR EACH ROW BEGIN
INSERT INTO deploys_audit(deploy_id,application_id,artifact_type_id,package_name,deploy_path,user,updated) VALUES (NEW.deploy_id,NEW.application_id,NEW.artifact_type_id,NEW.package_name,NEW.deploy_path,NEW.user,NEW.updated);
END //

CREATE TRIGGER deploys_trigger_update AFTER UPDATE ON deploys
FOR EACH ROW BEGIN
   IF NEW.updated <> OLD.updated THEN
      INSERT INTO deploys_audit(deploy_id,application_id,artifact_type_id,package_name,deploy_path,user,updated) VALUES (NEW.deploy_id,NEW.application_id,NEW.artifact_type_id,NEW.package_name,NEW.deploy_path,NEW.user,NEW.updated);
   END IF;
END //

DELIMITER ;

### 
### TABLE: artifacts
###   This contains metadata for the actual artifact files.
###
DROP TABLE IF EXISTS `artifacts`;
CREATE TABLE `artifacts` (
  `artifact_id`            mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `repo_id`                mediumint(9) UNSIGNED NOT NULL,
  `location`               varchar(250) COLLATE utf8_bin NOT NULL ,  # was 500, but too long for index!
  `revision`               varchar(45), # usually NULL
  `branch`                 varchar(80), # usually NULL
  `valid`                  tinyint UNSIGNED NOT NULL DEFAULT 1,
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE UNIQUE INDEX idx_artifact_unique on artifacts (location, revision);

### 
### TABLE: artifact_assignments
###   This is the central table. It is the central join table, as well as the log of 
###   promotion activity. Sorting it by date desc and filtering by application, lifecycle
###   and env (where the artifact is still active) allows you to determine the current
###   (row 1) and rollback (row 2).
###
DROP TABLE IF EXISTS `artifact_assignments`;
CREATE TABLE `artifact_assignments` (
  `artifact_assignment_id` mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `deploy_id`              mediumint(9) UNSIGNED NOT NULL,
  `env_id`                 mediumint(9) UNSIGNED NOT NULL,
  `lifecycle_id`           mediumint(9) UNSIGNED NOT NULL,
  `artifact_id`            mediumint(9) UNSIGNED NOT NULL,
  `user`                   varchar(30) NOT NULL, # this could be/become a FK
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE INDEX idx_deploy_search on artifact_assignments (deploy_id, env_id, lifecycle_id);


### 
### TABLE: artifact_notes
###   Each artifact can have one or more notes, entered either by users or
###   automatically by one system or another (imagine gathering and injecting
###   performance data per build and saving with the artifact!)
###
DROP TABLE IF EXISTS `artifact_notes`;
CREATE TABLE `artifact_notes` (
  `artifact_note_id`       mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `artifact_id`            mediumint(9) UNSIGNED NOT NULL,
  `user`                   varchar(30) NOT NULL, # this could be/become a FK
  `note`                   varchar(255) NOT NULL,
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

#*#*#
##### REFERENCE TABLES
#*#*#

### 
### TABLE: lifecycles
###   This contains definitions of lifecycle states. Just 'init' and 'current' for now.
###
DROP TABLE IF EXISTS `lifecycles`;
CREATE TABLE `lifecycles` (
  `lifecycle_id`          mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name`                  char(20) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

### 
### TABLE: envs
###   This contains definitions of environment (ct_env) values.
###
DROP TABLE IF EXISTS `envs`;
CREATE TABLE `envs` (
  `env_id`                mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name`                  char(3) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

### 
### TABLE: repos
###   This contains definitions of repository types. Each type is handled differently by
###   the deploy script.
###
DROP TABLE IF EXISTS `repos`;
CREATE TABLE `repos` (
  `repo_id`               mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `repo_type_id`          mediumint(9) UNSIGNED NOT NULL,
  `name`                  varchar(25) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

### 
### TABLE: repo_types
###   This contains definitions of repository types. The types are used to determine 
###   how the deploy script fetches the artifact.
###
DROP TABLE IF EXISTS `repo_types`;
CREATE TABLE `repo_types` (
  `repo_type_id`          mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name`                  varchar(25) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

### 
### TABLE: artifact_types
###   This contains definitions of artifact types. The types are used to determine
###   how the deploy script handles the artifact.
###
DROP TABLE IF EXISTS `artifact_types`;
CREATE TABLE `artifact_types` (
  `artifact_type_id`      mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name`                  varchar(25) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

### 
### TABLE: repo_urls
###   This contains datacenter-specific repository information
###
# # # Should we make this name-value pairs per ct_loc? # # #
DROP TABLE IF EXISTS `repo_urls`;
CREATE TABLE `repo_urls` (
  `repo_url_id`           mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `repo_id`               mediumint(9) UNSIGNED NOT NULL,
  `ct_loc`                char(4) COLLATE utf8_bin NOT NULL,
  `url`                   varchar(75) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
CREATE UNIQUE INDEX idx_repo_url_unique on repo_urls (repo_id, ct_loc);

### 
### TABLE: groups
###   This maps groups to roles
###
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id`               mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_name`             varchar(250) COLLATE utf8_bin NOT NULL,
  `user`                   varchar(200) COLLATE utf8_bin NOT NULL,
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE UNIQUE INDEX idx_group_name_unique on groups (group_name);

###
### TABLE: group_permissions
###   This contains metadata for the actual artifact files.
###
DROP TABLE IF EXISTS `group_perms`;
CREATE TABLE `group_perms` (
  `perm_id`                mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `perm_name`               varchar(250) COLLATE utf8_bin NOT NULL ,  # was 500, but too long for index!
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE UNIQUE INDEX idx_group_perms_unique on group_perms (perm_name);

###
### TABLE: group_assignments
###   This is the central table. It is the central join table, as well as the log of
###   promotion activity. Sorting it by date desc and filtering by application, lifecycle
###   and env (where the artifact is still active) allows you to determine the current
###   (row 1) and rollback (row 2).
###
DROP TABLE IF EXISTS `group_assignments`;
CREATE TABLE `group_assignments` (
  `group_assignment_id`    mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_id`               mediumint(9) UNSIGNED NOT NULL,
  `perm_id`                mediumint(9) UNSIGNED NOT NULL,
  `user`                   varchar(30) NOT NULL, # this could be/become a FK
  `created`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

###
### TABLE: group_assignments_audit
###   This audit trail for group_assignments
###
DROP TABLE IF EXISTS `group_assignments_audit`;
CREATE TABLE `group_assignments_audit` (
  `id`                     mediumint(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_assignment_id`    mediumint(9) UNSIGNED NOT NULL,
  `group_id`               mediumint(9) UNSIGNED NOT NULL,
  `perm_id`                mediumint(9) UNSIGNED NOT NULL,
  `user`                   varchar(30) NOT NULL,
  `updated`                timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted`                tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DELIMITER //
CREATE TRIGGER ga_trigger_insert AFTER INSERT ON group_assignments
FOR EACH ROW BEGIN
INSERT INTO group_assignments_audit(group_assignment_id,group_id,perm_id,user,updated,deleted) VALUES (NEW.group_assignment_id,NEW.group_id,NEW.perm_id,NEW.user,NEW.updated, '0');
END //

CREATE TRIGGER ga_trigger_update AFTER UPDATE ON group_assignments
FOR EACH ROW BEGIN
   IF NEW.updated <> OLD.updated THEN
      INSERT INTO group_assignments_audit(group_assignment_id,group_id,perm_id,user,updated,deleted) VALUES (NEW.group_assignment_id,NEW.group_id,NEW.perm_id,NEW.user,NEW.updated, '0');
   END IF;
END //

DELIMITER //
CREATE TRIGGER ga_trigger_delete BEFORE DELETE ON group_assignments
FOR EACH ROW BEGIN
INSERT INTO group_assignments_audit(group_assignment_id,group_id,perm_id,user,updated,deleted) VALUES (OLD.group_assignment_id,OLD.group_id,OLD.perm_id,OLD.user,NOW(), '1');
END //

DELIMITER ;
