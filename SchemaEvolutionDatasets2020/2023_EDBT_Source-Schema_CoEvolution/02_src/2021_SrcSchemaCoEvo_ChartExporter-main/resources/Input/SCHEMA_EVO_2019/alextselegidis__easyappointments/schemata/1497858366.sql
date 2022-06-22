CREATE TABLE IF NOT EXISTS `ea_appointments` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `book_datetime` DATETIME DEFAULT NULL,
	  `start_datetime` DATETIME DEFAULT NULL,
	  `end_datetime` DATETIME DEFAULT NULL,
	  `notes` TEXT,
	  `hash` TEXT,
	  `is_unavailable` TINYINT(4) DEFAULT '0',
	  `id_users_provider` BIGINT(20) UNSIGNED DEFAULT NULL,
	  `id_users_customer` BIGINT(20) UNSIGNED DEFAULT NULL,
	  `id_services` BIGINT(20) UNSIGNED DEFAULT NULL,
	  `id_google_calendar` TEXT,
	  PRIMARY KEY (`id`),
	  KEY `id_users_customer` (`id_users_customer`),
	  KEY `id_services` (`id_services`),
	  KEY `id_users_provider` (`id_users_provider`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_roles` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(256) DEFAULT NULL,
	  `slug` VARCHAR(256) DEFAULT NULL,
	  `is_admin` TINYINT(4) DEFAULT NULL,
	  `appointments` INT(4) DEFAULT NULL,
	  `customers` INT(4) DEFAULT NULL,
	  `services` INT(4) DEFAULT NULL,
	  `users` INT(4) DEFAULT NULL,
	  `system_settings` INT(4) DEFAULT NULL,
	  `user_settings` INT(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_secretaries_providers` (	  `id_users_secretary` BIGINT(20) UNSIGNED NOT NULL,
	  `id_users_provider` BIGINT(20) UNSIGNED NOT NULL,
	  PRIMARY KEY (`id_users_secretary`,
`id_users_provider`),
	  KEY `fk_ea_secretaries_providers_1` (`id_users_secretary`),
	  KEY `fk_ea_secretaries_providers_2` (`id_users_provider`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_services` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(256) DEFAULT NULL,
	  `duration` INT(11) DEFAULT NULL,
	  `price` DECIMAL(10,
2) DEFAULT NULL,
	  `currency` VARCHAR(32) DEFAULT NULL,
	  `description` TEXT,
	  `availabilities_type` VARCHAR(32) DEFAULT 'flexible',
	  `attendants_number` INT(11) DEFAULT '1',
	  `id_service_categories` BIGINT(20) UNSIGNED DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `id_service_categories` (`id_service_categories`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_services_providers` (	  `id_users` BIGINT(20) UNSIGNED NOT NULL,
	  `id_services` BIGINT(20) UNSIGNED NOT NULL,
	  PRIMARY KEY (`id_users`,
`id_services`),
	  KEY `id_services` (`id_services`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_service_categories` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(256) DEFAULT NULL,
	  `description` TEXT,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_settings` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(512) DEFAULT NULL,
	  `value` LONGTEXT,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_users` (	  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	  `first_name` VARCHAR(256) DEFAULT NULL,
	  `last_name` VARCHAR(512) DEFAULT NULL,
	  `email` VARCHAR(512) DEFAULT NULL,
	  `mobile_number` VARCHAR(128) DEFAULT NULL,
	  `phone_number` VARCHAR(128) DEFAULT NULL,
	  `address` VARCHAR(256) DEFAULT NULL,
	  `city` VARCHAR(256) DEFAULT NULL,
	  `state` VARCHAR(128) DEFAULT NULL,
	  `zip_code` VARCHAR(64) DEFAULT NULL,
	  `notes` TEXT,
	  `id_roles` BIGINT(20) UNSIGNED NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `id_roles` (`id_roles`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_user_settings` (	  `id_users` BIGINT(20) UNSIGNED NOT NULL,
	  `username` VARCHAR(256) DEFAULT NULL,
	  `password` VARCHAR(512) DEFAULT NULL,
	  `salt` VARCHAR(512) DEFAULT NULL,
	  `working_plan` TEXT,
	  `notifications` TINYINT(4) DEFAULT '0',
	  `google_sync` TINYINT(4) DEFAULT '0',
	  `google_token` TEXT,
	  `google_calendar` VARCHAR(128) DEFAULT NULL,
	  `sync_past_days` INT(11) DEFAULT '5',
	  `sync_future_days` INT(11) DEFAULT '5',
	  `calendar_view` VARCHAR(32) DEFAULT 'default',
	  PRIMARY KEY (`id_users`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

