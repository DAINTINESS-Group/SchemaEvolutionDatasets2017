####################
# TABLES
####################

-- Remove old schema tables
DROP TABLE IF EXISTS `t_lookup_request`;
DROP TABLE IF EXISTS `t_source_file`;
DROP TABLE IF EXISTS `t_subscription_file`;
DROP TABLE IF EXISTS `t_site_source`;
DROP TABLE IF EXISTS `t_active_transfer`;
DROP TABLE IF EXISTS `t_callback_entry`;

DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE `schema_version` (
    `version` VARCHAR(36) NOT NULL,
    `installationdate` DATETIME DEFAULT NULL
);
INSERT INTO `schema_version` (`version`, `installationdate`) VALUES ('0_6_0', NOW());

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

DROP TABLE IF EXISTS `t_blacklist`;
CREATE TABLE `t_blacklist` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `blacklisted` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_callback`;
CREATE TABLE `t_callback` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `protocol` VARCHAR(10) NOT NULL,
    `host` VARCHAR(50) DEFAULT '',
    `url` VARCHAR(255) DEFAULT '',
    `creationdate` DATETIME DEFAULT NULL,
    `attemptnr` MEDIUMINT DEFAULT 1,
    `event` BLOB DEFAULT NULL,
    PRIMARY KEY(`id`),
    INDEX (`protocol`, `host`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_transfer_request`;
