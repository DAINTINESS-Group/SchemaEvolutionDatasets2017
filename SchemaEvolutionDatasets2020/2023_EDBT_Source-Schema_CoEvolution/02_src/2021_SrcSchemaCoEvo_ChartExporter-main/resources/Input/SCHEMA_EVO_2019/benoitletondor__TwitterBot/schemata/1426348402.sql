CREATE TABLE `follow` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `userId` bigint(20) NOT NULL,
	  `userName` varchar(100) NOT NULL,
	  `status` text,
	  `followDate` datetime NOT NULL,
	  `unfollowDate` datetime DEFAULT NULL,
	  `lastAction` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `UserId` (`userId`)	) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

CREATE TABLE `tweet` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `content` text NOT NULL,
	  `date` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `Content` (`content`(255))	) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

CREATE TABLE `reply` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `userId` BIGINT NOT NULL,
	  `userName` VARCHAR(100) NOT NULL,
	  `tweetId` BIGINT NOT NULL,
	  `status` TEXT NOT NULL,
	  `answer` TEXT NOT NULL,
	  `replyDate` DATETIME NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `TweetId` (`tweetId`)	) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

CREATE TABLE `favorite` (	  `idfavorite` INT NOT NULL AUTO_INCREMENT,
	  `userId` INT NOT NULL,
	  `userName` VARCHAR(100) NOT NULL,
	  `tweetId` INT NOT NULL,
	  `status` TEXT NOT NULL,
	  `favDate` DATETIME NOT NULL,
	  `unfavDate` DATETIME NULL,
	  `lastAction` DATETIME NOT NULL,
	  PRIMARY KEY (`idfavorite`)	) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

