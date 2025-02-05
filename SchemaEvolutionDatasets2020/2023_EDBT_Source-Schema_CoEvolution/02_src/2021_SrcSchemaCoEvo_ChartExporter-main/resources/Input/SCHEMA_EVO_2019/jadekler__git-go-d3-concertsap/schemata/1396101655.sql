CREATE TABLE `band` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(25555) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `band_concert` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `band_id` int(11) DEFAULT NULL,
	  `concert_id` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `band_concert` (`band_id`,
`concert_id`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `band_concert_record` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `band_id` int(11) DEFAULT NULL,
	  `concert_id` int(11) DEFAULT NULL,
	  `date` date DEFAULT NULL,
	  `time` time DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `band_concert_date_time` (`band_id`,
`concert_id`,
`date`,
`time`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `concert` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `address` varchar(25555) DEFAULT NULL,
	  `state_id` int(11) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  `start` datetime DEFAULT NULL,
	  `end` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

CREATE TABLE `retailer` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `state` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `acronym` varchar(2) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE KEY `state` (`acronym`)	) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

CREATE TABLE `ticket_record` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `price` double DEFAULT NULL,
	  `concert_id` int(11) DEFAULT NULL,
	  `retailer_id` int(11) DEFAULT NULL,
	  `timestamp` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

