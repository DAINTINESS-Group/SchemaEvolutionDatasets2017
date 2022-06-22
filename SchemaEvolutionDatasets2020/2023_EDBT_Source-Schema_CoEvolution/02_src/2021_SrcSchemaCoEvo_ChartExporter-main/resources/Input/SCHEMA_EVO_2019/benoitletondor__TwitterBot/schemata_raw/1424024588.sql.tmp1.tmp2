CREATE TABLE `follow` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `userId` bigint(20) NOT NULL,
	  `userName` varchar(100) NOT NULL,
	  `status` text,
	  `followDate` datetime NOT NULL,
	  `unfollowDate` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `UserId` (`userId`)	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `tweet` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `content` text NOT NULL,
	  `date` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `Content` (`content`(255))	) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