CREATE TABLE `t_transfer_request` (
    `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) DEFAULT NULL,    
    `toolid` VARCHAR(20) DEFAULT NULL,
    `transferchannel` VARCHAR(1024) DEFAULT NULL,
    `transferparameters` VARCHAR(1024) DEFAULT NULL,    
    `transferid` VARCHAR(36) DEFAULT NULL,
    `transfercheckdate` DATETIME DEFAULT NULL,
    `report`  TEXT DEFAULT NULL,
    PRIMARY KEY(`id`),
    INDEX (`state`, `sourcesiteid`, `siteid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `state` TINYINT NOT NULL DEFAULT 0,
    `lfn` VARCHAR(512) NOT NULL,
    `fsize` BIGINT DEFAULT NULL,
    `checksum` VARCHAR(100) DEFAULT NULL,
    `dsn` VARCHAR(512) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `archival` TINYINT(1) NOT NULL,
    `destbasepath` VARCHAR(1024) DEFAULT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `sourcesurl` VARCHAR(1024) NOT NULL,
    `toolid` VARCHAR(20) NOT NULL,
    `transferchannel` VARCHAR(1024) NOT NULL,
    `creationdate` DATETIME NOT NULL,
    `modificationdate` DATETIME NOT NULL,
    `pickupdate` DATETIME DEFAULT NULL,
    `attemptnr` MEDIUMINT NOT NULL DEFAULT 1,    

    `destsurl` VARCHAR(1024) DEFAULT NULL,

    `requestid` MEDIUMINT DEFAULT NULL,
    `active` TINYINT(1) NOT NULL DEFAULT 0,
    `transfersucceeded` TINYINT(1) NOT NULL DEFAULT 0,
    `report`  TEXT DEFAULT NULL,

    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`requestid`),
    INDEX (`state`, `sourcesiteid`, `siteid`, `share`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription`;
CREATE TABLE `t_subscription` (
    `uid` VARCHAR(36) NOT NULL,
    `duid` VARCHAR(36) DEFAULT NULL,
    `vuid` VARCHAR(36) DEFAULT NULL,
    `previousvuids` TEXT DEFAULT NULL,			# HACK: contains a python list as value
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` SMALLINT DEFAULT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `datasetowner` VARCHAR(1024) DEFAULT NULL,
    `files` LONGTEXT DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,
    `timestamp` VARCHAR(50) NOT NULL,            # this timestamp is string from subscription catalogue and not real date/time
    PRIMARY KEY (`uid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription_files_in_transfer`;
CREATE TABLE `t_subscription_files_in_transfer` (
    `siteid` VARCHAR(50) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `uid` VARCHAR(36) NOT NULL,
	`sourcesiteid` VARCHAR(50) NOT NULL, 
    PRIMARY KEY (`siteid`, `guid`, `uid`),
    INDEX (`uid`, `siteid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_bad_file`;
CREATE TABLE `t_bad_file` (
    `siteid` VARCHAR(50) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `surl` VARCHAR(1024) DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`siteid`, `guid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_bad_transfer`;
CREATE TABLE `t_bad_transfer` (
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `attemptnr` MEDIUMINT NOT NULL DEFAULT 1,    
    PRIMARY KEY (`source`, `destination`, `guid`)
) ENGINE=InnoDB;

####################
# TABLES filled by TRIGGERS
####################

DROP TABLE IF EXISTS `t_nr_callbacks`;
CREATE TABLE `t_nr_callbacks` (
    `protocol` VARCHAR(10) NOT NULL,
    `host` VARCHAR(50) NOT NULL,
	`counter` MEDIUMINT NOT NULL DEFAULT 0,
	PRIMARY KEY (`protocol`, `host`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_nr_files_in_queue`;
CREATE TABLE `t_nr_files_in_queue` (
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `counter` MEDIUMINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`source`, `destination`, `share`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_nr_files_in_transfer`;
CREATE TABLE `t_nr_files_in_transfer` (
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `counter` MEDIUMINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`source`, `destination`, `share`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_nr_requests_to_submit`;
CREATE TABLE `t_nr_requests_to_submit` (
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `counter` MEDIUMINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`source`, `destination`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_nr_requests_to_poll`;
CREATE TABLE `t_nr_requests_to_poll` (
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `counter` MEDIUMINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`source`, `destination`)
) ENGINE=InnoDB;


####################
# STORED PROCEDURES
####################

-- Remove old schema procedures
DROP PROCEDURE IF EXISTS drop_subscription_file_done;
DROP PROCEDURE IF EXISTS handle_done_files;
DROP PROCEDURE IF EXISTS drop_subscription_file_hold;
DROP PROCEDURE IF EXISTS handle_hold_files;

####################
# TRIGGERS
####################

-- Remove old schema triggers
DROP TRIGGER IF EXISTS t_file_before_update;
DROP TRIGGER IF EXISTS t_file_delete;
DROP TRIGGER IF EXISTS t_subscription_delete;
DROP TRIGGER IF EXISTS t_subscription_file_insert;
DROP TRIGGER IF EXISTS t_subscription_file_delete;

DELIMITER //

DROP TRIGGER IF EXISTS t_callback_insert;//
CREATE TRIGGER t_callback_insert AFTER INSERT ON t_callback
    FOR EACH ROW
    BEGIN
        INSERT INTO t_nr_callbacks (protocol, host, counter) VALUES (NEW.protocol, NEW.host, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
    END;//

DROP TRIGGER IF EXISTS t_callback_delete;//
CREATE TRIGGER t_callback_delete AFTER DELETE ON t_callback
    FOR EACH ROW
    BEGIN
    	INSERT INTO t_nr_callbacks (protocol, host, counter) VALUES (OLD.protocol, OLD.host, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
    END;//

DROP TRIGGER IF EXISTS t_subscription_files_in_transfer_insert;//
CREATE TRIGGER t_subscription_files_in_transfer_insert AFTER INSERT ON t_subscription_files_in_transfer
    FOR EACH ROW
    BEGIN
    	UPDATE t_file SET counter=counter+1 WHERE guid=NEW.guid AND siteid=NEW.siteid;
    END;//

DROP TRIGGER IF EXISTS t_subscription_files_in_transfer_delete;//
CREATE TRIGGER t_subscription_files_in_transfer_delete AFTER DELETE ON t_subscription_files_in_transfer
    FOR EACH ROW
    BEGIN
    	-- Set file to state failed if state is in queue or in transfer and counter drops to zero
    	-- Also sets 'requestid' to NULL if was in transfer
		UPDATE t_file SET counter=IF(t_file.counter>0,t_file.counter-1,0),requestid=IF(t_file.counter=0 AND t_file.state=1,NULL,requestid),state=IF(t_file.state in (0,1) AND t_file.counter=0,3,t_file.state) WHERE guid=OLD.guid AND siteid=OLD.siteid;
    END;//
    
DROP TRIGGER IF EXISTS t_file_insert;//
CREATE TRIGGER t_file_insert AFTER INSERT ON t_file
    FOR EACH ROW
    BEGIN
        INSERT INTO t_nr_files_in_queue (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
    END;//

DROP TRIGGER IF EXISTS t_file_after_update;//
CREATE TRIGGER t_file_after_update AFTER UPDATE ON t_file
    FOR EACH ROW
    BEGIN
        -- File moved from in queue to in transfer
        IF OLD.state=0 AND NEW.state=1 THEN
            INSERT INTO t_nr_files_in_queue (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
            INSERT INTO t_nr_files_in_transfer (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        -- File moved from in transfer to in registration
        ELSEIF OLD.state=1 AND NEW.state=2 THEN
            INSERT INTO t_nr_files_in_transfer (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;        
        -- File moved from in transfer to failed
        ELSEIF OLD.state=1 AND NEW.state=3 THEN
            INSERT INTO t_nr_files_in_transfer (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;        
        -- File moved from failed to in queue
        ELSEIF OLD.state=3 AND NEW.state=0 THEN
            INSERT INTO t_nr_files_in_queue (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
	    -- File moved from in queue to failed (c.f. t_subscription_files_in_transfer_delete trigger)
        ELSEIF OLD.state=0 AND NEW.state=3 THEN
            INSERT INTO t_nr_files_in_queue (source, destination, share, counter) VALUES (NEW.sourcesiteid, NEW.siteid, NEW.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_file_delete;//
CREATE TRIGGER t_file_delete AFTER DELETE ON t_file
    FOR EACH ROW
    BEGIN
        -- File was in queue
        IF OLD.state=0 THEN
            INSERT INTO t_nr_files_in_queue (source, destination, share, counter) VALUES (OLD.sourcesiteid, OLD.siteid, OLD.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
        -- File was in transfer
        ELSEIF OLD.state=1 THEN
            INSERT INTO t_nr_files_in_transfer (source, destination, share, counter) VALUES (OLD.sourcesiteid, OLD.siteid, OLD.share, 0) ON DUPLICATE KEY UPDATE counter=counter-1;        
        END IF;
    END;//
    
DROP TRIGGER IF EXISTS t_transfer_request_insert;//
CREATE TRIGGER t_transfer_request_insert AFTER INSERT ON t_transfer_request
    FOR EACH ROW
    BEGIN
        INSERT INTO t_nr_requests_to_submit (source, destination) VALUES (NEW.sourcesiteid, NEW.siteid) ON DUPLICATE KEY UPDATE counter=counter+1;
    END;//

DROP TRIGGER IF EXISTS t_transfer_request_after_update;//
CREATE TRIGGER t_transfer_request_after_update AFTER UPDATE ON t_transfer_request
    FOR EACH ROW
    BEGIN
        -- Transfer request moved from to submit to poll
        IF OLD.state=0 AND NEW.state=1 THEN
            INSERT INTO t_nr_requests_to_submit (source, destination, counter) VALUES (NEW.sourcesiteid, NEW.siteid, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
            INSERT INTO t_nr_requests_to_poll (source, destination) VALUES (NEW.sourcesiteid, NEW.siteid) ON DUPLICATE KEY UPDATE counter=counter+1;
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_transfer_request_delete;//
CREATE TRIGGER t_transfer_request_delete AFTER DELETE ON t_transfer_request
    FOR EACH ROW
    BEGIN
        -- Transfer request was in to poll
        IF OLD.state=0 THEN
            INSERT INTO t_nr_requests_to_submit (source, destination, counter) VALUES (OLD.sourcesiteid, OLD.siteid, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
        -- Transfer request was in to submit
        ELSEIF OLD.state=1 THEN
            INSERT INTO t_nr_requests_to_poll (source, destination, counter) VALUES (OLD.sourcesiteid, OLD.siteid, 0) ON DUPLICATE KEY UPDATE counter=counter-1;
        END IF;
    END;//

DELIMITER ;

####################
# EVENTS
####################

-- Remove old schema events
DROP EVENT IF EXISTS `event_handle_done_files`;
DROP EVENT IF EXISTS `event_handle_hold_files`;
DROP EVENT IF EXISTS `event_release_subscription`;
DROP EVENT IF EXISTS `event_release_lookup_request`;
DROP EVENT IF EXISTS `event_clean_t_fsize_distribution`;

DROP EVENT IF EXISTS `event_release_transfer_request`;
CREATE EVENT `event_release_transfer_request`
    ON SCHEDULE EVERY 30 MINUTE
    DO UPDATE t_transfer_request SET locked=0
        WHERE modificationdate < DATE_SUB(NOW(), INTERVAL 1 HOUR);

---------------
-- Events to clean tables from deprecated entries
---------------

DROP EVENT IF EXISTS `event_clean_file_counters`;

DELIMITER //
DROP EVENT IF EXISTS `event_clean_counters`;//
CREATE EVENT `event_clean_counters`
    ON SCHEDULE EVERY 15 MINUTE
    DO
    BEGIN
    	DELETE FROM t_nr_callbacks WHERE counter<=0;
        DELETE FROM t_nr_files_in_queue WHERE counter<=0;
        DELETE FROM t_nr_files_in_transfer WHERE counter<=0;
    END;//

DELIMITER ;
