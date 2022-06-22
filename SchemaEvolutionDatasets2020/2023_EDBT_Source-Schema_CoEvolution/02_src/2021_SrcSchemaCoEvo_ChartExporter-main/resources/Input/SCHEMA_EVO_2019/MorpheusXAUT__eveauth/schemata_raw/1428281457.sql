/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for eveauth
CREATE DATABASE IF NOT EXISTS `eveauth` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `eveauth`;


-- Dumping structure for table eveauth.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `apikeyid` int(11) NOT NULL,
  `apivcode` varchar(64) NOT NULL,
  `apiaccessmask` int(9) NOT NULL DEFAULT '0',
  `defaultaccount` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyid` (`apikeyid`),
  KEY `fk_userapikeys_user` (`userid`),
  CONSTRAINT `fk_userapikeys_user` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.applications
CREATE TABLE IF NOT EXISTS `applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `maintainer` varchar(64) NOT NULL,
  `secret` varchar(32) NOT NULL,
  `callback` varchar(128) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `secret` (`secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL,
  `corporationid` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `evecharacterid` int(11) NOT NULL,
  `defaultcharacter` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `evecharacterid` (`evecharacterid`),
  KEY `corporationid` (`corporationid`),
  KEY `fk_characters_account` (`accountid`),
  CONSTRAINT `fk_characters_account` FOREIGN KEY (`accountid`) REFERENCES `accounts` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_characters_corporation` FOREIGN KEY (`corporationid`) REFERENCES `corporations` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.corporations
CREATE TABLE IF NOT EXISTS `corporations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `ticker` varchar(5) NOT NULL,
  `evecorporationid` int(16) NOT NULL,
  `ceoid` int(16) NOT NULL,
  `apikeyid` int(11) DEFAULT NULL,
  `apivcode` varchar(64) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `ticker` (`ticker`),
  UNIQUE KEY `evecorporationid` (`evecorporationid`),
  UNIQUE KEY `apikeyid` (`apikeyid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.csrffailures
CREATE TABLE IF NOT EXISTS `csrffailures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `request` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.grouproles
CREATE TABLE IF NOT EXISTS `grouproles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  `autoadded` tinyint(1) NOT NULL DEFAULT '1',
  `granted` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupid_roleid` (`groupid`,`roleid`),
  KEY `fk_grouproles_group` (`groupid`),
  KEY `fk_grouproles_role` (`roleid`),
  CONSTRAINT `fk_grouproles_group` FOREIGN KEY (`groupid`) REFERENCES `groups` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_grouproles_role` FOREIGN KEY (`roleid`) REFERENCES `roles` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.groups
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.loginattempts
CREATE TABLE IF NOT EXISTS `loginattempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `remoteaddr` varchar(64) NOT NULL,
  `useragent` varchar(256) NOT NULL,
  `successful` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.usergroups
CREATE TABLE IF NOT EXISTS `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_groupid` (`userid`,`groupid`),
  KEY `fk_usergroups_user` (`userid`),
  KEY `fk_usergroups_group` (`groupid`),
  CONSTRAINT `fk_usergroups_group` FOREIGN KEY (`groupid`) REFERENCES `groups` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_usergroups_user` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.userroles
CREATE TABLE IF NOT EXISTS `userroles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `roleid` int(11) NOT NULL,
  `autoadded` tinyint(1) NOT NULL DEFAULT '1',
  `granted` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid_roleid` (`userid`,`roleid`),
  KEY `fk_userroles_user` (`userid`),
  KEY `fk_userroles_role` (`roleid`),
  CONSTRAINT `fk_userroles_role` FOREIGN KEY (`roleid`) REFERENCES `roles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_userroles_user` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table eveauth.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(128) NOT NULL,
  `verifiedemail` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
