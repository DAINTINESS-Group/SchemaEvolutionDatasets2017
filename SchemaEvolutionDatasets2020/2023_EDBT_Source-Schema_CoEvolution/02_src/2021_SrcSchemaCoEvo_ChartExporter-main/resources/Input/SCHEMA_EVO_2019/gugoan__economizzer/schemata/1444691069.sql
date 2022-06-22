CREATE TABLE IF NOT EXISTS `tb_cashbook` (	`id` int(11) NOT NULL,
	  `value` float NOT NULL,
	  `description` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `date` date NOT NULL,
	  `is_pending` tinyint(1) NOT NULL DEFAULT '0',
	  `attachment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `inc_datetime` datetime DEFAULT NULL COMMENT 'insert date',
	  `edit_datetime` datetime DEFAULT NULL COMMENT 'edit date',
	  `user_id` int(11) NOT NULL,
	  `category_id` int(11) NOT NULL,
	  `type_id` int(11) NOT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Control financial movement' AUTO_INCREMENT=198 ;

CREATE TABLE IF NOT EXISTS `tb_category` (	`id_category` int(11) NOT NULL,
	  `desc_category` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
	  `hexcolor_category` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `user_id` int(11) NOT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Categories of entries: Water,
 light,
 card,
 etc.' AUTO_INCREMENT=24 ;

CREATE TABLE IF NOT EXISTS `tb_migration` (	  `version` varchar(180) CHARACTER SET latin1 NOT NULL,
	  `apply_time` int(11) DEFAULT NULL	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `tb_profile` (	`id` int(11) NOT NULL,
	  `user_id` int(11) NOT NULL,
	  `create_time` timestamp NULL DEFAULT NULL,
	  `update_time` timestamp NULL DEFAULT NULL,
	  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `language` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en'	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

CREATE TABLE IF NOT EXISTS `tb_role` (	`id` int(11) NOT NULL,
	  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `create_time` timestamp NULL DEFAULT NULL,
	  `update_time` timestamp NULL DEFAULT NULL,
	  `can_admin` smallint(6) NOT NULL DEFAULT '0'	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

CREATE TABLE IF NOT EXISTS `tb_type` (	`id_type` int(11) NOT NULL,
	  `desc_type` varchar(45) CHARACTER SET latin1 NOT NULL,
	  `hexcolor_type` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
	  `icon_type` varchar(45) CHARACTER SET latin1 DEFAULT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Movement Type: Debit,
 Credit' AUTO_INCREMENT=3 ;

CREATE TABLE IF NOT EXISTS `tb_user` (	`id` int(11) NOT NULL,
	  `role_id` int(11) NOT NULL,
	  `status` smallint(6) NOT NULL,
	  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `new_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `auth_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `api_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `login_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `login_time` timestamp NULL DEFAULT NULL,
	  `create_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `create_time` timestamp NULL DEFAULT NULL,
	  `update_time` timestamp NULL DEFAULT NULL,
	  `ban_time` timestamp NULL DEFAULT NULL,
	  `ban_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

CREATE TABLE IF NOT EXISTS `tb_user_auth` (	`id` int(11) NOT NULL,
	  `user_id` int(11) NOT NULL,
	  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `provider_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `provider_attributes` text COLLATE utf8_unicode_ci NOT NULL,
	  `create_time` timestamp NULL DEFAULT NULL,
	  `update_time` timestamp NULL DEFAULT NULL	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `tb_user_key` (	`id` int(11) NOT NULL,
	  `user_id` int(11) NOT NULL,
	  `type` smallint(6) NOT NULL,
	  `key_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `create_time` timestamp NULL DEFAULT NULL,
	  `consume_time` timestamp NULL DEFAULT NULL,
	  `expire_time` timestamp NULL DEFAULT NULL	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

