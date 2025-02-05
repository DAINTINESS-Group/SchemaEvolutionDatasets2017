# $Id$


#
# Table structure for table `#__assets`
#

CREATE TABLE IF NOT EXISTS `#__assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__assets`
#

INSERT INTO `#__assets` (`id`, `parent_id`, `lft`, `rgt`, `level`, `name`, `title`, `rules`)
VALUES
	(1,0,1,80,0,'root.1','Root Asset','{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1,"10":1},"core.create":{"6":1},"core.delete":{"6":1},"core.edit":{"6":1},"core.edit.state":{"6":1}}'),
	(2,1,2,3,1,'com_admin','com_admin','{}'),
	(3,1,4,5,1,'com_banners','com_banners','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(4,1,6,7,1,'com_cache','com_cache','{"core.admin":{"7":1},"core.manage":{"7":1}}'),
	(5,1,8,9,1,'com_checkin','com_checkin','{"core.admin":{"7":1},"core.manage":{"7":1}}'),
	(6,1,10,11,1,'com_config','com_config','{}'),
	(7,1,12,15,1,'com_contact','com_contact','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(8,1,16,33,1,'com_content','com_content','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1,"5":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1}}'),
	(9,1,34,35,1,'com_cpanel','com_cpanel','{}'),
	(10,1,36,37,1,'com_installer','com_installer','{"core.admin":{"7":1},"core.manage":{"7":1},"core.create":[],"core.delete":[],"core.edit.state":[]}'),
	(11,1,38,39,1,'com_languages','com_languages','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(12,1,40,41,1,'com_login','com_login','{}'),
	(13,1,42,43,1,'com_mailto','com_mailto','{}'),
	(14,1,44,45,1,'com_massmail','com_massmail','{}'),
	(15,1,46,47,1,'com_media','com_media','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1,"4":1,"5":1},"core.delete":{"5":1},"core.edit":[],"core.edit.state":[]}'),
	(16,1,48,49,1,'com_menus','com_menus','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(17,1,50,51,1,'com_messages','com_messages','{}'),
	(18,1,52,53,1,'com_modules','com_modules','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(19,1,54,57,1,'com_newsfeeds','com_newsfeeds','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(20,1,58,59,1,'com_plugins','com_plugins','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(21,1,60,61,1,'com_redirect','com_redirect','{"core.admin":{"7":1},"core.manage":[]}'),
	(22,1,62,63,1,'com_search','com_search','{"core.admin":{"7":1},"core.manage":{"6":1}}'),
	(23,1,64,65,1,'com_templates','com_templates','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(24,1,66,67,1,'com_users','com_users','{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(25,1,68,75,1,'com_weblinks','com_weblinks','{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
	(26,1,76,77,1,'com_wrapper','com_wrapper','{}');

# -------------------------------------------------------

#
# Table structure for table `#__banners`
#

CREATE TABLE `#__banners` (
  `id` INTEGER NOT NULL auto_increment,
  `cid` INTEGER NOT NULL DEFAULT '0',
  `type` INTEGER NOT NULL DEFAULT '0',
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `alias` VARCHAR(255) NOT NULL DEFAULT '',
  `imptotal` INTEGER NOT NULL DEFAULT '0',
  `impmade` INTEGER NOT NULL DEFAULT '0',
  `clicks` INTEGER NOT NULL DEFAULT '0',
  `clickurl` VARCHAR(200) NOT NULL DEFAULT '',
  `state` TINYINT(3) NOT NULL DEFAULT '0',
  `catid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL,
  `sticky` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `ordering` INTEGER NOT NULL DEFAULT 0,
  `metakey` TEXT NOT NULL,
  `params` TEXT NOT NULL,
  `own_prefix` TINYINT(1) NOT NULL DEFAULT '0',
  `metakey_prefix` VARCHAR(255) NOT NULL DEFAULT '',
  `purchase_type` TINYINT NOT NULL DEFAULT '-1',
  `track_clicks` TINYINT NOT NULL DEFAULT '-1',
  `track_impressions` TINYINT NOT NULL DEFAULT '-1',
  `checked_out` INTEGER UNSIGNED NOT NULL DEFAULT '0',
  `checked_out_time` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  INDEX `idx_state` (`state`),
  INDEX `idx_own_prefix` (`own_prefix`),
  INDEX `idx_metakey_prefix` (`metakey_prefix`),
  INDEX `idx_banner_catid`(`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__banner_clients`
#

CREATE TABLE `#__banner_clients` (
  `id` INTEGER NOT NULL auto_increment,
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  `contact` VARCHAR(255) NOT NULL DEFAULT '',
  `email` VARCHAR(255) NOT NULL DEFAULT '',
  `extrainfo` TEXT NOT NULL,
  `state` TINYINT(3) NOT NULL DEFAULT '0',
  `checked_out` INTEGER UNSIGNED NOT NULL DEFAULT '0',
  `checked_out_time` DATETIME NOT NULL default '0000-00-00 00:00:00',
  `metakey` TEXT NOT NULL,
  `own_prefix` TINYINT NOT NULL DEFAULT '0',
  `metakey_prefix` VARCHAR(255) NOT NULL default '',
  `purchase_type` TINYINT NOT NULL DEFAULT '-1',
  `track_clicks` TINYINT NOT NULL DEFAULT '-1',
  `track_impressions` TINYINT NOT NULL DEFAULT '-1',
  PRIMARY KEY  (`id`),
  INDEX `idx_own_prefix` (`own_prefix`),
  INDEX `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__banner_tracks`
#

CREATE TABLE  `#__banner_tracks` (
  `track_date` DATE NOT NULL,
  `track_type` INTEGER UNSIGNED NOT NULL,
  `banner_id` INTEGER UNSIGNED NOT NULL,
  `count` INTEGER UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`, `track_type`, `banner_id`),
  INDEX `idx_track_date` (`track_date`),
  INDEX `idx_track_type` (`track_type`),
  INDEX `idx_banner_id` (`banner_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__categories`
#

CREATE TABLE `#__categories` (
  `id` int(11) NOT NULL auto_increment,
  `asset_id` INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rgt` int(11) NOT NULL default '0',
  `level` int(10) unsigned NOT NULL default '0',
  `path` varchar(255) NOT NULL default '',
  `extension` varchar(50) NOT NULL default '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL default '',
  `description` varchar(5120) NOT NULL default '',
  `published` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `params` varchar(2048) NOT NULL default '',
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL default '0',
  `created_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `modified_user_id` int(10) unsigned NOT NULL default '0',
  `modified_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL default '0',
  `language` varchar(7) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `#__categories` VALUES
(1, 0, 0, 0, 1, 0, '', 'system', 'ROOT', 'root', '', 1, 0, '0000-00-00 00:00:00', 1, '{}', '', '', '', 0, '2009-10-18 16:07:09', 0, '0000-00-00 00:00:00', 0, '');

# -------------------------------------------------------

#
# Table structure for table `#__contact_details`
#

CREATE TABLE `#__contact_details` (
  `id` integer NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `con_position` varchar(255) default NULL,
  `address` text,
  `suburb` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `country` varchar(100) default NULL,
  `postcode` varchar(100) default NULL,
  `telephone` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `misc` mediumtext,
  `image` varchar(255) default NULL,
  `imagepos` varchar(20) default NULL,
  `email_to` varchar(255) default NULL,
  `default_con` tinyint(1) unsigned NOT NULL default '0',
  `published` tinyint(1) unsigned NOT NULL default '0',
  `checked_out` integer unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` integer NOT NULL default '0',
  `params` text NOT NULL,
  `user_id` integer NOT NULL default '0',
  `catid` integer NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `mobile` varchar(255) NOT NULL default '',
  `webpage` varchar(255) NOT NULL default '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__content`
#

CREATE TABLE `#__content` (
  `id` integer unsigned NOT NULL auto_increment,
  `asset_id` INTEGER UNSIGNED NOT NULL DEFAULT 0 COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `title_alias` varchar(255) NOT NULL default '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL default '0',
  `sectionid` integer unsigned NOT NULL default '0',
  `mask` integer unsigned NOT NULL default '0',
  `catid` integer unsigned NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` integer unsigned NOT NULL default '0',
  `created_by_alias` varchar(255) NOT NULL default '',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` integer unsigned NOT NULL default '0',
  `checked_out` integer unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` integer unsigned NOT NULL default '1',
  `parentid` integer unsigned NOT NULL default '0',
  `ordering` integer NOT NULL default '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` integer unsigned NOT NULL default '0',
  `hits` integer unsigned NOT NULL default '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Set if article is featured.',
  `language` varchar(10) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY  (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__content_frontpage`
#

CREATE TABLE `#__content_frontpage` (
  `content_id` integer NOT NULL default '0',
  `ordering` integer NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__content_rating`
#

CREATE TABLE `#__content_rating` (
  `content_id` integer NOT NULL default '0',
  `rating_sum` integer unsigned NOT NULL default '0',
  `rating_count` integer unsigned NOT NULL default '0',
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`content_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__core_log_items`
#

CREATE TABLE `#__core_log_items` (
  `time_stamp` date NOT NULL default '0000-00-00',
  `item_table` varchar(50) NOT NULL default '',
  `item_id` integer unsigned NOT NULL default '0',
  `hits` integer unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__core_log_searches`
#

CREATE TABLE `#__core_log_searches` (
  `search_term` varchar(128) NOT NULL default '',
  `hits` integer unsigned NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


# -------------------------------------------------------

#
# Table structure for table `#__extensions`
#

CREATE TABLE `#__extensions` (
  `extension_id` INT  NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100)  NOT NULL,
  `type` VARCHAR(20)  NOT NULL,
  `element` VARCHAR(100) NOT NULL,
  `folder` VARCHAR(100) NOT NULL,
  `client_id` TINYINT(3) NOT NULL,
  `enabled` TINYINT(3) NOT NULL DEFAULT '1',
  `access` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1',
  `protected` TINYINT(3) NOT NULL DEFAULT '0',
  `manifest_cache` TEXT  NOT NULL,
  `params` TEXT NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) default '0',
  `state` int(11) default '0',
  PRIMARY KEY (`extension_id`),
  INDEX `element_clientid`(`element`, `client_id`),
  INDEX `element_folder_clientid`(`element`, `folder`, `client_id`),
  INDEX `extension`(`type`,`element`,`folder`,`client_id`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# Components

INSERT INTO `#__extensions` VALUES
(0, 'com_admin', 'component', 'com_admin', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Banners', 'component', 'com_banners', '', 1, 1, 0, 0, '', '{"purchase_type":"1","track_impressions":"0","track_clicks":"0","metakey_prefix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Cache Manager', 'component', 'com_cache', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'com_categories', 'component', 'com_categories', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Configuration Manager', 'component', 'com_config', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Contacts', 'component', 'com_contact', '', 1, 1, 0, 1, '', '{"contact":{"show_name":"1","show_position":"1","show_email":"0","show_street_address":"1","show_suburb":"1","show_state":"1","show_postcode":"1","show_country":"1","show_telephone":"1","show_mobile":"1","show_fax":"1","show_webpage":"1","show_misc":"1","show_image":"1","allow_vcard":"0","show_links":"1","linka_name":"Contact_Default_Link_Name","linkb_name":"Contact_Default_Link_Name","linkc_name":"Contact_Default_Link_Name","linkd_name":"Contact_Default_Link_Name","linke_name":"Contact_Default_Link_Name"},"contact_icons":"0","icon_address":"","icon_email":"","icon_telephone":"","icon_mobile":"","icon_fax":"","icon_misc":"","contacts":{"show_headings":"1","show_position":"1","show_email":"0","show_telephone":"1","show_mobile":"1","show_fax":"1","allow_vcard":"0","show_profile":"1"},"Contact_Form":{"show_email_form":"1","banned_email":"","banned_subject":"","banned_text":"","validate_session":"1","custom_reply":"0","redirect":""},"Contact_Config_Meta_Data":{"metakey":"","metadesc":"","robots":"","author":"","rights":"","xreference":""}}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Articles', 'component', 'com_content', '', 1, 1, 0, 1, '', '{"show_category":"1","link_category":"1","show_title":"1","link_titles":"1","show_intro":"1","show_author":"1","show_create_date":"1","show_modify_date":"1","show_publish_date":"1","show_item_navigation":"1","show_readmore":"1","show_icons":"1","show_print_icon":"1","show_email_icon":"1","show_hits":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_pagination_results":"1","display_num":"10","list_type":"single","show_headings":"1","show_date":"hide","date_format":"","filter_field":"hide","show_pagination_limit":"1","list_hits":"1","list_author":"1","show_description":"0","show_description_image":"0","drill_down_layout":"0","all_subcategories":"all","empty_categories":"1","article_count":"0","category_orderby":"alpha","article_orderby":"rdate","order_date":"created","show_pagination":"1","show_noauth":"0","show_feed_link":"1","feed_summary":"0","filter_type":"BL","filter_tags":"","filter_attritbutes":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Control Panel', 'component', 'com_cpanel', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Installation Manager', 'component', 'com_installer', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Language Manager', 'component', 'com_languages', '', 1, 1, 0, 1, '', 'administrator=en-GB\nsite=en-GB', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'com_login', 'component', 'com_login', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Mail To', 'component', 'com_mailto', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Mass Mail', 'component', 'com_massmail', '', 1, 1, 0, 1, '', 'mailSubjectPrefix=\nmailBodySuffix=\n\n', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Media Manager', 'component', 'com_media', '', 1, 1, 0, 1, '', '{"upload_extensions":"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10000000","file_path":"images","image_path":"images","restrict_uploads":"1","allowed_media_usergroup":"3","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html","enable_flash":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Menu Editor', 'component', 'com_menus', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Messaging', 'component', 'com_messages', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Module Manager', 'component', 'com_modules', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'News Feeds', 'component', 'com_newsfeeds', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Plug-in Manager', 'component', 'com_plugins', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Redirect Manager', 'component', 'com_redirect', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Search', 'component', 'com_search', '', 1, 1, 0, 1, '', '{"enabled":"0","show_date":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Template Manager', 'component', 'com_templates', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'User', 'component', 'com_users', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'User Manager', 'component', 'com_users', '', 1, 1, 0, 1, '', '{"allowUserRegistration":"1","new_usertype":"2","useractivation":"1","frontend_userparams":"1","mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Web Links', 'component', 'com_weblinks', '', 1, 1, 0, 0, '', '{"show_comp_description":"1","comp_description":"","show_link_hits":"1","show_link_description":"1","show_other_cats":"1","show_headings":"1","show_numbers":"1","show_report":"1","target":"0","link_icons":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Wrapper', 'component', 'com_wrapper', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

# Languages

INSERT INTO `#__extensions` VALUES
(0, 'en-GB', 'language', 'en-GB', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'en-GB', 'language', 'en-GB', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1);

# Libraries

INSERT INTO `#__extensions` VALUES
(0, 'phpmailer', 'library', 'phpmailer', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'phpxmlrpc', 'library', 'phpxmlrpc', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'simplepie', 'library', 'simplepie', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1);

# Modules
## Administrator
INSERT INTO `#__extensions` VALUES
(0, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_footer', 'module', 'mod_footer', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_login', 'module', 'mod_login', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_online', 'module', 'mod_online', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_status', 'module', 'mod_status', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_title', 'module', 'mod_title', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_unread', 'module', 'mod_unread', '', 1, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

## Site
INSERT INTO `#__extensions` VALUES
(0, 'mod_articles_archive', 'module', 'mod_articles_archive', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_articles_latest', 'module', 'mod_articles_latest', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_articles_popular', 'module', 'mod_articles_popular', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_banners', 'module', 'mod_banners', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_footer', 'module', 'mod_footer', '', 0, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_login', 'module', 'mod_login', '', 0, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'mod_newsflash', 'module', 'mod_newsflash', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_random_image', 'module', 'mod_random_image', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_related_items', 'module', 'mod_related_items', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_search', 'module', 'mod_search', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_stats', 'module', 'mod_stats', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_syndicate', 'module', 'mod_syndicate', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_users_latest', 'module', 'mod_users_latest', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_whosonline', 'module', 'mod_whosonline', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'mod_wrapper', 'module', 'mod_wrapper', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1);

# Plug-ins

INSERT INTO `#__extensions` VALUES
(0, 'System - Cache', 'plugin', 'cache', 'system', 0, 0, 1, 0, '', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Search - Categories', 'plugin', 'categories', 'search', 1, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(0, 'Editor - CodeMirror', 'plugin', 'codemirror', 'editors', 1, 1, 1, 1, '', '{"linenumbers":"0"}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(0, 'Search - Contact', 'plugin', 'contact', 'search', 0, 1, 1, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(0, 'Contacts', 'plugin', 'contacts', 'search', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Search - Content', 'plugin', 'content', 'search', 0, 1, 1, 0, '', '{"search_limit":"50","search_content":"1","search_uncategorised":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(0, 'System - Debug', 'plugin', 'debug', 'system', 0, 1, 1, 0, '', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"2","language_prefix":"(Mod_[^_]*)"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(0, 'Content - Email Cloaking', 'plugin', 'emailcloak', 'content', 0, 1, 1, 0, '', '{"mode":"1"}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(0, 'Content - Code Hightlighter (GeSHi)', 'plugin', 'geshi', 'content', 0, 0, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(0, 'Authentication - GMail', 'plugin', 'gmail', 'authentication', 0, 0, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(0, 'Editor Button - Image', 'plugin', 'image', 'editors-xtd', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Authentication - Joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(0, 'User - Joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 0, '', '{"autoregister":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Authentication - LDAP', 'plugin', 'ldap', 'authentication', 0, 0, 1, 0, '', '{"host":"","port":"389","use_ldapV3":"0","negotiate_tls":"0","no_referrals":"0","auth_method":"bind","base_dn":"","search_string":"","users_dn":"","username":"","password":"","ldap_fullname":"fullName","ldap_email":"mail","ldap_uid":"uid"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(0, 'Content - Load Module', 'plugin', 'loadmodule', 'content', 0, 1, 1, 0, '', '{"enabled":"1","style":"table"}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(0, 'System - Log', 'plugin', 'log', 'system', 0, 0, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(0, 'Search - Newsfeeds', 'plugin', 'newsfeeds', 'search', 0, 1, 1, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(0, 'Editor - No Editor', 'plugin', 'none', 'editors', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Authentication - OpenID', 'plugin', 'openid', 'authentication', 0, 0, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(0, 'Content - Pagebreak', 'plugin', 'pagebreak', 'content', 0, 1, 1, 0, '', '{"enabled":"1","title":"1","multipage_toc":"1","showall":"1"}', '', '', 0, '0000-00-00 00:00:00', 10000, 0),
(0, 'Editor Button - Pagebreak', 'plugin', 'pagebreak', 'editors-xtd', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Content - Page Navigation', 'plugin', 'pagenavigation', 'content', 0, 1, 1, 0, '', '{"position":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(0, 'User - Profile', 'plugin', 'profile', 'user', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Editor Button - Readmore', 'plugin', 'readmore', 'editors-xtd', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Editor Button - Article', 'plugin', 'article', 'editors-xtd', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'System - Redirect', 'plugin', 'redirect', 'system', 0, 0, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(0, 'System - Remember Me', 'plugin', 'remember', 'system', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(0, 'Search - Sections', 'plugin', 'sections', 'search', 0, 1, 1, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(0, 'System - SEF', 'plugin', 'sef', 'system', 0, 1, 1, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(0, 'Editor - TinyMCE 3.2', 'plugin', 'tinymce', 'editors', 0, 1, 1, 0, '', '{"mode":"1","skin":"0","compressed":"0","cleanup_startup":"0","cleanup_save":"2","entity_encoding":"raw","lang_mode":"0","lang_code":"en","text_direction":"ltr","content_css":"1","content_css_custom":"","relative_urls":"1","newlines":"0","invalid_elements":"script,applet,iframe","extended_elements":"","toolbar":"top","toolbar_align":"left","html_height":"550","html_width":"750","element_path":"1","fonts":"1","paste":"1","searchreplace":"1","insertdate":"1","format_date":"%Y-%m-%d","inserttime":"1","format_time":"%H:%M:%S","colors":"1","table":"1","smilies":"1","media":"1","hr":"1","directionality":"1","fullscreen":"1","style":"1","layer":"1","xhtmlxtras":"1","visualchars":"1","nonbreaking":"1","template":"1","blockquote":"1","wordcount":"1","advimage":"1","advlink":"1","autosave":"1","contextmenu":"1","inlinepopups":"1","safari":"0","custom_plugin":"","custom_button":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(0, 'Content - Rating', 'plugin', 'vote', 'content', 0, 1, 1, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(0, 'Search - Weblinks', 'plugin', 'weblinks', 'search', 0, 1, 1, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 2, 0);

# Templates

INSERT INTO `#__extensions` VALUES
(0, 'Atomic', 'template', 'atomic', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Bluestork', 'template', 'bluestork', '', 1, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1),
(0, 'Milky Way', 'template', 'rhuk_milkyway', '', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, -1);

# -------------------------------------------------------

#
# Table structure for table `#__languages`
#

CREATE TABLE `#__languages` (
  `lang_id` int(11) unsigned NOT NULL auto_increment,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `published` int(11) NOT NULL default '0',
  PRIMARY KEY  (`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `#__languages` (`lang_id`,`lang_code`,`title`,`title_native`,`description`,`published`)
VALUES
	(1,'en_GB','English (UK)','English (UK)','',1),
	(2,'en_US','English (US)','English (US)','',1);

#
# Table structure for table `#__menu`
#

CREATE TABLE `#__menu` (
  `id` integer NOT NULL auto_increment,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) NOT NULL COMMENT 'The SEF alias of the menu item.',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL default '0' COMMENT 'The published state of the menu link.',
  `parent_id` integer unsigned NOT NULL default '1' COMMENT 'The parent menu item in the menu tree.',
  `level` integer unsigned NOT NULL default '0' COMMENT 'The relative level in the tree.',
  `component_id` integer unsigned NOT NULL default '0' COMMENT 'FK to #__components.id',
  `ordering` integer NOT NULL default '0' COMMENT 'The relative ordering of the menu item in the tree.',
  `checked_out` integer unsigned NOT NULL default '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL default '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL default '0' COMMENT 'The click behaviour of the link.',
  `access` tinyint(3) unsigned NOT NULL default '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` integer unsigned NOT NULL default '0',
  `params` varchar(10240) NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` integer NOT NULL default '0' COMMENT 'Nested set lft.',
  `rgt` integer NOT NULL default '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL default '0' COMMENT 'Indicates if this menu item is the home or default page.',
  PRIMARY KEY  (`id`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(333))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;


INSERT INTO `#__menu` VALUES
(1, '', 'Menu_Item_Root', 'root', '', '', '', 1, 0, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 40, 0),
(2, '_adminmenu', 'com_banners', 'Banners', '', 'index.php?option=com_banners', 'component', 0, 1, 0, 2, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 1, 10, 0),
(3, '_adminmenu', 'com_banners', 'Banners', '', 'index.php?option=com_banners', 'component', 0, 2, 0, 2, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 2, 3, 0),
(4, '_adminmenu', 'com_banners_clients', 'Clients', '', 'index.php?option=com_banners&view=clients', 'component', 0, 2, 0, 2, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-clients', 0, '', 4, 5, 0),
(5, '_adminmenu', 'com_banners_tracks', 'Tracks', '', 'index.php?option=com_banners&view=tracks', 'component', 0, 2, 0, 2, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-tracks', 0, '', 6, 7, 0),
(6, '_adminmenu', 'com_banners_categories', 'Categories', '', 'index.php?option=com_categories&extension=com_banners', 'component', 0, 2, 0, 2, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-cat', 0, '', 8, 9, 0),
(7, '_adminmenu', 'com_contact', 'Contacts', '', 'index.php?option=com_contact', 'component', 0, 1, 0, 7, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 11, 16, 0),
(8, '_adminmenu', 'com_contact', 'Contacts', '', 'index.php?option=com_contact', 'component', 0, 7, 0, 7, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 12, 13, 0),
(9, '_adminmenu', 'com_contact_categories', 'Categories', '', 'index.php?option=com_categories&extension=com_contact', 'component', 0, 7, 0, 7, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact-cat', 0, '', 14, 15, 0),
(10, '_adminmenu', 'com_messages', 'Messaging', '', 'index.php?option=com_messages', 'component', 0, 1, 0, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages', 0, '', 17, 22, 0),
(11, '_adminmenu', 'com_messages_add', 'New Private Message', '', 'index.php?option=com_messages&task=message.add', 'component', 0, 10, 0, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-add', 0, '', 18, 19, 0),
(12, '_adminmenu', 'com_messages_read', 'Read Private Message', '', 'index.php?option=com_messages', 'component', 0, 10, 0, 17, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-read', 0, '', 20, 21, 0),
(13, '_adminmenu', 'com_newsfeeds', 'News Feeds', '', 'index.php?option=com_newsfeeds', 'component', 0, 1, 0, 19, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 23, 28, 0),
(14, '_adminmenu', 'com_newsfeeds_feeds', 'Feeds', '', 'index.php?option=com_newsfeeds', 'component', 0, 13, 0, 19, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 24, 25, 0),
(15, '_adminmenu', 'com_newsfeeds_categories', 'Categories', '', 'index.php?option=com_categories&extension=com_newsfeeds', 'component', 0, 13, 0, 19, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds-cat', 0, '', 26, 27, 0),
(16, '_adminmenu', 'com_redirect', 'Redirect', '', 'index.php?option=com_redirect', 'component', 0, 1, 0, 21, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:redirect', 0, '', 29, 30, 0),
(17, '_adminmenu', 'com_search', 'Search', '', 'index.php?option=com_search', 'component', 0, 1, 0, 22, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:search', 0, '', 31, 32, 0),
(18, '_adminmenu', 'com_weblinks', 'Weblinks', '', 'index.php?option=com_weblinks', 'component', 0, 1, 0, 26, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 33, 38, 0),
(19, '_adminmenu', 'com_weblinks_links', 'Links', '', 'index.php?option=com_weblinks', 'component', 0, 18, 0, 26, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks', 0, '', 34, 35, 0),
(20, '_adminmenu', 'com_weblinks_categories', 'Categories', '', 'index.php?option=com_categories&extension=com_weblinks', 'component', 0, 18, 0, 26, 0, 0, '0000-00-00 00:00:00', 0, 0, 'class:weblinks-cat', 0, '', 36, 37, 0),
(21, 'mainmenu', 'Home', 'home', 'home', 'index.php?option=com_content&view=frontpage', 'component', 1, 1, 1, 8, 0, 0, '0000-00-00 00:00:00', 0, 1, '', 0, '{"show_page_title":"1","page_title":"Welcome to the Frontpage","show_description":"0","show_description_image":"0","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","show_title":"1","pageclass_sfx":"","menu_image":"-1","secure":"0","orderby_pri":"","orderby_sec":"front","show_pagination":"2","show_pagination_results":"1","show_noauth":"0","link_titles":"0","show_intro":"1","show_section":"0","link_section":"0","show_category":"0","link_category":"0","show_author":"1","show_create_date":"1","show_modify_date":"1","show_item_navigation":"0","show_readmore":"1","show_vote":"0","show_icons":"1","show_pdf_icon":"1","show_print_icon":"1","show_email_icon":"1","show_hits":"1"}', 38, 39, 1);

# -------------------------------------------------------

#
# Table structure for table `#__menu_types`
#

CREATE TABLE `#__menu_types` (
  `id` integer unsigned NOT NULL auto_increment,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `#__menu_types` VALUES (1, 'mainmenu', 'Main Menu', 'The main menu for the site');

# -------------------------------------------------------

#
# Table structure for table `#__messages`
#

CREATE TABLE `#__messages` (
  `message_id` integer unsigned NOT NULL auto_increment,
  `user_id_from` integer unsigned NOT NULL default '0',
  `user_id_to` integer unsigned NOT NULL default '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY  (`message_id`),
  KEY `useridto_state` (`user_id_to`, `state`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
# -------------------------------------------------------

#
# Table structure for table `#__messages_cfg`
#

CREATE TABLE `#__messages_cfg` (
  `user_id` integer unsigned NOT NULL default '0',
  `cfg_name` varchar(100) NOT NULL default '',
  `cfg_value` varchar(255) NOT NULL default '',
  UNIQUE `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
# -------------------------------------------------------

#
# Table structure for table `#__modules`
#

CREATE TABLE `#__modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) DEFAULT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` varchar(5120) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` varchar(7) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `#__modules` VALUES
(1, 'Main Menu', '', 1, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_menu', 1, 1, 'menutype=mainmenu\nmoduleclass_sfx=_menu\n', 0, ''),
(2, 'Login', '', 1, 'login', 0, '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, '', 1, ''),
(3, 'Popular Articles','',3,'cpanel',0,'0000-00-00 00:00:00',1,'mod_popular',3,1,'',1, ''),
(4, 'Recently Added Articles','',4,'cpanel',0,'0000-00-00 00:00:00',1,'mod_latest',3,1,'ordering=c_dsc\nuser_id=0\ncache=0\n\n',1, ''),
(6, 'Unread Messages','',1,'header',0,'0000-00-00 00:00:00',1,'mod_unread',3,1,'',1, ''),
(7, 'Online Users','',2,'header',0,'0000-00-00 00:00:00',1,'mod_online',3,1,'',1, ''),
(8, 'Toolbar','',1,'toolbar',0,'0000-00-00 00:00:00',1,'mod_toolbar',3,1,'',1, ''),
(9, 'Quick Icons','',1,'icon',0,'0000-00-00 00:00:00',1,'mod_quickicon',3,1,'',1, ''),
(10, 'Logged-in Users','',2,'cpanel',0,'0000-00-00 00:00:00',1,'mod_logged',3,1,'',1, ''),
(12, 'Admin Menu','', 1,'menu', 0,'0000-00-00 00:00:00', 1,'mod_menu', 3, 1, '', 1, ''),
(13, 'Admin Submenu','', 1,'submenu', 0,'0000-00-00 00:00:00', 1,'mod_submenu', 3, 1, '', 1, ''),
(14, 'User Status','', 1,'status', 0,'0000-00-00 00:00:00', 1,'mod_status', 3, 1, '', 1, ''),
(15, 'Title','', 1,'title', 0,'0000-00-00 00:00:00', 1,'mod_title', 3, 1, '', 1, ''),
(16, 'User Menu', '', 4, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_menu', 2, 1, 'menutype=usermenu\nmoduleclass_sfx=_menu\ncache=1', 0, ''),
(17, 'Login Form', '', 8, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, 'greeting=1\nname=0', 0, ''),
(18, 'Breadcrumbs', '', 1, 'breadcrumb', 0, '0000-00-00 00:00:00', 1, 'mod_breadcrumbs', 1, 1, 'moduleclass_sfx=\ncache=0\nshowHome=1\nhomeText=Home\nshowComponent=1\nseparator=\n\n', 0, ''),
(19, 'Banners', '', 1, 'bottom', 0, '0000-00-00 00:00:00', 0, 'mod_banners', 1, 1, '{"target":"1","count":"1","cid":"1","catid":"27","tag_search":"0","ordering":"0","header_text":"","footer_text":"","layout":"","moduleclass_sfx":"","cache":"1","cache_time":"0"}', 0, '');

# -------------------------------------------------------

#
# Table structure for table `#__modules_menu`
#

CREATE TABLE `#__modules_menu` (
  `moduleid` integer NOT NULL default '0',
  `menuid` integer NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__modules_menu`
#

INSERT INTO `#__modules_menu` VALUES
(1,0),
(2,0),
(3,0),
(4,0),
(5,0),
(6,0),
(7,0),
(8,0),
(9,0),
(10,0),
(11,0),
(12,0),
(13,0),
(14,0),
(15,0),
(16,0),
(17,0),
(18,0),
(19,0);

# -------------------------------------------------------

#
# Table structure for table `#__newsfeeds`
#

CREATE TABLE `#__newsfeeds` (
  `catid` integer NOT NULL default '0',
  `id` integer(10) UNSIGNED NOT NULL auto_increment,
  `name`  varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(100) NOT NULL default '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `filename` varchar(200) default NULL,
  `published` tinyint(1) NOT NULL default '0',
  `numarticles` integer unsigned NOT NULL default '1',
  `cache_time` integer unsigned NOT NULL default '3600',
  `checked_out` integer(10) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` integer NOT NULL default '0',
  `rtl` tinyint(4) NOT NULL default '0',
  `access` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `published` (`published`),
  KEY `idx_access` (`access`),
  KEY `catid` (`catid`),
  INDEX `idx_language` (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__redirect_links`
#

CREATE TABLE `#__redirect_links` (
  `id` integer unsigned NOT NULL auto_increment,
  `old_url` varchar(150) NOT NULL,
  `new_url` varchar(150) NOT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `published` tinyint(4) NOT NULL,
  `created_date` integer NOT NULL,
  `updated_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_updated` (`updated_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


# -------------------------------------------------------

#
# Table structure for table `#__schemas`
#

CREATE TABLE `#__schemas` (
  `extensionid` int(11) NOT NULL,
  `versionid` varchar(20) NOT NULL,
  PRIMARY KEY (`extensionid`, `versionid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__session`
#

CREATE TABLE `#__session` (
  `session_id` varchar(32) NOT NULL default '',
  `client_id` tinyint(3) unsigned NOT NULL default '0',
  `guest` tinyint(4) unsigned default '1',
  `time` varchar(14) default '',
  `data` varchar(20480) default NULL,
  `userid` int(11) default '0',
  `username` varchar(150) default '',
  `usertype` varchar(50) default '',
  PRIMARY KEY  (`session_id`),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


# -------------------------------------------------------

# Update Sites
CREATE TABLE  `#__updates` (
  `update_id` int(11) NOT NULL auto_increment,
  `update_site_id` int(11) default '0',
  `extension_id` int(11) default '0',
  `categoryid` int(11) default '0',
  `name` varchar(100) default '',
  `description` text NOT NULL,
  `element` varchar(100) default '',
  `type` varchar(20) default '',
  `folder` varchar(20) default '',
  `client_id` tinyint(3) default '0',
  `version` varchar(10) default '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  PRIMARY KEY  (`update_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Available Updates';

CREATE TABLE  `#__update_sites` (
  `update_site_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default '',
  `type` varchar(20) default '',
  `location` text NOT NULL,
  `enabled` int(11) default '0',
  PRIMARY KEY  (`update_site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Update Sites';

CREATE TABLE `#__update_sites_extensions` (
  `update_site_id` INT DEFAULT 0,
  `extension_id` INT DEFAULT 0,
  INDEX `newindex`(`update_site_id`, `extension_id`)
) ENGINE = MYISAM CHARACTER SET utf8 COMMENT = 'Links extensions to update sites';

CREATE TABLE  `#__update_categories` (
  `categoryid` int(11) NOT NULL auto_increment,
  `name` varchar(20) default '',
  `description` text NOT NULL,
  `parent` int(11) default '0',
  `updatesite` int(11) default '0',
  PRIMARY KEY  (`categoryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Update Categories';


# -------------------------------------------------------

#
# Table structure for table `#__stats_agents`
#

CREATE TABLE `#__stats_agents` (
  `agent` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '0',
  `hits` integer unsigned NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__template_styles`
#

CREATE TABLE IF NOT EXISTS `#__template_styles` (
  `id` integer unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `home` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;

INSERT INTO `#__template_styles` VALUES (1, 'rhuk_milkyway', '0', '1', 'Default', '{"colorVariation":"blue","backgroundVariation":"blue","widthStyle":"fmax"}');
INSERT INTO `#__template_styles` VALUES (2, 'bluestork', '1', '1', 'Default', '{"useRoundedCorners":"1","showSiteName":"0"}');
INSERT INTO `#__template_styles` VALUES (3, 'atomic', '0', '0', 'Default', '{}');

# -------------------------------------------------------
#
# Table structure for table `#__user_usergroup_map`
#

CREATE TABLE IF NOT EXISTS `#__user_usergroup_map` (
  `user_id` integer unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` integer unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY  (`user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__usergroups`
#

CREATE TABLE IF NOT EXISTS `#__usergroups` (
  `id` integer unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `parent_id` integer unsigned NOT NULL default '0' COMMENT 'Adjacency List Reference Id',
  `lft` integer NOT NULL default '0' COMMENT 'Nested set lft.',
  `rgt` integer NOT NULL default '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` USING BTREE (`lft`,`rgt`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `#__usergroups` (`id` ,`parent_id` ,`lft` ,`rgt` ,`title`)
VALUES
	(1,0,1,20,'Public'),
	(2,1,8,19,'Registered'),
	(3,2,11,16,'Author'),
	(4,3,12,15,'Editor'),
	(5,4,13,14,'Publisher'),
	(6,1,2,7,'Manager'),
	(7,6,3,6,'Administrator'),
	(8,7,4,5,'Super Users');

# -------------------------------------------------------

#
# Table structure for table `#__users`
#

CREATE TABLE `#__users` (
  `id` integer NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `username` varchar(150) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `usertype` varchar(25) NOT NULL default '',
  `block` tinyint(4) NOT NULL default '0',
  `sendEmail` tinyint(4) default '0',
  `registerDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL default '',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

CREATE TABLE IF NOT EXISTS `#__user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` varchar(255) NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

#
# Table structure for table `#__weblinks`
#

CREATE TABLE `#__weblinks` (
  `id` integer unsigned NOT NULL auto_increment,
  `catid` integer NOT NULL default '0',
  `sid` integer NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `url` varchar(250) NOT NULL default '',
  `description` TEXT NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` integer NOT NULL default '0',
  `state` tinyint(1) NOT NULL default '0',
  `checked_out` integer NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` integer NOT NULL default '0',
  `archived` tinyint(1) NOT NULL default '0',
  `approved` tinyint(1) NOT NULL default '1',
  `access` integer NOT NULL default '1',
  `params` text NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`state`,`archived`),
  INDEX `idx_language` (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

# -------------------------------------------------------

#
# Table structure for table `#__viewlevels`
#

CREATE TABLE IF NOT EXISTS `#__viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

#
# Dumping data for table `#__viewlevels`
#

INSERT INTO `#__viewlevels` (`id`, `title`, `ordering`, `rules`) VALUES
(1, 'Public', 0, '[]'),
(2, 'Registered', 1, '[2]'),
(3, 'Special', 2, '["6","7","8"]');

# -------------------------------------------------------
