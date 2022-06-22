CREATE TABLE `atoms` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `parent` int(11) NOT NULL DEFAULT '0',
	  `sortorder` int(11) DEFAULT '0',
	  `name` varchar(64) NOT NULL DEFAULT '',
	  `note` varchar(4096) DEFAULT NULL,
	  `extention` varchar(3) DEFAULT '',
	  `created` datetime DEFAULT '0000-00-00 00:00:00',
	  `updated` datetime DEFAULT '0000-00-00 00:00:00',
	  PRIMARY KEY (`id`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

CREATE TABLE `content` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `item` int(11) NOT NULL DEFAULT '0',
	  `language` varchar(2) NOT NULL DEFAULT 'nl',
	  `sortorder` int(11) DEFAULT '0',
	  `intro` char(1) NOT NULL DEFAULT 'N',
	  `kind` char(1) NOT NULL DEFAULT 'T',
	  `atom` int(11) DEFAULT '0',
	  `name` varchar(32) NOT NULL DEFAULT '',
	  `data` text NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `item` (`item`,
`language`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

CREATE TABLE `data` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `atom` int(11) NOT NULL DEFAULT '0',
	  `data` text,
	  `status` char(1) NOT NULL DEFAULT 'S',
	  `created` datetime NOT NULL,
	  `modified` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

CREATE TABLE `domains` (	  `id` varchar(32) NOT NULL DEFAULT '',
	  `name` varchar(32) DEFAULT '?'	) DEFAULT CHARSET=utf8;

CREATE TABLE `items` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(32) NOT NULL DEFAULT '',
	  `parent` int(11) NOT NULL DEFAULT '0',
	  `user` int(11) DEFAULT '0',
	  `template` int(11) NOT NULL DEFAULT '1',
	  `orderby` char(1) DEFAULT 'A',
	  `sortorder` int(11) DEFAULT '0',
	  `dated` date DEFAULT '0000-00-00',
	  `validfrom` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
	  `validto` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
	  `showcontent` char(1) DEFAULT 'Y',
	  `needslogin` char(1) DEFAULT 'N',
	  `defaultrequest` varchar(32) DEFAULT '',
	  `alloweddomains` varchar(128) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`),
	  KEY `parent_idx` (`parent`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

CREATE TABLE `languages` (	  `id` varchar(4) NOT NULL DEFAULT '',
	  `name` varchar(32) DEFAULT '',
	  `sortorder` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) DEFAULT CHARSET=utf8;

CREATE TABLE `levels` (	  `id` int(11) DEFAULT NULL,
	  `name` varchar(32) DEFAULT NULL	) DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (	  `item` int(11) NOT NULL DEFAULT '0',
	  `language` varchar(2) NOT NULL DEFAULT '',
	  `title` varchar(255) DEFAULT NULL,
	  `link` varchar(255) DEFAULT NULL,
	  `active` char(1) DEFAULT 'Y',
	  `keywords` varchar(255) DEFAULT '',
	  `description` varchar(255) DEFAULT '',
	  `created` datetime DEFAULT '0000-00-00 00:00:00',
	  `updated` datetime DEFAULT '0000-00-00 00:00:00',
	  PRIMARY KEY (`item`,
`language`)	) DEFAULT CHARSET=utf8;

CREATE TABLE `templates` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(64) DEFAULT '',
	  `description` varchar(127) DEFAULT '',
	  `controller` varchar(64) DEFAULT '',
	  `fn` varchar(128) DEFAULT '',
	  `allowedtemplates` varchar(255) DEFAULT '',
	  `maxnumber` int(11) DEFAULT '99999',
	  `system` char(1) DEFAULT 'N',
	  `defaultchild` int(11) DEFAULT '0',
	  PRIMARY KEY (`id`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

CREATE TABLE `users` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `username` varchar(128) NOT NULL DEFAULT '-',
	  `name` varchar(128) NOT NULL DEFAULT '-',
	  `password` char(64) DEFAULT NULL,
	  `domain` varchar(32) NOT NULL DEFAULT '',
	  `level` int(11) NOT NULL DEFAULT '0',
	  `badlogins` int(11) NOT NULL DEFAULT '0',
	  `maxbadlogins` int(11) NOT NULL DEFAULT '999',
	  `active` char(1) NOT NULL DEFAULT 'Y',
	  `email` varchar(128) NOT NULL DEFAULT '',
	  `note` varchar(255) NOT NULL DEFAULT '',
	  `nomail` char(1) NOT NULL DEFAULT 'N',
	  `sortorder` int(11) NOT NULL DEFAULT '0',
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `username_idx` (`username`,
`active`)	) AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;

