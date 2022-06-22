--
--  Simple management of users' permissions.
-- -----------------------------------------

-- ---- create privileges table:
CREATE TABLE `privileges` (
	`privilegeId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(40) NOT NULL,
	PRIMARY KEY (`privilegeId`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in privileges table:
INSERT INTO `privileges` (`privilegeId`, `name`)
VALUES (NULL, '*all'), (NULL, 'default');

-- ---- create resources table:
CREATE TABLE `resources` (
	`resourceId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(40) NOT NULL,
	PRIMARY KEY (`resourceId`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in resources table:
INSERT INTO `resources` (`resourceId`, `name`)
VALUES (NULL, 'Web:Web'), (NULL, 'Web:Login'), (NULL, 'Admin:Admin');

-- ---- create roles table:
CREATE TABLE `roles` (
	`roleId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`name` varchar(40) NOT NULL,
	`parent` int(11) NOT NULL,
	PRIMARY KEY (`roleId`),
	UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in roles table:
INSERT INTO `roles` (`roleId`, `name`, `parent`)
VALUES (NULL, 'guest',	 0), (NULL, 'member', 1), (NULL, 'admin',  2);

-- ---- create permissions table:
CREATE TABLE `permissions` (
	`id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`roleId` smallint(5) unsigned NOT NULL,
	`resourceId` smallint(5) unsigned NOT NULL,
	`privilegeId` smallint(5) unsigned NOT NULL,
	`allowed` enum('no','yes') NOT NULL DEFAULT 'yes',
	PRIMARY KEY (`id`),
	KEY `resource` (`resourceId`),
	KEY `role` (`roleId`),
	KEY `privilege` (`privilegeId`),
	CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`resourceId`) REFERENCES `resources` (`resourceId`),
	CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`roleId`),
	CONSTRAINT `permissions_ibfk_3` FOREIGN KEY (`privilegeId`) REFERENCES `privileges` (`privilegeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in permissions table:
INSERT INTO `permissions` (`id`, `roleId`, `resourceId`, `privilegeId`, `allowed`)
VALUES (NULL, 1, 1, 1, 'yes'), (NULL, 1, 2, 1, 'yes');

-- ---- create users table:
CREATE TABLE `users` (
	`userId` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`realname` varchar(60) NOT NULL,
	`email` varchar(60) NOT NULL,
	`password` char(60) NOT NULL,
	PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in users table:
INSERT INTO `users` (`userId`, `realname`, `email`, `password`)
VALUES (NULL, 'Root', 'root@root.local', '$2y$10$N8V61Vhx8P4qAFcFE/ZSjuAmFtxHt28FZMShsb4ADYTHZTFdlM/Oi');

-- ---- create acl table:
CREATE TABLE `acl` (
	`id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`roleId` smallint(5) unsigned NOT NULL,
	`userId` smallint(5) unsigned NOT NULL,
	PRIMARY KEY (`id`),
	KEY `user` (`userId`),
	KEY `role` (`roleId`),
	CONSTRAINT `acl_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
	CONSTRAINT `acl_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `roles` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---- insert data in acl table:
INSERT INTO `acl` (`id`, `roleId`, `userId`)
VALUES (1, 3, 1);
