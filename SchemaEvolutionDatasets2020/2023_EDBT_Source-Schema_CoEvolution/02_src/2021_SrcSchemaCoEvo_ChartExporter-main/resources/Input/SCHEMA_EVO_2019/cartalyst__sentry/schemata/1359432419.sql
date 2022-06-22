# Dump of table groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL ,
  `name` varchar(255) NOT NULL,
  `permissions` text,
  `created_at` timestamp NOT NULL ,
  `updated_at` timestamp NOT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_name_unique` (`name`)
) ENGINE=InnoDB;



# Dump of table throttle
# ------------------------------------------------------------

DROP TABLE IF EXISTS `throttle`;

CREATE TABLE `throttle` (
  `id` int(11) NOT NULL ,
  `user_id` varchar(255) NOT NULL,
  `attempts` int(11) NOT NULL,
  `suspended` tinyint(4) NOT NULL,
  `banned` tinyint(4) NOT NULL,
  `last_attempt_at` timestamp NOT NULL ,
  `suspended_at` timestamp NOT NULL ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL ,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `reset_password_hash` varchar(255) DEFAULT NULL,
  `activation_hash` varchar(255) DEFAULT NULL,
  `activated` tinyint(4) NOT NULL DEFAULT '0',
  `permissions` text,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL ,
  `updated_at` timestamp NOT NULL ,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB;



# Dump of table users_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users_groups`;

CREATE TABLE `users_groups` (
  `id` int(11) NOT NULL ,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
