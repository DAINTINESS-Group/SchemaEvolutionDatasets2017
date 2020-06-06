####################
# TABLES
####################

DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE `schema_version` (
    `version` VARCHAR(36) NOT NULL,
    `installationdate` DATETIME DEFAULT NULL
);
INSERT INTO `schema_version` (`version`, `installationdate`) VALUES ('0_4_0', NOW());

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
    INDEX (`modificationdate`),
    INDEX (`state`, `locked`)
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
    `guid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `counter` BIGINT(4) NOT NULL DEFAULT 0,
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
    INDEX (`state`, `sourcesiteid`, `siteid`, `sshare`, `attemptnr`), # For getFilesToSubmit(..)
    INDEX (`state`, `siteid`, `allocationattemptnr`)  # For getFilesToAllocate(..)
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
    `transferattemptnr` SMALLINT NOT NULL DEFAULT 0,
    `lookupattemptnr` SMALLINT NOT NULL DEFAULT 0,
    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`siteid`, `state`)    
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription`;
CREATE TABLE `t_subscription` (
    `uid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `vuid` VARCHAR(36) DEFAULT NULL,
    `duid` VARCHAR(36) DEFAULT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` SMALLINT DEFAULT NULL,
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
    `hasdonefiles` TINYINT(1) NOT NULL DEFAULT 0,
    `hasholdfiles` TINYINT(1) NOT NULL DEFAULT 0,
    `hasavailablefiles` TINYINT(1) NOT NULL DEFAULT 0,
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
    PRIMARY KEY (`guid`, `siteid`, `uid`),
    INDEX (`uid`, `siteid`)
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

DROP TABLE IF EXISTS `t_fsize_distribution`;
CREATE TABLE `t_fsize_distribution` (
    `siteid` VARCHAR(20) NOT NULL,
    `fsize` VARCHAR(30) NOT NULL,
    `counter` BIGINT(4) NOT NULL DEFAULT 0,
    PRIMARY KEY (`siteid`, `fsize`)
) ENGINE=InnoDB;

####################
# STORED PROCEDURES
####################

DELIMITER //

DROP PROCEDURE IF EXISTS drop_subscription_file_done;//
CREATE PROCEDURE drop_subscription_file_done (IN param_guid VARCHAR(36), IN param_siteid VARCHAR(36))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cursor_uid VARCHAR(36);
    DECLARE cursor_subscription CURSOR FOR SELECT uid FROM t_subscription_file WHERE guid=param_guid AND siteid=param_siteid GROUP BY uid;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;   
    OPEN cursor_subscription;
    REPEAT
        FETCH cursor_subscription INTO cursor_uid;
        IF NOT done THEN
            UPDATE t_subscription SET hasdonefiles=1 WHERE uid=cursor_uid AND siteid=param_siteid AND hasdonefiles=0;
        END IF;
    UNTIL done END REPEAT;
    CLOSE cursor_subscription;
    DELETE FROM t_subscription_file WHERE guid=param_guid AND siteid=param_siteid;
END;//

DROP PROCEDURE IF EXISTS handle_done_files;//
CREATE PROCEDURE handle_done_files ()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cursor_guid VARCHAR(36);
    DECLARE cursor_siteid VARCHAR(20);
    DECLARE cursor_file_done CURSOR FOR SELECT guid, siteid FROM t_file WHERE state=5;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
    START TRANSACTION;
    OPEN cursor_file_done;
    REPEAT
        FETCH cursor_file_done INTO cursor_guid, cursor_siteid;
        IF NOT done THEN
            CALL drop_subscription_file_done(cursor_guid, cursor_siteid);
        END IF;
    UNTIL done END REPEAT;
    CLOSE cursor_file_done;
    DELETE FROM t_file WHERE state=5;
    COMMIT;
END;//

DROP PROCEDURE IF EXISTS drop_subscription_file_hold;//
CREATE PROCEDURE drop_subscription_file_hold (IN param_guid VARCHAR(36), IN param_siteid VARCHAR(36))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cursor_uid VARCHAR(36);
    DECLARE cursor_subscription CURSOR FOR SELECT uid FROM t_subscription_file WHERE guid=param_guid AND siteid=param_siteid GROUP BY uid;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;   
    OPEN cursor_subscription;
    REPEAT
        FETCH cursor_subscription INTO cursor_uid;
        IF NOT done THEN
            UPDATE t_subscription SET hasholdfiles=1 WHERE uid=cursor_uid AND siteid=param_siteid AND hasholdfiles=0;
        END IF;
    UNTIL done END REPEAT;
    CLOSE cursor_subscription;
    DELETE FROM t_subscription_file WHERE guid=param_guid AND siteid=param_siteid;    
END;//

DROP PROCEDURE IF EXISTS handle_hold_files;//
CREATE PROCEDURE handle_hold_files ()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cursor_guid VARCHAR(36);
    DECLARE cursor_siteid VARCHAR(20);
    DECLARE cursor_file_hold CURSOR FOR SELECT guid, siteid FROM t_file WHERE state=4;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
    START TRANSACTION;
    OPEN cursor_file_hold;
    REPEAT
        FETCH cursor_file_hold INTO cursor_guid, cursor_siteid;
        IF NOT done THEN
            CALL drop_subscription_file_hold(cursor_guid, cursor_siteid);
        END IF;
    UNTIL done END REPEAT;
    CLOSE cursor_file_hold;
    DELETE FROM t_file WHERE state=4;    
    COMMIT;
END;//

DELIMITER ;

####################
# TRIGGERS
####################

DELIMITER //

DROP TRIGGER IF EXISTS t_file_insert;//
CREATE TRIGGER t_file_insert AFTER INSERT ON t_file
    FOR EACH ROW
    BEGIN
        -- Plot file size distribution
        IF NEW.fsize > 0 AND NEW.fsize < 10000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '< 10MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 10000000 AND NEW.fsize < 20000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 10 MB AND < 20MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 20000000 AND NEW.fsize < 50000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 20 MB AND < 50MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 50000000 AND NEW.fsize < 100000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 50 MB AND < 100MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 100000000 AND NEW.fsize < 200000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 100 MB AND < 200MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 200000000 AND NEW.fsize < 500000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 200 MB AND < 500MB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 500000000 AND NEW.fsize < 1000000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 500 MB AND < 1GB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 1000000000 AND NEW.fsize < 2000000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 1 GB AND < 2GB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        ELSEIF NEW.fsize >= 2000000000 THEN
            INSERT INTO t_fsize_distribution (siteid, fsize, counter) VALUES (NEW.siteid, '>= 2GB', 1) ON DUPLICATE KEY UPDATE counter=counter+1;
        END IF;
    END;//

-- Remove trigger present from initial 0.4.x schemas
DROP TRIGGER IF EXISTS t_file_after_update;//

DROP TRIGGER IF EXISTS t_file_before_update;//
CREATE TRIGGER t_file_before_update BEFORE UPDATE ON t_file
    FOR EACH ROW
    BEGIN
        -- File was cancelled
        IF OLD.counter>0 AND NEW.counter=0 THEN
            -- State was in allocation so decrease counter for allocated transfers and move it to allocation again
            IF OLD.state=1 THEN
                UPDATE t_site_source SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid;
                SET NEW.state=0;
            -- State was in transfer so decrease counter for active transfers and move it to allocation again
            ELSEIF OLD.state=2 THEN
                UPDATE t_active_transfer SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid AND sshare=OLD.sshare;
                SET NEW.state=0;                 
            END IF;
        -- File remains active
        ELSEIF OLD.counter>0 AND NEW.counter>0 THEN
            -- File has been allocated to transfer channel
            IF OLD.state!=1 AND NEW.state=1 THEN
                INSERT INTO t_site_source (siteid, sourcesiteid, counter) VALUES (NEW.siteid, NEW.sourcesiteid, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
            -- File moved from allocation to transfer
            ELSEIF OLD.state=1 AND NEW.state!=1 THEN
                UPDATE t_site_source SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid;
            -- File transfer about to begin
            ELSEIF OLD.state!=2 AND NEW.state=2 THEN
                INSERT INTO t_active_transfer (siteid, sourcesiteid, sshare, counter) VALUES (NEW.siteid, NEW.sourcesiteid, NEW.sshare, 1) ON DUPLICATE KEY UPDATE counter=counter+1;
            -- File transfer done
            ELSEIF OLD.state=2 AND NEW.state!=2 THEN
                UPDATE t_active_transfer SET counter=counter-1 WHERE siteid=OLD.siteid AND sourcesiteid=OLD.sourcesiteid AND sshare=OLD.sshare;
            END IF;
        END IF;
    END;//

DROP TRIGGER IF EXISTS t_file_delete;//
CREATE TRIGGER t_file_delete AFTER DELETE ON t_file
    FOR EACH ROW
    BEGIN
        DECLARE counter INT;
        -- Remove entry from t_source_file if no one else needs it.
        SELECT COUNT(*) INTO counter FROM t_file WHERE guid=OLD.guid;
        IF counter=0 THEN
            DELETE FROM t_source_file WHERE guid=OLD.guid;
        END IF;        
        -- Clean plot with file size distribution
        IF OLD.fsize > 0 AND OLD.fsize < 10000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='< 10MB';
        ELSEIF OLD.fsize >= 10000000 AND OLD.fsize < 20000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 10 MB AND < 20MB';
        ELSEIF OLD.fsize >= 20000000 AND OLD.fsize < 50000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 20 MB AND < 50MB';
        ELSEIF OLD.fsize >= 50000000 AND OLD.fsize < 100000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 50 MB AND < 100MB';
        ELSEIF OLD.fsize >= 100000000 AND OLD.fsize < 200000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 100 MB AND < 200MB';
        ELSEIF OLD.fsize >= 200000000 AND OLD.fsize < 500000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 200 MB AND < 500MB';
        ELSEIF OLD.fsize >= 500000000 AND OLD.fsize < 1000000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 500 MB AND < 1GB';
        ELSEIF OLD.fsize >= 1000000000 AND OLD.fsize < 2000000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 1 GB AND < 2GB';
        ELSEIF OLD.fsize >= 2000000000 THEN
            UPDATE t_fsize_distribution SET counter=counter-1 WHERE siteid=OLD.siteid AND fsize='>= 2GB';
        END IF;        
	END;//

DROP TRIGGER IF EXISTS t_subscription_delete;//
CREATE TRIGGER t_subscription_delete AFTER DELETE ON t_subscription
    FOR EACH ROW
    BEGIN
        -- Cascade delete of a subscription files.
        -- Cannot use foreign key constraint ON DELETE as the
        -- t_subscription_file trigger would not be activated by FK.
        DELETE FROM t_subscription_file WHERE uid=OLD.uid AND siteid=OLD.siteid;
    END;//

DROP TRIGGER IF EXISTS t_subscription_file_insert;//
CREATE TRIGGER t_subscription_file_insert AFTER INSERT ON t_subscription_file
    FOR EACH ROW
    BEGIN
        -- Need to show interest on a particular file for a site.
        UPDATE t_file SET counter=counter+1 WHERE guid=NEW.guid AND siteid=NEW.siteid;
    END;//

DROP TRIGGER IF EXISTS t_subscription_file_delete;//
CREATE TRIGGER t_subscription_file_delete AFTER DELETE ON t_subscription_file
    FOR EACH ROW
    BEGIN
        -- Need to remove interest on a particular file for a site.
        UPDATE t_file SET counter=counter-1 WHERE guid=OLD.guid AND siteid=OLD.siteid;
    END;//

DELIMITER ;

####################
# EVENTS
####################

---------------
-- Events to handle terminal states
---------------
DROP EVENT IF EXISTS `event_handle_done_files`;
CREATE EVENT `event_handle_done_files`
    ON SCHEDULE EVERY 1 MINUTE
    DO CALL handle_done_files();

DROP EVENT IF EXISTS `event_handle_hold_files`;
CREATE EVENT `event_handle_hold_files`
    ON SCHEDULE EVERY 5 MINUTE
    DO CALL handle_hold_files();

---------------
-- Events to release hanged requests
---------------
DROP EVENT IF EXISTS `event_release_subscription`;
CREATE EVENT `event_release_subscription`
    ON SCHEDULE EVERY 30 MINUTE
    DO UPDATE t_subscription SET locked=0
        WHERE modificationdate < DATE_SUB(NOW(), INTERVAL 1 HOUR);

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
        -- Delete cancelled files except those registering or in terminal states.
        -- Note that DONE and HOLD files are removed by the MySQL events
        -- above called handle_done_files() and handle_hold_files().
        DELETE FROM t_file WHERE counter<=0 AND state<3;
    END;//

DROP EVENT IF EXISTS `event_clean_t_site_source`;//
CREATE EVENT `event_clean_t_site_source`
    ON SCHEDULE EVERY 15 MINUTE
    DO
    BEGIN
        DELETE FROM t_site_source WHERE counter<=0;
    END;//

DROP EVENT IF EXISTS `event_clean_t_active_transfer`;//
CREATE EVENT `event_clean_t_active_transfer`
    ON SCHEDULE EVERY 1 HOUR
    DO
    BEGIN
        DELETE FROM t_active_transfer WHERE counter<=0;
    END;//
    
DROP EVENT IF EXISTS `event_clean_t_fsize_distribution`;//
CREATE EVENT `event_clean_t_fsize_distribution`
    ON SCHEDULE EVERY 1 DAY
    DO
    BEGIN
        DELETE FROM t_fsize_distribution WHERE counter<=0;
    END;//
    
DELIMITER ;
