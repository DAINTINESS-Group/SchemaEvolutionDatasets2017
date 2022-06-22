--
-- Tabellenstruktur für Tabelle `rocket_user`
--

DROP TABLE IF EXISTS `rocket_user`;
CREATE TABLE IF NOT EXISTS `rocket_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(128) NOT NULL,
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `type` enum('superadmin','admin') DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

DROP TABLE IF EXISTS `rocket_login`;
CREATE TABLE IF NOT EXISTS `rocket_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(16) DEFAULT NULL,
  `wrong_password` varchar(32) DEFAULT NULL,
  `type` enum('superadmin','admin') DEFAULT NULL,
  `successfull` tinyint(1) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL DEFAULT '',
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `rocket_content_item`;
CREATE TABLE IF NOT EXISTS `rocket_content_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `panel` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `order_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


DROP TABLE IF EXISTS `rocket_filter`;
CREATE TABLE IF NOT EXISTS `rocket_filter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_script_id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `filter_data_json` text NOT NULL,
  `sort_directions_json` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `entity_script_id` (`entity_script_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



--
-- Tabellenstruktur für Tabelle `rocket_user_access_grant`
--
DROP TABLE IF EXISTS `rocket_user_access_grant`;
CREATE TABLE IF NOT EXISTS `rocket_user_access_grant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `script_id` varchar(255) NOT NULL,
  `restricted` tinyint(4) NOT NULL,
  `privileges_json` text NOT NULL,
  `access_json` text NOT NULL,
  `restriction_json` text NOT NULL,
  `user_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_group_id` (`user_group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rocket_user_group`
--

CREATE TABLE IF NOT EXISTS `rocket_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rocket_user_user_groups`
--

CREATE TABLE IF NOT EXISTS `rocket_user_user_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `user_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE `rocket_user_script_grant` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`user_group_id` INT UNSIGNED NOT NULL,
	`script_id` VARCHAR(255) NOT NULL,
	`access_json` TEXT NOT NULL,
	`full` TINYINT(1) UNSIGNED,
	UNIQUE INDEX `script_id` (`script_id`),
	PRIMARY KEY (`id`)
)ENGINE=InnoDB;
	
CREATE TABLE `rocket_user_privileges_grant` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`script_grant_id` VARCHAR(255) NOT NULL,
	`privileges_json` TEXT NULL,
	`restricted` TINYINT(1) NOT NULL DEFAULT '0',
	`restriction_json` TEXT NULL,
	PRIMARY KEY (`id`)
)ENGINE=InnoDB;


DROP TABLE IF EXISTS `rocket_translation_rocket_content_item`;
CREATE TABLE IF NOT EXISTS `rocket_translation_rocket_content_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `element_id` int(11) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rocket_translation_rocket_content_item_index_3` (`element_id`,`locale`),
  KEY `rocket_translation_rocket_content_item_index_1` (`element_id`),
  KEY `rocket_translation_rocket_content_item_index_2` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

