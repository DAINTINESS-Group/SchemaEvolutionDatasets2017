####################
# TABLES
####################

-- Remove old schema tables
DROP TABLE IF EXISTS `t_agent`;
DROP TABLE IF EXISTS `t_lookup_request`;
DROP TABLE IF EXISTS `t_source_file`;
DROP TABLE IF EXISTS `t_subscription_file`;
DROP TABLE IF EXISTS `t_site_source`;
DROP TABLE IF EXISTS `t_active_transfer`;
DROP TABLE IF EXISTS `t_callback_entry`;
DROP TABLE IF EXISTS `t_nr_callbacks`;
DROP TABLE IF EXISTS `t_nr_files_in_queue`;
DROP TABLE IF EXISTS `t_nr_files_in_transfer`;
DROP TABLE IF EXISTS `t_nr_files_in_registration`;
DROP TABLE IF EXISTS `t_nr_requests_to_submit`;
DROP TABLE IF EXISTS `t_nr_requests_to_poll`;

DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE `schema_version` (
    `version` VARCHAR(36) NOT NULL,
    `installationdate` DATETIME DEFAULT NULL
);
INSERT INTO `schema_version` (`version`, `installationdate`) VALUES ('1_0_0', NOW());

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
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) DEFAULT NULL,    
    `toolid` VARCHAR(20) DEFAULT NULL,
    `transferchannel` VARCHAR(512) DEFAULT NULL,
    `transferparameters` VARCHAR(1024) DEFAULT NULL,    
    `transferid` VARCHAR(36) DEFAULT NULL,
    `transfercheckdate` DATETIME DEFAULT NULL,
    `nfiles` MEDIUMINT NOT NULL DEFAULT 0,    
    PRIMARY KEY(`id`),
    INDEX (`state`, `sourcesiteid`, `siteid`, `toolid`, `transferchannel`)
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
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `sourcesurl` VARCHAR(1024) NOT NULL,
    `toolid` VARCHAR(20) NOT NULL,
    `transferchannel` VARCHAR(512) DEFAULT NULL,
    `creationdate` DATETIME NOT NULL,
    `modificationdate` DATETIME NOT NULL,
    `transferstartdate` DATETIME NOT NULL,    
    `attemptnr` MEDIUMINT NOT NULL DEFAULT 1,    
    `destsurl` VARCHAR(1024) DEFAULT NULL,
    `requestid` MEDIUMINT DEFAULT NULL,
    `transfersucceeded` TINYINT(1) NOT NULL DEFAULT 0,
    `report` VARCHAR(1024) DEFAULT NULL,    
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
    `filestimestamp` DATETIME DEFAULT NULL,
    `timestamp` VARCHAR(50) DEFAULT NULL,            # this timestamp is string from subscription catalogue and not real date/time
    PRIMARY KEY (`uid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_file_catalog_cache`;
CREATE TABLE `t_file_catalog_cache` (
    `uid` VARCHAR(36) NOT NULL,
    `endpoint` VARCHAR(255) NOT NULL,
    `files` LONGTEXT DEFAULT NULL,
    `timestamp` DATETIME DEFAULT NULL,
    PRIMARY KEY (`uid`, `endpoint`)
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
DROP TRIGGER IF EXISTS t_callback_insert;
DROP TRIGGER IF EXISTS t_callback_delete;
DROP TRIGGER IF EXISTS t_file_insert;
DROP TRIGGER IF EXISTS t_file_delete;
DROP TRIGGER IF EXISTS t_transfer_request_insert;
DROP TRIGGER IF EXISTS t_transfer_request_after_update;
DROP TRIGGER IF EXISTS t_transfer_request_delete;

DELIMITER //

DROP TRIGGER IF EXISTS t_file_after_update;//
CREATE TRIGGER t_file_after_update AFTER UPDATE ON t_file
    FOR EACH ROW
    BEGIN
        IF OLD.state=1 AND NEW.state=2 THEN
            INSERT INTO t_history_file_transfer (starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.transferstartdate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 1, NEW.report, NOW());
        ELSEIF OLD.state=1 AND NEW.state=3 THEN
            INSERT INTO t_history_file_transfer (starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.transferstartdate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 0, NEW.report, NOW());
        END IF;
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
    	-- Also sets 'requestid' and 'report' to NULL if was in transfer
		UPDATE t_file SET counter=IF(t_file.counter>0,t_file.counter-1,0),requestid=IF(t_file.counter=0 AND t_file.state=1,NULL,requestid),report=IF(t_file.counter=0 AND t_file.state=1,NULL,report),state=IF(t_file.state in (0,1) AND t_file.counter=0,3,t_file.state) WHERE guid=OLD.guid AND siteid=OLD.siteid;
    END;//

DROP TRIGGER IF EXISTS t_transfer_request_delete;//
CREATE TRIGGER t_transfer_request_delete AFTER DELETE ON t_transfer_request
    FOR EACH ROW
    BEGIN
        INSERT INTO t_history_transfer_request_duration (startdate, enddate, nfiles, siteid, sourcesiteid, creationdate) VALUES (OLD.creationdate, NOW(), OLD.nfiles, OLD.siteid, OLD.sourcesiteid, NOW());
    END;//

DELIMITER ;

####################
# HISTORY TABLES
####################

DROP TABLE IF EXISTS `t_history_files_in_queue`;
CREATE TABLE `t_history_files_in_queue` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_files_in_transfer`;
CREATE TABLE `t_history_files_in_transfer` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_files_in_registration`;
CREATE TABLE `t_history_files_in_registration` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_callbacks`;
CREATE TABLE `t_history_callbacks` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `protocol` VARCHAR(10) NOT NULL,
    `host` VARCHAR(50) DEFAULT '',
    `creationdate` DATETIME DEFAULT NULL    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_requests_submitting`;
CREATE TABLE `t_history_transfer_requests_submitting` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_requests_pending`;
CREATE TABLE `t_history_transfer_requests_pending` (
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_file_transfer`;
CREATE TABLE `t_history_file_transfer` (
    `startpreparationdate` DATETIME DEFAULT NULL,
    `endpreparationdate` DATETIME DEFAULT NULL,
    `starttransferdate` DATETIME DEFAULT NULL,
    `endtransferdate` DATETIME DEFAULT NULL,
	`startfinalizaiondate` DATETIME DEFAULT NULL,
    `endfinalizationdate` DATETIME DEFAULT NULL,
    `toolid` VARCHAR(20) DEFAULT NULL,
    `fsize` BIGINT DEFAULT NULL,
    `dsn` VARCHAR(512) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
	`success` TINYINT(1) NOT NULL DEFAULT 0,
	`report` VARCHAR(1024) DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_request_duration`;
CREATE TABLE `t_history_transfer_request_duration` (
    `startdate` DATETIME DEFAULT NULL,
    `enddate` DATETIME DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,  
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL    
) ENGINE=MyISAM;

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
DROP EVENT IF EXISTS `event_clean_t_active_transfer`;
DROP EVENT IF EXISTS `event_clean_t_file`;
DROP EVENT IF EXISTS `event_clean_t_site_source`;
DROP EVENT IF EXISTS `event_clean_file_counters`;
DROP EVENT IF EXISTS `event_clean_counters`;

DELIMITER //

DROP EVENT IF EXISTS `event_monitor`;//
CREATE EVENT `event_monitor`
    ON SCHEDULE EVERY 5 MINUTE
    DO
    BEGIN
        INSERT INTO t_history_files_in_queue SELECT COUNT(*), siteid, sourcesiteid, share, NOW() FROM t_file WHERE state=0 GROUP BY sourcesiteid, siteid, share;
        INSERT INTO t_history_files_in_transfer SELECT COUNT(*), siteid, sourcesiteid, share, NOW() FROM t_file WHERE state=1 GROUP BY sourcesiteid, siteid, share;
        INSERT INTO t_history_files_in_registration SELECT COUNT(*), siteid, NOW() FROM t_file WHERE state=2 GROUP BY siteid;
        INSERT INTO t_history_callbacks SELECT COUNT(*), protocol, host, NOW() FROM t_callback GROUP BY protocol, host;
        INSERT INTO t_history_transfer_requests_submitting SELECT COUNT(*), siteid, sourcesiteid, NOW() FROM t_transfer_request WHERE state=0 GROUP BY sourcesiteid, siteid;
        INSERT INTO t_history_transfer_requests_pending SELECT COUNT(*), siteid, sourcesiteid, NOW() FROM t_transfer_request WHERE state=1 GROUP BY sourcesiteid, siteid;
    END;//

DELIMITER ;


    