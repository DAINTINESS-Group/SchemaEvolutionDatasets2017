CREATE TABLE `band` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(25555) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `band_concert` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `band_id` int(11) DEFAULT NULL,
	  `concert_id` int(11) DEFAULT NULL,
	  `date` date DEFAULT NULL,
	  `time` time DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `concert` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `address` varchar(25555) DEFAULT NULL,
	  `state_id` int(11) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  `start` datetime DEFAULT NULL,
	  `end` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `retailer` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `website` varchar(2555) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `state` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) DEFAULT NULL,
	  `acronym` varchar(2) DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `ticket_records` (	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `price` double DEFAULT NULL,
	  `concert_id` int(11) DEFAULT NULL,
	  `retailer_id` int(11) DEFAULT NULL,
	  `timestamp` datetime DEFAULT NULL,
	  PRIMARY KEY (`id`)	) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

