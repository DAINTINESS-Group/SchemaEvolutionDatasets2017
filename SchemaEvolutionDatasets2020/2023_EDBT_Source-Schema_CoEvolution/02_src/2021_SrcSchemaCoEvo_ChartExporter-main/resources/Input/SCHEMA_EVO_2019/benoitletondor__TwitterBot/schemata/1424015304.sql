CREATE TABLE `tweet` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `content` text NOT NULL,
	  `date` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `Content` (`content`(255))	) ENGINE=InnoDB DEFAULT CHARSET=utf8;

