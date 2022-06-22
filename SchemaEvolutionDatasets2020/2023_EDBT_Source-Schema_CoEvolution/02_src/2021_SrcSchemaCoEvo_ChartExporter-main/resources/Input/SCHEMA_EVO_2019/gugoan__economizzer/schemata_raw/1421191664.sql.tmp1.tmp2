CREATE TABLE IF NOT EXISTS `tb_cashbook` (	`id` int(11) NOT NULL,
	  `category_id` int(11) NOT NULL,
	  `type_id` int(11) NOT NULL,
	  `value` float NOT NULL,
	  `description` varchar(45) DEFAULT NULL,
	  `date` date NOT NULL,
	  `is_pending` tinyint(1) NOT NULL DEFAULT '0',
	  `attachment` varchar(255) DEFAULT NULL,
	  `inc_datetime` datetime DEFAULT NULL COMMENT 'insert date',
	  `edit_datetime` datetime DEFAULT NULL COMMENT 'edit date'	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Control financial movement' AUTO_INCREMENT=148 ;

CREATE TABLE IF NOT EXISTS `tb_category` (	`id_category` int(11) NOT NULL,
	  `desc_category` varchar(45) NOT NULL,
	  `hexcolor_category` varchar(45) DEFAULT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Categories of entries: Water,
 light,
 card,
 etc.' AUTO_INCREMENT=17 ;

CREATE TABLE IF NOT EXISTS `tb_type` (	`id_type` int(11) NOT NULL,
	  `desc_type` varchar(45) NOT NULL,
	  `hexcolor_type` varchar(45) DEFAULT NULL,
	  `icon_type` varchar(45) DEFAULT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Movement Type: Debit,
 Credit' AUTO_INCREMENT=3 ;

