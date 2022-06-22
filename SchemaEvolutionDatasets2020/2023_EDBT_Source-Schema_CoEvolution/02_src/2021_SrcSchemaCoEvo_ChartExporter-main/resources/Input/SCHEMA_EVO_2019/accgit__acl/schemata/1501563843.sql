-- Adminer 4.2.5 MySQL dump

CREATE TABLE `privileges` (
  `privilegeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`privilegeId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `privileges` (`privilegeId`, `name`) VALUES
(1,	'default');

CREATE TABLE `resources` (
  `resourceId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`resourceId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `resources` (`resourceId`, `name`) VALUES
(3,	'Admin:Admin'),
(2,	'Web:Login'),
(1,	'Web:Web');

CREATE TABLE `roles` (
  `roleId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `roles` (`roleId`, `name`, `parent`) VALUES
(1,	'guest',	0),
(2,	'member',	1),
(3,	'admin',	2);

CREATE TABLE `permissions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roleId` int(10) unsigned NOT NULL,
  `resourceId` int(11) unsigned NOT NULL,
  `privilegeId` int(11) unsigned NOT NULL,
  `allowed` enum('no','yes') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`),
  KEY `resource` (`resourceId`),
  KEY `role` (`roleId`),
  KEY `privilege` (`privilegeId`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`resourceId`) REFERENCES `resources` (`resourceId`),
  CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`roleId`),
  CONSTRAINT `permissions_ibfk_3` FOREIGN KEY (`privilegeId`) REFERENCES `privileges` (`privilegeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `permissions` (`id`, `roleId`, `resourceId`, `privilegeId`, `allowed`) VALUES
(1,	1,	1,	1,	'yes'),
(2,	1,	2,	1,	'yes');

CREATE TABLE `users` (
  `userId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `realname` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` char(60) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`userId`, `realname`, `email`, `password`) VALUES
(1,	'Root',	'root@root.local',	'$2y$10$N8V61Vhx8P4qAFcFE/ZSjuAmFtxHt28FZMShsb4ADYTHZTFdlM/Oi');

CREATE TABLE `acl` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roleId` int(10) unsigned NOT NULL,
  `userId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`userId`),
  KEY `role` (`roleId`),
  CONSTRAINT `acl_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `acl_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `acl` (`id`, `roleId`, `userId`) VALUES
(1,	3,	1);

-- 2017-05-23 05:29:29
