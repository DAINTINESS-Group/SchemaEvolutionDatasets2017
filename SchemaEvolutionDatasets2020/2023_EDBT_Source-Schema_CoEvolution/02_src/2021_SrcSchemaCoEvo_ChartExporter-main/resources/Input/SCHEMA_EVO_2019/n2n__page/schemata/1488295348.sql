CREATE TABLE `page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `internal_page_id` int(10) unsigned DEFAULT NULL,
  `external_url` varchar(255) DEFAULT NULL,
  `page_content_id` int(10) unsigned DEFAULT NULL,
  `subsystem_name` varchar(255) DEFAULT NULL,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `in_path` tinyint(4) NOT NULL DEFAULT '1',
  `hook_key` varchar(255) DEFAULT NULL,
  `in_navigation` tinyint(4) NOT NULL DEFAULT '1',
  `nav_target_new_window` tinyint(4) NOT NULL DEFAULT '0',
  `lft` int(10) unsigned NOT NULL,
  `rgt` int(10) unsigned NOT NULL,
  `last_mod` datetime DEFAULT NULL,
  `last_mod_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subsystem_name` varchar(255) DEFAULT NULL,
  `page_controller_id` int(10) unsigned NOT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `ssl` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_content_t` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `n2n_locale` varchar(5) NOT NULL,
  `se_title` varchar(70) DEFAULT NULL,
  `se_description` varchar(255) DEFAULT NULL,
  `se_keywords` varchar(128) DEFAULT NULL,
  `page_content_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_controller` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_controller_t` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `n2n_locale` varchar(16) NOT NULL,
  `page_controller_id` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_controller_t_content_items` (
  `page_controller_t_id` int(10) unsigned NOT NULL,
  `content_item_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`page_controller_t_id`,`content_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_t` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `n2n_locale` varchar(12) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `path_part` varchar(255) DEFAULT NULL,
  `page_id` int(10) unsigned DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `path_part` (`path_part`),
  KEY `page_leaf_t_index_1` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `page_link` (
	`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	`type` VARCHAR(255) NULL DEFAULT NULL,
	`linked_page_id` INT(10) UNSIGNED NULL DEFAULT NULL,
	`url` VARCHAR(255) NULL DEFAULT NULL,
	`label` VARCHAR(255) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `page_link_index_1` (`linked_page_id`)
)
COLLATE='utf8_general_ci' ENGINE=InnoDB;
