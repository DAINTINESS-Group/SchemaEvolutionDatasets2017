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
    INDEX (`modificationdate`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `t_subscription_file`; # Foreign-key constraint
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
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
    `transferstate` TINYINT DEFAULT NULL,         # Replicated from t_transfer_request to speed-up monitoring
    `toolid` VARCHAR(20) DEFAULT NULL,            # Replicated from t_transfer_request to speed-up monitoring
    `transferchannel` VARCHAR(1024) DEFAULT NULL, # Replicated from t_transfer_request to speed-up monitoring
    `transferid` VARCHAR(36) DEFAULT NULL,        # Replicated from t_transfer_request to speed-up monitoring
    PRIMARY KEY (`guid`, `siteid`),
    INDEX (`requestid`),
    INDEX (`state`, `siteid`)
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

# TODO: add MYSQL cron to delete t_source_file where guid in 
# t_source_file and not in t_file. This works because
# when I queue I add first t_file and only after t_source_file.

DROP TABLE IF EXISTS `t_subscription`;
CREATE TABLE `t_subscription` (
    `uid` VARCHAR(36) NOT NULL,
    `siteid` VARCHAR(20) NOT NULL,
    `vuid` VARCHAR(36) DEFAULT NULL,
    `duid` VARCHAR(36) DEFAULT NULL,
    `dsn` VARCHAR(512) DEFAULT NULL,
    `version` TINYINT DEFAULT NULL,
    `previousvuids` TEXT DEFAULT NULL,
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
    `callbacks` TEXT DEFAULT NULL,    
    `sourcespolicy` MEDIUMINT NOT NULL,
    `sources` TEXT DEFAULT NULL,
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
    FOREIGN KEY (`guid`, `siteid`) REFERENCES `t_file` (`guid`, `siteid`) ON DELETE RESTRICT,
    FOREIGN KEY (`uid`, `siteid`) REFERENCES `t_subscription` (`uid`, `siteid`) ON DELETE CASCADE,
    PRIMARY KEY (`uid`, `guid`, `siteid`)
) ENGINE=InnoDB;
