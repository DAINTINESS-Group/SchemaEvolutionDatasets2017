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
) ENGINE=MyISAM;
INSERT INTO `schema_version` (`version`, `installationdate`) VALUES ('1_0_2', NOW());

DROP TABLE IF EXISTS `t_monitor`;
CREATE TABLE `t_monitor` (
    `active` TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=Memory;

DROP TABLE IF EXISTS `t_blacklist`;
CREATE TABLE `t_blacklist` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `source` VARCHAR(50) NOT NULL,
    `destination` VARCHAR(50) NOT NULL,
    `blacklisted` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_callback`;
CREATE TABLE `t_callback` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
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
    `id` BIGINT NOT NULL AUTO_INCREMENT,
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
    `creationdate` DATETIME NOT NULL,
    `modificationdate` DATETIME NOT NULL,
    `transfersubmitdate` DATETIME DEFAULT NULL,    
    `transferstatedate` DATETIME DEFAULT NULL,
    `attemptnr` MEDIUMINT NOT NULL DEFAULT 1,    
    `destsurl` VARCHAR(1024) DEFAULT NULL,
    `requestid` BIGINT DEFAULT NULL,
    `active` TINYINT(1) NOT NULL DEFAULT 0,    
    `transfersucceeded` TINYINT(1) NOT NULL DEFAULT 0,
    `report` VARCHAR(1024) DEFAULT NULL,    
    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`requestid`),
    INDEX (`state`, `sourcesiteid`, `siteid`, `toolid`, `share`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription`;
CREATE TABLE `t_subscription` (
    `uid` VARCHAR(36) NOT NULL,
    `duid` VARCHAR(36) DEFAULT NULL,
    `vuid` VARCHAR(36) DEFAULT NULL,
    `previousvuids` TEXT DEFAULT NULL,			            # HACK: contains a python list as value
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` SMALLINT DEFAULT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `datasetowner` VARCHAR(1024) DEFAULT NULL,
    `files` LONGTEXT DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,
    `filestimestamp` DATETIME DEFAULT NULL,                 # this timestamp is site services timestamp
    `contenttimestamp` VARCHAR(50) DEFAULT NULL,            # this timestamp is string from content catalogue and not real date/time
    PRIMARY KEY (`uid`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_file_catalog_cache`;
CREATE TABLE `t_file_catalog_cache` (
    `uid` VARCHAR(36) NOT NULL,
    `endpoint` VARCHAR(255) NOT NULL,
    `reset` TINYINT(1) NOT NULL DEFAULT 0,    
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
    `destination` VARCHAR(50) NOT NULL,
    `guid` VARCHAR(36) NOT NULL,
    `source` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    `modificationdate` DATETIME DEFAULT NULL,
    `attemptnr` MEDIUMINT NOT NULL DEFAULT 1,    
    PRIMARY KEY (`destination`, `guid`, `source`)
) ENGINE=InnoDB;

####################
# HISTORY TABLES
####################

DROP TABLE IF EXISTS `t_history_dataset`;
CREATE TABLE `t_history_dataset` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(36) NOT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` SMALLINT DEFAULT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `nfiles` MEDIUMINT DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_subscription`;
CREATE TABLE `t_history_subscription` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(36) NOT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_subscription_channel`;
CREATE TABLE `t_history_subscription_channel` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(36) NOT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,    
    `state` TINYINT NOT NULL DEFAULT 0,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_files_in_queue`;
CREATE TABLE `t_history_files_in_queue` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_files_in_transfer`;
CREATE TABLE `t_history_files_in_transfer` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)     
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_files_in_registration`;
CREATE TABLE `t_history_files_in_registration` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_callbacks`;
CREATE TABLE `t_history_callbacks` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `protocol` VARCHAR(10) NOT NULL,
    `host` VARCHAR(50) DEFAULT '',
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)        
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_requests_submitting`;
CREATE TABLE `t_history_transfer_requests_submitting` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_requests_pending`;
CREATE TABLE `t_history_transfer_requests_pending` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `counter` MEDIUMINT NOT NULL DEFAULT 0,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_inactive_to_active`;
CREATE TABLE `t_history_inactive_to_active` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `starttransferdate` DATETIME DEFAULT NULL,    
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_active_to_inactive`;
CREATE TABLE `t_history_active_to_inactive` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_file_transfer`;
CREATE TABLE `t_history_file_transfer` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `guid` VARCHAR(36) NOT NULL,     
    `starttransferdate` DATETIME DEFAULT NULL,
    `endtransferdate` DATETIME DEFAULT NULL,
    `toolid` VARCHAR(20) DEFAULT NULL,
    `fsize` BIGINT DEFAULT NULL,
    `dsn` VARCHAR(512) NOT NULL,
    `share` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
	`success` TINYINT(1) NOT NULL DEFAULT 0,
	`report` VARCHAR(1024) DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)    
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_history_transfer_request`;
CREATE TABLE `t_history_transfer_request` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `startdate` DATETIME DEFAULT NULL,
    `enddate` DATETIME DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,  
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_monitor_transfer_request_submit`;
CREATE TABLE `t_monitor_transfer_request_submit` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `startdate` DATETIME DEFAULT NULL,
    `enddate` DATETIME DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,  
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `toolid` VARCHAR(20) DEFAULT NULL,
    `transferchannel` VARCHAR(512) DEFAULT NULL,
    `success` TINYINT(1) NOT NULL DEFAULT 0,
    `report` VARCHAR(1024) DEFAULT NULL,    
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `t_monitor_transfer_request_poll`;
CREATE TABLE `t_monitor_transfer_request_poll` (
     id BIGINT NOT NULL AUTO_INCREMENT,
    `startdate` DATETIME DEFAULT NULL,
    `enddate` DATETIME DEFAULT NULL,
    `nfiles` MEDIUMINT DEFAULT NULL,  
    `siteid` VARCHAR(50) NOT NULL,
    `sourcesiteid` VARCHAR(50) NOT NULL,
    `toolid` VARCHAR(20) DEFAULT NULL,
    `transferchannel` VARCHAR(512) DEFAULT NULL,
    `success` TINYINT(1) NOT NULL DEFAULT 0,    
    `report` VARCHAR(1024) DEFAULT NULL,
    `creationdate` DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=MyISAM;

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
DROP TRIGGER IF EXISTS t_subscription_file_insert;
DROP TRIGGER IF EXISTS t_subscription_file_delete;
DROP TRIGGER IF EXISTS t_callback_insert;
DROP TRIGGER IF EXISTS t_callback_delete;
DROP TRIGGER IF EXISTS t_file_insert;
DROP TRIGGER IF EXISTS t_file_update;
DROP TRIGGER IF EXISTS t_file_delete;
DROP TRIGGER IF EXISTS t_file_before_update;
DROP TRIGGER IF EXISTS t_transfer_request_insert;
DROP TRIGGER IF EXISTS t_transfer_request_after_update;
DROP TRIGGER IF EXISTS t_transfer_request_delete;

DELIMITER //


DROP TRIGGER IF EXISTS t_subscription_insert;//
CREATE TRIGGER t_subscription_insert AFTER INSERT ON t_subscription
    FOR EACH ROW
    BEGIN
        DECLARE monitor INT;
        SELECT active INTO monitor FROM t_monitor;
        IF monitor=1 THEN 
            INSERT INTO t_history_dataset (uid, dsn, version, state, nfiles, creationdate) VALUES (NEW.uid, NEW.dsn, NEW.version, NEW.state, NEW.nfiles, NOW());
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_subscription_update;//
CREATE TRIGGER t_subscription_update AFTER UPDATE ON t_subscription
    FOR EACH ROW
    BEGIN
        DECLARE monitor INT;
        SELECT active INTO monitor FROM t_monitor;
        IF monitor=1 AND (NEW.uid != OLD.uid OR NEW.dsn != OLD.dsn OR NEW.version != OLD.version OR NEW.state != OLD.state OR NEW.nfiles != OLD.nfiles) THEN 
            INSERT INTO t_history_dataset (uid, dsn, version, state, nfiles, creationdate) VALUES (NEW.uid, NEW.dsn, NEW.version, NEW.state, NEW.nfiles, NOW());
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_subscription_delete;//
CREATE TRIGGER t_subscription_delete AFTER DELETE ON t_subscription
    FOR EACH ROW
    BEGIN
        DELETE FROM t_file_catalog_cache WHERE uid=OLD.uid;
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
    	-- Also resets 'requestid', 'report' and 'active' fields if was in transfer
		UPDATE t_file SET counter=IF(t_file.counter>0,t_file.counter-1,0),requestid=IF(t_file.counter=0 AND t_file.state=1,NULL,requestid),report=IF(t_file.counter=0 AND t_file.state=1,NULL,report),active=IF(t_file.counter=0 AND t_file.state=1,0,active),state=IF(t_file.state IN (0,1) AND t_file.counter=0,3,t_file.state) WHERE guid=OLD.guid AND siteid=OLD.siteid;
    END;//

DROP TRIGGER IF EXISTS t_file_after_update;//
CREATE TRIGGER t_file_after_update AFTER UPDATE ON t_file
    FOR EACH ROW
    BEGIN
        DECLARE monitor INT;
        -- Remove subscription files in transfer when final states are reached
        IF OLD.state=1 AND NEW.state=3 THEN
            DELETE FROM t_subscription_files_in_transfer WHERE siteid=NEW.siteid AND guid=NEW.guid; 
        ELSEIF OLD.state=2 AND NEW.state=4 THEN
            DELETE FROM t_subscription_files_in_transfer WHERE siteid=NEW.siteid AND guid=NEW.guid;
        END IF;        
        -- Reset bad sources and bad transfer attempts
        IF OLD.counter>0 AND NEW.counter=0 THEN
            DELETE FROM t_bad_file WHERE siteid=NEW.siteid AND guid=NEW.guid;
            DELETE FROM t_bad_transfer WHERE destination=NEW.siteid AND guid=NEW.guid;
        END IF;
        -- History information
        SELECT active INTO monitor FROM t_monitor;
        IF monitor=1 THEN 
            IF OLD.state=1 AND NEW.state=2 THEN
                IF OLD.transferstatedate != NULL THEN
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, OLD.transferstatedate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 1, NEW.report, NOW());
                ELSE
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, NEW.transfersubmitdate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 1, NEW.report, NOW());
                END IF;
            ELSEIF OLD.state=1 AND NEW.state=3 THEN
                IF NEW.transferstatedate != NULL THEN
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, OLD.transferstatedate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 0, NEW.report, NOW());
                ELSE
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, NEW.transfersubmitdate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 0, NEW.report, NOW());
                END IF;            
            ELSEIF OLD.state=1 AND NEW.state=1 AND OLD.active=0 AND NEW.active=1 THEN
                INSERT INTO t_history_inactive_to_active (guid, siteid, starttransferdate, creationdate) VALUES (NEW.guid, NEW.siteid, NEW.transfersubmitdate, NOW());
            ELSEIF OLD.state=1 AND NEW.state=1 AND OLD.active=1 AND NEW.active=0 THEN
                -- I consider this state change a FAILED transfer (which in FTS is what it actually corresponds to)
                IF OLD.transferstatedate != NULL THEN
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, OLD.transferstatedate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 0, OLD.report, NOW());
                ELSE
                    INSERT INTO t_history_file_transfer (guid, starttransferdate, endtransferdate, toolid, fsize, dsn, share, siteid, sourcesiteid, success, report, creationdate) VALUES (NEW.guid, NEW.transfersubmitdate, NOW(), NEW.toolid, NEW.fsize, NEW.dsn, NEW.share, NEW.siteid, NEW.sourcesiteid, 0, OLD.report, NOW());
                END IF;            
                INSERT INTO t_history_active_to_inactive (guid, siteid, creationdate) VALUES (NEW.guid, NEW.siteid, NOW());        
            END IF;    
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_transfer_request_delete;//
CREATE TRIGGER t_transfer_request_delete AFTER DELETE ON t_transfer_request
    FOR EACH ROW
    BEGIN
        DECLARE monitor INT;
        SELECT active INTO monitor FROM t_monitor;
        IF monitor=1 THEN 
            INSERT INTO t_history_transfer_request (startdate, enddate, nfiles, siteid, sourcesiteid, creationdate) VALUES (OLD.creationdate, NOW(), OLD.nfiles, OLD.siteid, OLD.sourcesiteid, NOW());
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
        DECLARE monitor INT;
        SELECT active INTO monitor FROM t_monitor;
        IF monitor=1 THEN
            INSERT INTO t_history_files_in_queue (counter, siteid, sourcesiteid, share, creationdate) SELECT COUNT(*) AS counter, siteid, sourcesiteid, share, NOW() AS creationdate FROM t_file WHERE state=0 GROUP BY sourcesiteid, siteid, share;
            INSERT INTO t_history_files_in_transfer (counter, siteid, sourcesiteid, share, creationdate) SELECT COUNT(*) AS counter, siteid, sourcesiteid, share, NOW() AS creationdate FROM t_file WHERE state=1 GROUP BY sourcesiteid, siteid, share;
            INSERT INTO t_history_files_in_registration (counter, siteid, creationdate) SELECT COUNT(*) AS counter, siteid, NOW() AS creationdate FROM t_file WHERE state=2 GROUP BY siteid;
            INSERT INTO t_history_callbacks (counter, protocol, host, creationdate) SELECT COUNT(*) AS counter, protocol, host, NOW() AS creationdate FROM t_callback GROUP BY protocol, host;
            INSERT INTO t_history_transfer_requests_submitting (counter, siteid, sourcesiteid, creationdate) SELECT COUNT(*) AS counter, siteid, sourcesiteid, NOW() AS creationdate FROM t_transfer_request WHERE state=0 GROUP BY sourcesiteid, siteid;
            INSERT INTO t_history_transfer_requests_pending (counter, siteid, sourcesiteid, creationdate) SELECT COUNT(*) AS counter, siteid, sourcesiteid, NOW() AS creationdate FROM t_transfer_request WHERE state=1 GROUP BY sourcesiteid, siteid;
        END IF;
    END;//

DELIMITER ;
