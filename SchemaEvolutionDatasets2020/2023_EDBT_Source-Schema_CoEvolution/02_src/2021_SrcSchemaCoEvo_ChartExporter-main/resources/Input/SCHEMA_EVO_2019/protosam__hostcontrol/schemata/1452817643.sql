CREATE TABLE `domainmetadata` (	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  `domain_id` int(11) DEFAULT NULL,
	  `kind` varchar(32) DEFAULT NULL,
	  `content` text,
	  PRIMARY KEY (`id`),
	  KEY `domainidmetaindex` (`domain_id`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `domains` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) NOT NULL,
	  `master` varchar(128) DEFAULT NULL,
	  `last_check` int(11) DEFAULT NULL,
	  `type` varchar(6) NOT NULL,
	  `notified_serial` int(11) DEFAULT NULL,
	  `account` varchar(40) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `name_index` (`name`)	) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `hostcontrol_ftpusers` (	  `ftpuser_id` int(11) NOT NULL AUTO_INCREMENT,
	  `ftpusername` varchar(32) NOT NULL,
	  `homedir` varchar(255) NOT NULL,
	  `system_username` varchar(32) NOT NULL,
	  PRIMARY KEY (`ftpuser_id`),
	  KEY `ftpusername` (`ftpusername`,
`system_username`)	) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

CREATE TABLE `hostcontrol_ipaddr` (	  `ip_id` int(11) NOT NULL AUTO_INCREMENT,
	  `system_username` varchar(32) NOT NULL,
	  `ipaddr` varchar(16) NOT NULL,
	  PRIMARY KEY (`ip_id`),
	  UNIQUE KEY `system_username_2` (`system_username`),
	  KEY `system_username` (`system_username`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `hostcontrol_user_tokens` (	  `token` varchar(34) NOT NULL,
	  `hostcontrol_id` int(11) NOT NULL,
	  `description` varchar(45) NOT NULL,
	  `token_id` int(11) NOT NULL AUTO_INCREMENT,
	  PRIMARY KEY (`token_id`),
	  KEY `hostcontrol_id` (`hostcontrol_id`),
	  CONSTRAINT `deleteuser` FOREIGN KEY (`hostcontrol_id`) REFERENCES `hostcontrol_users` (`hostcontrol_id`) ON DELETE CASCADE ON UPDATE NO ACTION	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `hostcontrol_users` (	  `hostcontrol_id` int(11) NOT NULL AUTO_INCREMENT,
	  `system_username` varchar(32) NOT NULL,
	  `privileges` text NOT NULL,
	  `owned_by` varchar(32) NOT NULL,
	  `login_token` varchar(32) NOT NULL,
	  `email_address` varchar(255) NOT NULL,
	  PRIMARY KEY (`hostcontrol_id`),
	  KEY `owned_by` (`owned_by`),
	  KEY `system_username` (`system_username`)	) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

CREATE TABLE `mail_domains` (	  `domain_id` int(11) NOT NULL AUTO_INCREMENT,
	  `domain` varchar(255) NOT NULL,
	  `system_username` varchar(32) NOT NULL,
	  PRIMARY KEY (`domain_id`),
	  UNIQUE KEY `domain_2` (`domain`),
	  KEY `domain` (`domain`),
	  KEY `system_username` (`system_username`)	) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `mail_forwardings` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `source` varchar(80) NOT NULL,
	  `destination` text NOT NULL,
	  `domain` varchar(200) NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `domain` (`domain`),
	  KEY `source` (`source`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mail_transport` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `domain` varchar(128) NOT NULL DEFAULT '',
	  `transport` varchar(128) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `domain` (`domain`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mail_users` (	  `email_id` int(11) NOT NULL AUTO_INCREMENT,
	  `email` varchar(255) NOT NULL,
	  `password` varchar(20) NOT NULL,
	  `domain` varchar(255) NOT NULL,
	  PRIMARY KEY (`email_id`),
	  KEY `domain` (`domain`),
	  KEY `email` (`email`),
	  CONSTRAINT `mail_users_ibfk_1` FOREIGN KEY (`domain`) REFERENCES `mail_domains` (`domain`) ON DELETE CASCADE	) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `records` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `domain_id` int(11) DEFAULT NULL,
	  `name` varchar(255) DEFAULT NULL,
	  `type` varchar(10) DEFAULT NULL,
	  `content` varchar(64000) DEFAULT NULL,
	  `ttl` int(11) DEFAULT NULL,
	  `prio` int(11) DEFAULT NULL,
	  `change_date` int(11) DEFAULT NULL,
	  `disabled` tinyint(1) DEFAULT '0',
	  `ordername` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
	  `auth` tinyint(1) DEFAULT '1',
	  PRIMARY KEY (`id`),
	  KEY `nametype_index` (`name`,
`type`),
	  KEY `domain_id` (`domain_id`),
	  KEY `recordorder` (`domain_id`,
`ordername`),
	  CONSTRAINT `records_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE	) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

CREATE TABLE `website_vhosts` (	  `vhost_id` int(11) NOT NULL AUTO_INCREMENT,
	  `system_username` varchar(32) NOT NULL,
	  `domain` varchar(254) NOT NULL,
	  `documentroot` text NOT NULL,
	  `ipaddr` varchar(16) NOT NULL,
	  `ssl_enabled` enum('Y',
'N') NOT NULL,
	  `ssl_certificate` longtext NOT NULL,
	  `ssl_key` longtext NOT NULL,
	  `ssl_ca_certificate` longtext NOT NULL,
	  PRIMARY KEY (`vhost_id`),
	  KEY `domain` (`domain`),
	  KEY `system_username` (`system_username`)	) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

