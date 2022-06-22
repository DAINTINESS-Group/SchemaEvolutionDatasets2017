CREATE TABLE `favorite` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `userId` bigint(20) NOT NULL,
	  `userName` varchar(100) NOT NULL,
	  `tweetId` bigint(20) NOT NULL,
	  `status` text NOT NULL,
	  `favDate` datetime NOT NULL,
	  `unfavDate` datetime DEFAULT NULL,
	  `lastAction` datetime NOT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `follow` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `userId` bigint(20) NOT NULL,
	  `userName` varchar(100) NOT NULL,
	  `status` text,
	  `followDate` datetime NOT NULL,
	  `unfollowDate` datetime DEFAULT NULL,
	  `lastAction` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `UserId` (`userId`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `reply` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `userId` bigint(20) NOT NULL,
	  `userName` varchar(100) NOT NULL,
	  `tweetId` bigint(20) NOT NULL,
	  `status` text NOT NULL,
	  `answer` text NOT NULL,
	  `replyDate` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `TweetId` (`tweetId`)	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tweet` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `content` text NOT NULL,
	  `date` datetime NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `Content` (`content`(255))	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

