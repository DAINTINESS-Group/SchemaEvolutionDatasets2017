CREATE TABLE IF NOT EXISTS `ea_appointments` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `book_datetime` datetime DEFAULT NULL,
	  `start_datetime` datetime DEFAULT NULL,
	  `end_datetime` datetime DEFAULT NULL,
	  `notes` text,
	  `hash` text,
	  `is_unavailable` tinyint(4) DEFAULT '0',
	  `id_users_provider` bigint(20) unsigned DEFAULT NULL,
	  `id_users_customer` bigint(20) unsigned DEFAULT NULL,
	  `id_services` bigint(20) unsigned DEFAULT NULL,
	  `id_google_calendar` text,
	  PRIMARY KEY (`id`),
	  KEY `id_users_customer` (`id_users_customer`),
	  KEY `id_services` (`id_services`),
	  KEY `id_users_provider` (`id_users_provider`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=63 ;

CREATE TABLE IF NOT EXISTS `ea_roles` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(256) DEFAULT NULL,
	  `slug` varchar(256) DEFAULT NULL,
	  `is_admin` tinyint(4) DEFAULT NULL COMMENT '0',
	  `appointments` int(4) DEFAULT NULL COMMENT '0',
	  `customers` int(4) DEFAULT NULL COMMENT '0',
	  `services` int(4) DEFAULT NULL COMMENT '0',
	  `users` int(4) DEFAULT NULL COMMENT '0',
	  `system_settings` int(4) DEFAULT NULL COMMENT '0',
	  `user_settings` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

CREATE TABLE IF NOT EXISTS `ea_secretaries_providers` (	  `id_users_secretary` bigint(20) unsigned NOT NULL,
	  `id_users_provider` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id_users_secretary`,
`id_users_provider`),
	  KEY `fk_ea_secretaries_providers_1` (`id_users_secretary`),
	  KEY `fk_ea_secretaries_providers_2` (`id_users_provider`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `ea_services` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(256) DEFAULT NULL,
	  `duration` int(11) DEFAULT NULL,
	  `price` decimal(10,
2) DEFAULT NULL,
	  `currency` varchar(32) DEFAULT NULL,
	  `description` text,
	  `availabilities_type` varchar(32) DEFAULT 'flexible',
	  `attendants_number` int(11) DEFAULT '1',
	  `id_service_categories` bigint(20) unsigned DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `id_service_categories` (`id_service_categories`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

CREATE TABLE IF NOT EXISTS `ea_services_providers` (	  `id_users` bigint(20) unsigned NOT NULL,
	  `id_services` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id_users`,
`id_services`),
	  KEY `id_services` (`id_services`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ea_service_categories` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(256) DEFAULT NULL,
	  `description` text,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

CREATE TABLE IF NOT EXISTS `ea_settings` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(512) DEFAULT NULL,
	  `value` longtext,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

CREATE TABLE IF NOT EXISTS `ea_users` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `first_name` varchar(256) DEFAULT NULL,
	  `last_name` varchar(512) DEFAULT NULL,
	  `email` varchar(512) DEFAULT NULL,
	  `mobile_number` varchar(128) DEFAULT NULL,
	  `phone_number` varchar(128) DEFAULT NULL,
	  `address` varchar(256) DEFAULT NULL,
	  `city` varchar(256) DEFAULT NULL,
	  `state` varchar(128) DEFAULT NULL,
	  `zip_code` varchar(64) DEFAULT NULL,
	  `notes` text,
	  `id_roles` bigint(20) unsigned NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `id_roles` (`id_roles`)	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

CREATE TABLE IF NOT EXISTS `ea_user_settings` (	  `id_users` bigint(20) unsigned NOT NULL,
	  `username` varchar(256) DEFAULT NULL,
	  `password` varchar(512) DEFAULT NULL,
	  `salt` varchar(512) DEFAULT NULL,
	  `working_plan` text,
	  `notifications` tinyint(4) DEFAULT '0',
	  `google_sync` tinyint(4) DEFAULT '0',
	  `google_token` text,
	  `google_calendar` varchar(128) DEFAULT NULL,
	  `sync_past_days` int(11) DEFAULT '5',
	  `sync_future_days` int(11) DEFAULT '5',
	  `calendar_view` varchar(32) DEFAULT 'default',
	  PRIMARY KEY (`id_users`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

