-- Adminer 4.2.5 MySQL dump

DROP TABLE IF EXISTS `privileges`;
CREATE TABLE `privileges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `privileges` (`id`, `name`) VALUES
(NULL, 'default');

DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `resources` (`id`, `name`) VALUES
(NULL, 'Web:Web'),
(NULL, 'Web:Login'),
(NULL, 'Admin:Admin');

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `roles` (`id`, `name`, `parent`) VALUES
(NULL, 'guest',  0),
(NULL, 'member', 1);

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` int(11) NOT NULL,
  `resource` int(11) NOT NULL,
  `privilege` int(11) NOT NULL,
  `allowed` enum('no','yes') NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`),
  KEY `resource` (`resource`),
  KEY `role` (`role`),
  KEY `privilege` (`privilege`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`resource`) REFERENCES `resources` (`id`),
  CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  CONSTRAINT `permissions_ibfk_3` FOREIGN KEY (`privilege`) REFERENCES `privileges` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `permissions` (`id`, `role`, `resource`, `privilege`, `allowed`) VALUES
(NULL, 1, 1, 1, 'yes'),
(NULL, 1, 2, 1, 'yes');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realname` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` char(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `realname`, `email`, `password`) VALUES
(NULL, 'Root', 'root@root.local', '$2y$10$N8V61Vhx8P4qAFcFE/ZSjuAmFtxHt28FZMShsb4ADYTHZTFdlM/Oi');

DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`user`),
  KEY `role` (`role`),
  CONSTRAINT `access_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `access_ibfk_2` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `access` (`id`, `role`, `user`) VALUES
(NULL, 2, 1);

-- 2017-05-23 05:29:29
