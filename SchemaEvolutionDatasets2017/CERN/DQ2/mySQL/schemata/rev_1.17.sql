####################
# TABLES
####################

DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE `schema_version` (
    `version` VARCHAR(36) NOT NULL
);
INSERT INTO `schema_version` (`version`) VALUES ('0_4_0');

DROP TABLE IF EXISTS `t_agent`;
CREATE TABLE `t_agent` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `family` VARCHAR(36) NOT NULL DEFAULT '',
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    `alivedate` DATETIME DEFAULT NULL,
    `crashreport` TEXT DEFAULT NULL,
    `pid` SMALLINT DEFAULT NULL,
    `stop` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_callback_entry`;
CREATE TABLE `t_callback_entry` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(255) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    `type` VARCHAR(36) NOT NULL DEFAULT '',
    `attemptnr` MEDIUMINT DEFAULT 0,
    `lastattemptdate` DATETIME DEFAULT NULL,
    `event` MEDIUMTEXT DEFAULT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_lookup_request`;
CREATE TABLE `t_lookup_request` (
    `siteid` VARCHAR(20) NOT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `locked` TINYINT(1) NOT NULL DEFAULT 0,    
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    PRIMARY KEY(`siteid`),
    INDEX (`modificationdate`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_transfer_request`;
CREATE TABLE `t_transfer_request` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `state` TINYINT NOT NULL DEFAULT 0,
    `locked` TINYINT(1) NOT NULL DEFAULT 0,    
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `toolid` VARCHAR(20) DEFAULT NULL,
    `transferchannel` VARCHAR(1024) DEFAULT NULL,
    `transferid` VARCHAR(36) DEFAULT NULL,
    `transfercheckdate` DATETIME DEFAULT NULL,
    `report`  TEXT DEFAULT NULL,
    PRIMARY KEY(`id`),
    INDEX (`modificationdate`),
    INDEX (`state`, `siteid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
    `counter` BIGINT(4) NOT NULL DEFAULT 0,
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `requestid` MEDIUMINT DEFAULT NULL,
    `lfn` VARCHAR(512) NOT NULL,
    `fsize` BIGINT DEFAULT NULL,
    `checksum` VARCHAR(100) DEFAULT NULL,
    `dsn` VARCHAR(512) NOT NULL,
    `sshare` VARCHAR(36) NOT NULL,
    `archival` TINYINT(1) NOT NULL,
    `waitforsources` TINYINT(1) NOT NULL,
    `querymoresources` TINYINT(1) NOT NULL,
    `destsurl` VARCHAR(1024) DEFAULT NULL,
    `allocationattemptnr` INT NOT NULL DEFAULT 0,
    `attemptnr` TINYINT NOT NULL DEFAULT 0,
    `available` TINYINT(1) NOT NULL DEFAULT 0,
    `holdstate` TINYINT NOT NULL DEFAULT 0,
    `holdreason` TEXT DEFAULT NULL,
    `sourcesiteid` VARCHAR(20) DEFAULT NULL,
    `sourcesurl` VARCHAR(1024) DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,    
    `pickupdate` DATETIME DEFAULT NULL,
    `active` TINYINT(1) NOT NULL DEFAULT 0,
    `transfersucceeded` TINYINT(1) NOT NULL DEFAULT 0,
    `report`  TEXT DEFAULT NULL,
    `transferstate` TINYINT DEFAULT NULL,             # Replicated from t_transfer_request to speed-up monitoring
    `toolid` VARCHAR(20) DEFAULT NULL,                # Replicated from t_transfer_request to speed-up monitoring
    `transferchannel` VARCHAR(1024) DEFAULT NULL,     # Replicated from t_transfer_request to speed-up monitoring
    `transferid` VARCHAR(36) DEFAULT NULL,            # Replicated from t_transfer_request to speed-up monitoring
    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`requestid`),
    INDEX (`counter`),
    INDEX (`state`, `sourcesiteid`, `siteid`, `sshare`),
    INDEX (`state`, `siteid`, `allocationattemptnr`)  # Only useful for getFilesToAllocate(..)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_source_file`;
CREATE TABLE `t_source_file` (
    `creationdate` DATETIME DEFAULT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `lfn` VARCHAR(512) NOT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `surl` VARCHAR(1024) DEFAULT NULL,
    `fsize` BIGINT DEFAULT NULL,
    `checksum` VARCHAR(100) DEFAULT NULL,
    `transferattemptnr` TINYINT NOT NULL DEFAULT 0,
    `lookupattemptnr` TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`state`, `siteid`)    
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription_file`;
DROP TABLE IF EXISTS `t_subscription`;
CREATE TABLE `t_subscription` (
    `uid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `vuid` VARCHAR(36) DEFAULT NULL,
    `duid` VARCHAR(36) DEFAULT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` TINYINT DEFAULT NULL,
    `previousvuids` TEXT DEFAULT NULL,			# HACK: contains a python list as value
    `queuedsources` TEXT DEFAULT NULL,			# HACK: contains a python list as value
    `state` TINYINT NOT NULL DEFAULT 0,
    `locked` TINYINT(1) NOT NULL DEFAULT 0,    
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    `sshare` VARCHAR(36) NOT NULL,
    `cancelled` TINYINT(1) NOT NULL DEFAULT 0,
    `timestamp` VARCHAR(50) NOT NULL,            # this timestamp is string from subscription catalogue and not real date/time
    `destination` VARCHAR(1024) DEFAULT NULL,
    `datasetowner` VARCHAR(1024) DEFAULT NULL,
    `subscriptionowner` VARCHAR(1024) DEFAULT NULL,    
    `callbacks` TEXT DEFAULT NULL,               # HACK: contains a python dictionary as value
    `sourcespolicy` MEDIUMINT NOT NULL,
    `sources` TEXT DEFAULT NULL,                 # HACK: contains a python dictionary as value
    `archival` TINYINT(1) NOT NULL,
    `datasetstate` TINYINT NOT NULL DEFAULT 0,
    `waitforsources` TINYINT(1) NOT NULL,
    `querymoresources` TINYINT(1) NOT NULL,
    `contenttimestamp` VARCHAR(50) DEFAULT NULL, # this timestamp is string from content catalogue and not real date/time
    `activevuid` VARCHAR(36) DEFAULT NULL,
    `immutable` TINYINT(1) NOT NULL DEFAULT 0,
    `markedincomplete` TINYINT(1) NOT NULL DEFAULT 0,
    `markedcomplete` TINYINT(1) NOT NULL DEFAULT 0,
    `holdfiles` TINYINT(1) NOT NULL DEFAULT 0,
    `publishdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`uid`, `siteid`),
    INDEX (`modificationdate`),
    INDEX (`siteid`, `state`, `locked`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription_file`;
CREATE TABLE `t_subscription_file` (
    `uid` VARCHAR(36) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    FOREIGN KEY (`uid`, `siteid`) REFERENCES `t_subscription` (`uid`, `siteid`) ON DELETE CASCADE,
    PRIMARY KEY (`uid`, `guid`, `siteid`)
) ENGINE=InnoDB;

####################
# TEMPORARY TABLES (filled by TRIGGERS)
####################

DROP TABLE IF EXISTS `t_site_source`;
CREATE TABLE `t_site_source` (
    `siteid` VARCHAR(20) NOT NULL,
    `sourcesiteid` VARCHAR(20) NOT NULL,
    `counter` BIGINT(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`siteid`, `sourcesiteid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_active_transfer`;
CREATE TABLE `t_active_transfer` (
    `siteid` VARCHAR(20) NOT NULL,
    `sourcesiteid` VARCHAR(20) NOT NULL,
    `sshare` VARCHAR(36) NOT NULL,
    `counter` BIGINT(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`siteid`, `sourcesiteid`, `sshare`)
) ENGINE=InnoDB;

####################
# TRIGGERS
####################

DELIMITER //

DROP TRIGGER IF EXISTS t_file_counter_add;//
CREATE TRIGGER t_file_counter_add AFTER INSERT ON t_subscription_file
    FOR EACH ROW
    BEGIN
        UPDATE t_file SET counter=counter+1 WHERE guid=NEW.guid AND siteid=NEW.siteid;
    END;//

DROP TRIGGER IF EXISTS t_file_counter_remove;//
CREATE TRIGGER t_file_counter_remove AFTER DELETE ON t_subscription_file
    FOR EACH ROW
    BEGIN
        UPDATE t_file SET counter=counter-1 WHERE guid=OLD.guid AND siteid=OLD.siteid;
    END;//

DROP TRIGGER IF EXISTS t_file_counter;//
CREATE TRIGGER t_file_counter AFTER UPDATE ON t_file
    FOR EACH ROW
    BEGIN
        IF OLD.state!=2 AND NEW.state=2 THEN
            INSERT INTO t_site_source (siteid, sourcesiteid, counter) VALUES (NEW.siteid, NEW.sourcesiteid, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        END IF;
        IF OLD.state=2 AND NEW.state!=2 THEN
            UPDATE t_site_source SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid;
        END IF;
        IF OLD.state!=3 AND NEW.state=3 THEN
            INSERT INTO t_active_transfer (siteid, sourcesiteid, sshare, counter) VALUES (NEW.siteid, NEW.sourcesiteid, NEW.sshare, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        END IF;
        IF OLD.state=3 AND NEW.state!=3 THEN
            UPDATE t_active_transfer SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid AND sshare=OLD.sshare;
        END IF;
    END;//
    
DROP TRIGGER IF EXISTS t_source_file_updater; //
CREATE TRIGGER t_source_file_updater AFTER UPDATE ON t_source_file
   FOR EACH ROW
   BEGIN
       IF NEW.state=2 THEN
           UPDATE t_file SET state=1 WHERE guid=NEW.guid AND siteid=NEW.siteid AND state=0;
       END IF;
       IF OLD.creationdate!=NEW.creationdate AND NEW.state=2 THEN
           UPDATE t_file SET state=1 WHERE guid=NEW.guid AND siteid=NEW.siteid AND state=0;
       END IF;
   END;//

DELIMITER ;

####################
# EVENTS
####################
SET GLOBAL event_scheduler = 1;

---------------
-- Events to release hanged requests
---------------
DROP EVENT IF EXISTS `event_release_subscription`;
CREATE EVENT `event_release_subscription`
    ON SCHEDULE EVERY 30 MINUTE
    DO UPDATE t_subscription SET locked=0
        WHERE modificationdate < DATE_SUB(NOW(), INTERVAL 1 HOUR);

DROP EVENT IF EXISTS `event_release_lookup_request`;
CREATE EVENT `event_release_lookup_request`
    ON SCHEDULE EVERY 30 MINUTE
    DO UPDATE t_lookup_request SET locked=0
        WHERE modificationdate < DATE_SUB(NOW(), INTERVAL 1 HOUR);

DROP EVENT IF EXISTS `event_release_transfer_request`;
CREATE EVENT `event_release_transfer_request`
    ON SCHEDULE EVERY 30 MINUTE
    DO UPDATE t_transfer_request SET locked=0
        WHERE modificationdate < DATE_SUB(NOW(), INTERVAL 1 HOUR);

---------------
-- Events to clean tables from deprecated entries
---------------

DELIMITER //

DROP EVENT IF EXISTS `event_clean_t_file`;//
CREATE EVENT `event_clean_t_file`
    ON SCHEDULE EVERY 20 MINUTE
    DO
    BEGIN
        DELETE FROM t_file WHERE counter=0;
    END;//

DROP EVENT IF EXISTS `event_clean_t_site_source`;//
CREATE EVENT `event_clean_t_site_source`
    ON SCHEDULE EVERY 15 MINUTE
    DO
    BEGIN
        DELETE FROM t_site_source WHERE counter=0;
    END;//

DROP EVENT IF EXISTS `event_clean_t_active_transfer`;//
CREATE EVENT `event_clean_t_active_transfer`
    ON SCHEDULE EVERY 1 HOUR
    DO
    BEGIN
        DELETE FROM t_active_transfer WHERE counter=0;
    END;//

DELIMITER ;
