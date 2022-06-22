CREATE TABLE `board_codes` (	  `code` varchar(25) NOT NULL,
	  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  UNIQUE KEY `code` (`code`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `board_imports` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `idate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `user_id` int(8) NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `user_id` (`user_id`),
	  CONSTRAINT `board_imports_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `board_types` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `sku` varchar(15) NOT NULL,
	  `image` varchar(250) DEFAULT NULL,
	  `electric_schema` varchar(250) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `boards` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `type_id` int(8) NOT NULL,
	  `name` varchar(200) DEFAULT NULL,
	  `description` text,
	  `language` varchar(5) DEFAULT NULL,
	  `store_url` varchar(200) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `type_id` (`type_id`),
	  CONSTRAINT `boards_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `board_types` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `boards_connected` (	  `board_code` varchar(25) NOT NULL,
	  `session_id` varchar(250) DEFAULT NULL,
	  `status` varchar(15) DEFAULT NULL,
	  PRIMARY KEY (`board_code`),
	  UNIQUE KEY `board_code` (`board_code`)	) ENGINE=MEMORY DEFAULT CHARSET=utf8;

CREATE TABLE `measures` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(20) NOT NULL,
	  `read_plugin` varchar(20) NOT NULL,
	  `elaborate_plugin` varchar(20) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `measures_injected` (	  `board_id` int(11) NOT NULL,
	  `measure_id` int(11) NOT NULL,
	  `pin` varchar(20) NOT NULL,
	  `period` double DEFAULT NULL,
	  `state` varchar(20) DEFAULT NULL	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `plugins` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(20) NOT NULL,
	  `category` varchar(20) NOT NULL,
	  `jsonschema` longtext NOT NULL,
	  `code` longtext NOT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `plugins_injected` (	  `board_id` int(11) NOT NULL,
	  `plugin_id` int(11) NOT NULL,
	  `state` varchar(20) NOT NULL	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reverse_cloud_services` (	  `board_id` int(8) NOT NULL,
	  `service` varchar(50) NOT NULL,
	  `public_ip` varchar(16) NOT NULL,
	  `public_port` varchar(5) NOT NULL,
	  PRIMARY KEY (`board_id`,
`service`)	) ENGINE=MEMORY DEFAULT CHARSET=utf8;

CREATE TABLE `user_boards` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `user_id` int(8) NOT NULL,
	  `board_type` int(8) NOT NULL,
	  `board_code` varchar(25) NOT NULL,
	  `cloud_enabled` tinyint(1) DEFAULT '0',
	  PRIMARY KEY (`id`),
	  KEY `user_id` (`user_id`),
	  KEY `board_type` (`board_type`),
	  KEY `board_code` (`board_code`),
	  CONSTRAINT `user_boards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
	  CONSTRAINT `user_boards_ibfk_2` FOREIGN KEY (`board_type`) REFERENCES `board_types` (`id`),
	  CONSTRAINT `user_boards_ibfk_3` FOREIGN KEY (`board_code`) REFERENCES `board_codes` (`code`)	) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

CREATE TABLE `user_groups` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `name` varchar(50) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `user_profiles` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `user_id` int(8) NOT NULL,
	  `name` varchar(50) DEFAULT NULL,
	  `surname` varchar(50) DEFAULT NULL,
	  `avatar` varchar(200) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `user_id` (`user_id`),
	  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `userproject_comments` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `project_id` int(8) NOT NULL,
	  `user_id` int(8) NOT NULL,
	  `content` text NOT NULL,
	  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `status` varchar(15) DEFAULT 'public',
	  PRIMARY KEY (`id`),
	  KEY `project_id` (`project_id`),
	  KEY `user_id` (`user_id`),
	  CONSTRAINT `userproject_comments_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `userprojects` (`id`),
	  CONSTRAINT `userproject_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `userproject_likes` (	  `project_id` int(8) NOT NULL,
	  `user_id` int(8) NOT NULL,
	  KEY `project_id` (`project_id`),
	  KEY `user_id` (`user_id`),
	  CONSTRAINT `userproject_likes_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `userprojects` (`id`),
	  CONSTRAINT `userproject_likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `userprojects` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `user_id` int(8) NOT NULL,
	  `title` varchar(100) NOT NULL,
	  `description` text,
	  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `status` varchar(15) DEFAULT 'private',
	  PRIMARY KEY (`id`),
	  KEY `user_id` (`user_id`),
	  CONSTRAINT `userprojects_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (	  `id` int(8) NOT NULL AUTO_INCREMENT,
	  `username` varchar(50) DEFAULT NULL,
	  `password` varchar(25) DEFAULT NULL,
	  `group_id` int(8) NOT NULL,
	  `email` varchar(100) NOT NULL,
	  `active` tinyint(1) DEFAULT '0',
	  PRIMARY KEY (`id`),
	  KEY `group_id` (`group_id`),
	  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `user_groups` (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

