CREATE TABLE `rocket_content_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `panel` varchar(32) COLLATE utf8_unicode_ci NULL,
  `order_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `rocket_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) DEFAULT NULL,
  `wrong_password` varchar(255) DEFAULT NULL,
  `power` enum('superadmin','admin','none') NULL DEFAULT NULL,
  `successfull` tinyint(1) unsigned NOT NULL,
  `ip` varchar(255) NOT NULL DEFAULT '',
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `rocket_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `power` enum('superadmin','admin','none') NOT NULL DEFAULT 'none',
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `rocket_user` (`id`, `nick`, `firstname`, `lastname`, `email`, `power`, `password`) VALUES
	(1, 'super', 'Testerich', 'von Testen', 'testerich@von-testen.com', 'superadmin', '$2a$07$holeradioundholeradioe5FD29ANtu4PChE8W4mZDg.D1eKkBnwq');

CREATE TABLE IF NOT EXISTS `rocket_critmod_save` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ei_type_path` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `filter_data_json` text NOT NULL,
  `sort_data_json` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ei_spec_id` (`ei_type_path`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rocket_custom_grant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `custom_spec_id` varchar(255) NOT NULL,
  `rocket_user_group_id` int(10) unsigned NOT NULL,
  `full` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `access_json` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `script_id_user_group_id` (`custom_spec_id`,`rocket_user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rocket_ei_grant` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ei_type_path` varchar(255) NOT NULL,
  `rocket_user_group_id` int(10) unsigned NOT NULL,
  `full` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `access_json` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `script_id_user_group_id` (`rocket_user_group_id`,`ei_type_path`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rocket_ei_grant_privileges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ei_grant_id` int(10) unsigned NOT NULL,
  `ei_privilege_json` text NOT NULL,
  `restricted` tinyint(4) NOT NULL DEFAULT '0',
  `restriction_group_json` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rocket_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `nav_json` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `rocket_user_rocket_user_groups` (
  `rocket_user_id` int(10) unsigned NOT NULL,
  `rocket_user_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rocket_user_id`,`rocket_user_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;