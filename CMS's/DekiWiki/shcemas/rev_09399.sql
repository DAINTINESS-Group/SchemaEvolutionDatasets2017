--
-- Table structure for table `archive`
--
CREATE TABLE `archive` (
  `ar_id` int(4) unsigned NOT NULL auto_increment,
  `ar_namespace` tinyint(2) unsigned NOT NULL default '0',
  `ar_title` varchar(255) NOT NULL default '',
  `ar_text` mediumtext NOT NULL,
  `ar_comment` tinyblob NOT NULL,
  `ar_user` int(5) unsigned NOT NULL default '0',
  `ar_user_text` varchar(255) NOT NULL default '',
  `ar_timestamp` varchar(14) NOT NULL default '',
  `ar_minor_edit` tinyint(1) NOT NULL default '0',
  `ar_last_page_id` int(8) unsigned NOT NULL default '0',
  `ar_old_id` int(8) unsigned NOT NULL default '0',
  `ar_flags` tinyblob NOT NULL,
  `ar_content_type` VARCHAR( 255 ) NOT NULL DEFAULT 'application/x.deki-text',
  `ar_language` VARCHAR( 10 ) NOT NULL default '',  
  `ar_display_name` VARCHAR( 255 ) DEFAULT NULL,  
  `ar_transaction_id` int(4) unsigned  NOT NULL default '0',
  PRIMARY KEY  (`ar_id`),
  KEY `name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `ar_last_page_id` (`ar_last_page_id`), 
  KEY `ar_transaction_id` (`ar_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Dumping data for table `archive`
--

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `at_id` int(8) unsigned NOT NULL auto_increment,
  `at_from` int(8) unsigned NOT NULL default '0',
  `at_filename` varchar(128) NOT NULL default '',
  `at_timestamp` varchar(14) NOT NULL default '',
  `at_filesize` int(8) unsigned NOT NULL default '0',
  `at_filetype` varchar(32) NOT NULL default '',
  `at_extension` varchar(32) NOT NULL default '',
  `at_user` int(5) unsigned NOT NULL default '0',
  `at_user_text` varchar(255) NOT NULL default '',
  `at_name` varchar(128) NOT NULL default '',
  `at_desc` text NOT NULL,
  `at_removed` varchar(14) default NULL,
  `at_removed_by_text` varchar(255) default NULL,
  `at_image_width` int(4) unsigned default NULL,
  `at_image_height` int(4) unsigned default NULL,
  PRIMARY KEY  (`at_id`),
  KEY `name_ext_from` (`at_from`,`at_extension`,`at_name`)  
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `bans`
--
CREATE TABLE `bans` (                                  
          `ban_id` int(4) unsigned NOT NULL auto_increment,    
          `ban_by_user_id` int(4) unsigned NOT NULL,           
          `ban_expires` datetime default NULL,                 
          `ban_reason` text,                                   
          `ban_revokemask` bigint(8) unsigned NOT NULL,        
          `ban_last_edit` datetime default NULL,               
          PRIMARY KEY  (`ban_id`)                              
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
        
--
-- Table structure for table `banips`
--    
CREATE TABLE `banips` (                                 
          `banip_id` int(10) unsigned NOT NULL auto_increment,  
          `banip_ipaddress` varchar(15) default NULL,           
          `banip_ban_id` int(4) unsigned NOT NULL,              
          PRIMARY KEY  (`banip_id`),                            
          KEY `banip_ipaddress` (`banip_ipaddress`)             
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;  
--
-- Table structure for table `banusers`
--        
CREATE TABLE `banusers` (                                
            `banuser_id` int(4) unsigned NOT NULL auto_increment,  
            `banuser_user_id` int(4) unsigned NOT NULL,            
            `banuser_ban_id` int(4) unsigned NOT NULL,             
            UNIQUE KEY `banuser_id` (`banuser_id`),                
            KEY `banuser_user_id` (`banuser_user_id`)              
          ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;
          
--
-- Table structure for table `brokenlinks`
--

CREATE TABLE `brokenlinks` (
  `bl_from` int(8) unsigned NOT NULL default '0',
  `bl_to` varchar(255) NOT NULL default '',
  UNIQUE KEY `bl_from` (`bl_from`,`bl_to`),
  KEY `bl_to` (`bl_to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--
-- Table structure for table `comments`
--
CREATE TABLE `comments` (                                           
	`cmnt_id` int(8) unsigned NOT NULL auto_increment,                
	`cmnt_page_id` int(8) unsigned NOT NULL,                          
	`cmnt_number` int(2) unsigned NOT NULL,                           
	`cmnt_poster_user_id` int(4) unsigned NOT NULL,                   
	`cmnt_create_date` timestamp NOT NULL default CURRENT_TIMESTAMP,  
	`cmnt_last_edit` timestamp NULL default NULL,                     
	`cmnt_last_edit_user_id` int(4) unsigned default NULL,            
	`cmnt_content` text NOT NULL,                                     
	`cmnt_content_mimetype` varchar(25) NOT NULL,                     
	`cmnt_title` varchar(50) default NULL,                            
	`cmnt_deleter_user_id` int(8) unsigned default NULL,              
	`cmnt_delete_date` timestamp NULL default NULL,                   
PRIMARY KEY  (`cmnt_id`),                                         
UNIQUE KEY `pageid_number` (`cmnt_page_id`,`cmnt_number`)         
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `config`
--
CREATE TABLE `config` (                                             
          `config_id` int unsigned NOT NULL auto_increment,             
          `config_key` varchar(255) NOT NULL,                               
          `config_value` text NOT NULL,                                                      
          PRIMARY KEY  (`config_id`),                                       
          KEY `config_key` (`config_key`)                                   
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table structure for table `group_grants`
--
CREATE TABLE `group_grants` (
  `group_grant_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_id` INT(10) UNSIGNED NOT NULL,
  `group_id` INT(10) UNSIGNED NOT NULL,
  `role_id` INT(4) UNSIGNED NOT NULL,
  `creator_user_id` int(10) unsigned not null,
  `expire_date` datetime default NULL,
  `last_edit` timestamp,
  PRIMARY KEY  (`group_grant_id`),
  UNIQUE(`page_id`, `group_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `group_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(255)  NOT NULL,
  `group_role_id` INT(4) UNSIGNED NOT NULL,
  `group_service_id` int(4) unsigned not null,
  `group_creator_user_id` int(10) unsigned not null default 0,
  `group_last_edit` timestamp,
  PRIMARY KEY  (`group_id`),
  UNIQUE KEY `group_name` (`group_name`, `group_service_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `links`
--

CREATE TABLE `links` (
  `l_from` int(8) unsigned NOT NULL default '0',
  `l_to` int(8) unsigned NOT NULL default '0',
  UNIQUE KEY `l_from` (`l_from`,`l_to`),
  KEY `l_to` (`l_to`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `linkscc`
--

CREATE TABLE `linkscc` (
  `lcc_pageid` int(10) unsigned NOT NULL default '0',
  `lcc_cacheobj` mediumblob NOT NULL,
  UNIQUE KEY `lcc_pageid` (`lcc_pageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--
-- Table structure for table `objectcache`
--

CREATE TABLE `objectcache` (
  `keyname` varchar(255) NOT NULL default '',
  `value` mediumblob,
  `exptime` datetime default NULL,
  UNIQUE KEY `keyname` (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `old`
--

CREATE TABLE `old` (
  `old_id` int(8) unsigned NOT NULL auto_increment,
  `old_namespace` tinyint(2) unsigned NOT NULL default '0',
  `old_title` varchar(255) NOT NULL default '',
  `old_text` mediumtext NOT NULL,
  `old_comment` tinyblob NOT NULL,
  `old_user` int(5) unsigned NOT NULL default '0',
  `old_user_text` varchar(255) NOT NULL default '',
  `old_timestamp` varchar(14) NOT NULL default '',
  `old_minor_edit` tinyint(1) NOT NULL default '0',
  `old_flags` tinyblob NOT NULL,
  `old_content_type` varchar(255) NOT NULL default 'application/x.deki-text',
  `old_language` VARCHAR( 10 ) NOT NULL default '',
  `old_display_name` VARCHAR(255) DEFAULT NULL,
  `inverse_timestamp` varchar(14) NOT NULL default '',
  PRIMARY KEY  (`old_id`),
  KEY `old_timestamp` (`old_timestamp`),
  KEY `name_title_timestamp` (`old_namespace`,`old_title`,`inverse_timestamp`),
  KEY `user_timestamp` (`old_user`,`inverse_timestamp`),
  KEY `usertext_timestamp` (`old_user_text`,`inverse_timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `page_id` int(8) unsigned NOT NULL auto_increment,
  `page_namespace` tinyint(2) unsigned default 0 not null,
  `page_title` varchar(255) NOT NULL,
  `page_text` mediumtext NOT NULL,
  `page_comment` blob NOT NULL,
  `page_user_id` int(10) unsigned not null default 0,
  `page_timestamp` varchar(14) NOT NULL,
  `page_counter` bigint(20) unsigned not null default 0,
  `page_is_redirect` tinyint(1) unsigned not null default 0,
  `page_minor_edit` tinyint(1) unsigned not null default 0,
  `page_is_new` tinyint(1) unsigned not null default 0,
  `page_random` double unsigned not null default 0,
  `page_touched` varchar(14) NOT NULL,
  `page_inverse_timestamp` varchar(14) NOT NULL,
  `page_usecache` tinyint(1) unsigned not null default 1,
  `page_toc` blob NOT NULL,
  `page_tip` text NOT NULL,
  `page_parent` int(8) not null default 0,
  `page_restriction_id` int(4) unsigned NOT NULL,
  `page_content_type` varchar(255) NOT NULL default 'application/x.deki-text',
  `page_language` VARCHAR( 10 ) NOT NULL default '', 
  `page_display_name` VARCHAR(255) DEFAULT NULL, 
  `page_template_id` int(8) unsigned default NULL,
  PRIMARY KEY  (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_title` (`page_title`(20)),
  KEY `page_timestamp` (`page_timestamp`),
  KEY `page_random` (`page_random`),
  KEY `page_parent` (`page_parent`),
  KEY `name_title_timestamp` (`page_namespace`,`page_title`,`page_inverse_timestamp`),
  KEY `user_timestamp` (`page_user_id`,`page_inverse_timestamp`),
  KEY `usertext_timestamp` (`page_inverse_timestamp`),
  KEY `namespace_redirect_timestamp` (`page_namespace`,`page_is_redirect`,`page_timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `querycache`
--

CREATE TABLE `querycache` (
  `qc_type` char(32) NOT NULL default '',
  `qc_value` int(5) unsigned NOT NULL default '0',
  `qc_namespace` tinyint(2) unsigned NOT NULL default '0',
  `qc_title` char(255) NOT NULL default '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `recentchanges`
--

CREATE TABLE `recentchanges` (
  `rc_id` int(8) NOT NULL auto_increment,
  `rc_timestamp` varchar(14) NOT NULL default '',
  `rc_cur_time` varchar(14) NOT NULL default '',
  `rc_user` int(10) unsigned NOT NULL default '0',
  `rc_user_text` varchar(255) NOT NULL default '',
  `rc_namespace` tinyint(3) NOT NULL default '0',
  `rc_title` varchar(255) NOT NULL default '',
  `rc_comment` varchar(255) NOT NULL default '',
  `rc_minor` tinyint(3) unsigned NOT NULL default '0',
  `rc_bot` tinyint(3) unsigned NOT NULL default '0',
  `rc_new` tinyint(3) unsigned NOT NULL default '0',
  `rc_cur_id` int(10) unsigned NOT NULL default '0',
  `rc_this_oldid` int(10) unsigned NOT NULL default '0',
  `rc_last_oldid` int(10) unsigned NOT NULL default '0',
  `rc_type` tinyint(3) unsigned NOT NULL default '0',
  `rc_moved_to_ns` tinyint(3) unsigned NOT NULL default '0',
  `rc_moved_to_title` varchar(255) NOT NULL default '',
  `rc_patrolled` tinyint(3) unsigned NOT NULL default '0',
  `rc_ip` varchar(15) NOT NULL default '',
  `rc_transaction_id` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title` (`rc_namespace`,`rc_title`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_transaction_id` (`rc_transaction_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (                            
    `t_id` int(4) NOT NULL auto_increment,                 
    `t_timestamp` datetime NOT NULL,                       
    `t_user_id` int(4) NOT NULL,                           
    `t_page_id` int(4) unsigned default NULL,              
    `t_title` varchar(255) default NULL,                   
    `t_namespace` tinyint(2) default NULL,                 
    `t_type` tinyint(2) default NULL,                      
    `t_reverted` tinyint(1) NOT NULL default '0',          
    `t_revert_user_id` int(4) unsigned default NULL,       
    `t_revert_timestamp` datetime default NULL,            
    `t_revert_reason` varchar(255) default NULL,           
    PRIMARY KEY  (`t_id`),                                 
    KEY `t_timestamp` (`t_timestamp`)                      
  ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `requestlog`
--

CREATE TABLE `requestlog` (
 `rl_id` int(4) unsigned NOT NULL auto_increment,             
 `rl_servicehost` varchar(64) NOT NULL,           
 `rl_requesthost` varchar(64) NOT NULL,
 `rl_requesthostheader` varchar(64) NOT NULL,                                  
 `rl_requestpath` varchar(512) NOT NULL,                                 
 `rl_requestparams` varchar(512) default NULL,                           
 `rl_requestverb` varchar(8) NOT NULL,                                   
 `rl_dekiuser` varchar(32) default NULL,                              
 `rl_origin` varchar(64) NOT NULL,                                                                     
 `rl_servicefeature` varchar(128) NOT NULL,                              
 `rl_responsestatus` varchar(8) NOT NULL,                                
 `rl_executiontime` int(4) unsigned default NULL,                        
 `rl_response` varchar(2048) default NULL,                              
 `rl_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,            
 PRIMARY KEY  (`rl_id`)                                                  
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `requeststats`
--

CREATE TABLE `requeststats` (
 `rs_id` int(4) unsigned NOT NULL auto_increment,                                         
 `rs_numrequests` int(4) unsigned NOT NULL,                                               
 `rs_servicehost` varchar(64) NOT NULL,                                                   
 `rs_requestverb` varchar(8) NOT NULL,                                                    
 `rs_servicefeature` varchar(128) NOT NULL,                                               
 `rs_responsestatus` varchar(8) NOT NULL,                                                 
 `rs_exec_avg` int(4) unsigned NOT NULL,                                                  
 `rs_exec_std` int(4) unsigned NOT NULL,                                                  
 `rs_ts_start` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,  
 `rs_ts_length` int(4) unsigned NOT NULL,                                                 
 PRIMARY KEY  (`rs_id`)                                                                   
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `restrictions`
--

CREATE TABLE `restrictions` (
  `restriction_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `restriction_name` VARCHAR(255)  NOT NULL,
  `restriction_perm_flags` MEDIUMINT UNSIGNED NOT NULL,
  `restriction_creator_user_id` int(10) unsigned not null,
  `restriction_last_edit` timestamp, 
  PRIMARY KEY  (`restriction_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(255)  NOT NULL,
  `role_perm_flags` BIGINT(8) UNSIGNED NOT NULL,
  `role_creator_user_id` int(10) unsigned not null,
  `role_last_edit` timestamp,
  PRIMARY KEY  (`role_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `service_type` varchar(255) not null,
  `service_sid` varchar(255),
  `service_uri` varchar(255),
  `service_description` mediumtext,
  `service_local` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `service_enabled` tinyint(1) unsigned not null default 1,
  `service_last_status` text NULL,
  `service_last_edit` timestamp NOT NULL,
  PRIMARY KEY  (`service_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `service_config`
--

CREATE TABLE `service_config` (
    config_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    service_id INT(4) UNSIGNED NOT NULL, 
    config_name CHAR(255) NOT NULL,
    config_value TEXT,
    PRIMARY KEY (config_id)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `service_prefs`
--

CREATE TABLE `service_prefs` (
    pref_id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    service_id INT(4) UNSIGNED NOT NULL, 
    pref_name CHAR(255) NOT NULL,
    pref_value TEXT,
    PRIMARY KEY (pref_id)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--
-- Table structure for table `site_stats`
--

CREATE TABLE `site_stats` (
  `ss_row_id` int(8) unsigned NOT NULL default '0',
  `ss_total_views` bigint(20) unsigned default '0',
  `ss_total_edits` bigint(20) unsigned default '0',
  `ss_good_articles` bigint(20) unsigned default '0',
  `ss_total_pages` bigint(20) default '-1',
  `ss_users` bigint(20) default '-1',
  `ss_admins` int(10) default '-1',
  UNIQUE KEY `ss_row_id` (`ss_row_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `tag_map`
--

CREATE TABLE `tag_map` (
	`tagmap_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`tagmap_page_id` INT UNSIGNED NOT NULL ,
	`tagmap_tag_id` INT(4) UNSIGNED NOT NULL ,
	PRIMARY KEY  (`tagmap_id`),
	UNIQUE KEY `tagmap_page_id` (`tagmap_page_id`, `tagmap_tag_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` INT(4) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) NOT NULL default '',
  `tag_type` tinyint(2) unsigned NOT NULL default '0',
  PRIMARY KEY  (`tag_id`),
  UNIQUE KEY `tag_name` (`tag_name`,`tag_type`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;


--
-- Table structure for table `user_grants`
--

CREATE TABLE `user_grants` (
  `user_grant_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `page_id` INT(10) UNSIGNED NOT NULL,
  `user_id` INT(10) UNSIGNED NOT NULL,
  `role_id` INT(4) UNSIGNED NOT NULL,
  `creator_user_id` int(10) unsigned not null,
  `expire_date` datetime default NULL,
  `last_edit` timestamp,
  PRIMARY KEY  (`user_grant_id`),
  UNIQUE(`page_id`, `user_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `user_id` INT(10) NOT NULL,
  `group_id` INT(10) NOT NULL,
  `last_edit` timestamp,
  UNIQUE(`user_id`, `group_id`)
) ENGINE = MYISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `user_registrations`
--
CREATE TABLE `user_registrations` (
  `register_id` int(10) unsigned NOT NULL auto_increment,
  `register_username` varchar(255) NOT NULL default '',
  `register_email` varchar(255) NOT NULL default '',
  `register_active` tinyint(1) NOT NULL default '1',
  `register_role_id` int(4) unsigned not null,
  `register_service_id` int(4) unsigned NOT NULL,
  `register_created` varchar(14) NOT NULL default '',
  `register_expired` varchar(14) NOT NULL default '',
  `register_nonce` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`register_id`),
  KEY `register_username` (`register_username`),
  KEY `register_nonce` (`register_nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL auto_increment,
  `user_name` varchar(255) NOT NULL,
  `user_real_name` varchar(255) default NULL,
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_email` varchar(255) default NULL,
  `user_options` blob NOT NULL,
  `user_touched` varchar(14) NOT NULL default '',
  `user_token` varchar(32) NOT NULL default '',
  `user_role_id` int(4) unsigned not null,
  `user_active` tinyint(1) unsigned NOT NULL,
  `user_external_name` varchar(255) default NULL,
  `user_service_id` int(4) unsigned NOT NULL,
  `user_builtin` tinyint(1) unsigned NOT NULL default 0,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `user_name` (`user_name`, `user_service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

--
-- Table structure for table `watchlist`
--

CREATE TABLE `watchlist` (
  `wl_user` int(5) unsigned NOT NULL default '0',
  `wl_namespace` tinyint(2) unsigned NOT NULL default '0',
  `wl_title` varchar(255) NOT NULL default '',
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE utf8_general_ci;

-- Dump completed on 2007-02-17  0:27:06
