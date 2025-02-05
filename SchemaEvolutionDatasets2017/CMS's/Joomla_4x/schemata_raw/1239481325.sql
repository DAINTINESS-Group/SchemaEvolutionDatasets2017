# $Id$

# --------------------------------------------------------

#
# Table structure for table `#__banner`
#

CREATE TABLE `#__banner` (
  `bid` int(11) NOT NULL auto_increment,
  `cid` int(11) NOT NULL default '0',
  `type` varchar(30) NOT NULL default 'banner',
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `imptotal` int(11) NOT NULL default '0',
  `impmade` int(11) NOT NULL default '0',
  `clicks` int(11) NOT NULL default '0',
  `imageurl` varchar(100) NOT NULL default '',
  `clickurl` varchar(200) NOT NULL default '',
  `date` datetime default NULL,
  `showBanner` tinyint(1) NOT NULL default '0',
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `editor` varchar(50) default NULL,
  `custombannercode` text,
  `catid` INTEGER UNSIGNED NOT NULL DEFAULT 0,
  `description` TEXT NOT NULL DEFAULT '',
  `sticky` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
  `ordering` INTEGER NOT NULL DEFAULT 0,
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `tags` TEXT NOT NULL DEFAULT '',
  `params` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY  (`bid`),
  KEY `viewbanner` (`showBanner`),
  INDEX `idx_banner_catid`(`catid`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__bannerclient`
#

CREATE TABLE `#__bannerclient` (
  `cid` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `contact` varchar(255) NOT NULL default '',
  `email` varchar(255) NOT NULL default '',
  `extrainfo` text NOT NULL,
  `checked_out` tinyint(1) NOT NULL default '0',
  `checked_out_time` time default NULL,
  `editor` varchar(50) default NULL,
  PRIMARY KEY  (`cid`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__bannertrack`
#

CREATE TABLE  `#__bannertrack` (
  `track_date` date NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__categories`
#

CREATE TABLE `#__categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `ref_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `lang` varchar(5) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`)
) ENGINE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__components`
#

CREATE TABLE `#__components` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `link` varchar(255) NOT NULL default '',
  `menuid` int(11) unsigned NOT NULL default '0',
  `parent` int(11) unsigned NOT NULL default '0',
  `admin_menu_link` varchar(255) NOT NULL default '',
  `admin_menu_alt` varchar(255) NOT NULL default '',
  `option` varchar(50) NOT NULL default '',
  `ordering` int(11) NOT NULL default '0',
  `admin_menu_img` varchar(255) NOT NULL default '',
  `iscore` tinyint(4) NOT NULL default '0',
  `params` text NOT NULL,
  `enabled` tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `parent_option` (`parent`, `option`(32))
) TYPE=MyISAM CHARACTER SET `utf8`;

#
# Dumping data for table `#__components`
#

INSERT INTO `#__components` VALUES (1, 'Banners', '', 0, 0, '', 'Banner Management', 'com_banners', 0, 'js/ThemeOffice/component.png', 0, '{"track_impressions":"0","track_clicks":"0","tag_prefix":""}', 1);
INSERT INTO `#__components` VALUES (2, 'Banners', '', 0, 1, 'option=com_banners', 'Active Banners', 'com_banners', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `#__components` VALUES (3, 'Clients', '', 0, 1, 'option=com_banners&c=client', 'Manage Clients', 'com_banners', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `#__components` VALUES (4, 'Web Links', 'option=com_weblinks', 0, 0, '', 'Manage Weblinks', 'com_weblinks', 0, 'js/ThemeOffice/component.png', 0, '{"show_comp_description":"1","comp_description":"","show_link_hits":"1","show_link_description":"1","show_other_cats":"1","show_headings":"1","show_numbers":"1","show_report":"1","target":"0","link_icons":"","show_snapshot":"0","snapshot_width":"120","snapshot_height":"90"}', 1);
INSERT INTO `#__components` VALUES (5, 'Links', '', 0, 4, 'option=com_weblinks', 'View existing weblinks', 'com_weblinks', 1, 'js/ThemeOffice/edit.png', 0, '', 1);
INSERT INTO `#__components` VALUES (6, 'Categories', '', 0, 4, 'option=com_categories&extension=com_weblinks', 'Manage weblink categories', 'com_weblinks', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `#__components` VALUES (7, 'Contact', 'option=com_contact', 0, 0, 'option=com_contact', 'Contact', 'com_contact', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `#__components` VALUES (8, 'Contacts', '', 0, 7, 'option=com_contact&controller=contact', 'Contacts', 'com_contact', 1, '', 0, '', 1);
INSERT INTO `#__components` VALUES (9, 'Categories', '', 0, 7, 'option=com_categories&extension=com_contact', 'Categories', 'com_contact', 2, '', 0, '', 1);
INSERT INTO `#__components` VALUES (10, 'Fields', '', 0, 7, 'option=com_contact&controller=field', 'Fields', 'com_contact', 3, '', 0, '', 1);
INSERT INTO `#__components` VALUES (11, 'News Feeds', 'option=com_newsfeeds', 0, 0, '', 'News Feeds Management', 'com_newsfeeds', 0, 'js/ThemeOffice/component.png', 0, '', 1);
INSERT INTO `#__components` VALUES (12, 'Feeds', '', 0, 11, 'option=com_newsfeeds', 'Manage News Feeds', 'com_newsfeeds', 1, 'js/ThemeOffice/edit.png', 0, '{"show_headings":"1","show_name":"1","show_articles":"1","show_link":"1","show_cat_description":"1","show_cat_items":"1","show_feed_image":"1","show_feed_description":"1","show_item_description":"1","feed_word_count":"0"}', 1);
INSERT INTO `#__components` VALUES (13, 'Categories', '', 0, 11, 'option=com_categories&extension=com_newsfeeds', 'Manage Categories', 'com_newsfeeds', 2, 'js/ThemeOffice/categories.png', 0, '', 1);
INSERT INTO `#__components` VALUES (14, 'User', 'option=com_user', 0, 0, '', '', 'com_user', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (15, 'Search', 'option=com_search', 0, 0, 'option=com_search', 'Search Statistics', 'com_search', 0, 'js/ThemeOffice/component.png', 1, '{"enabled":"0","show_date":"1"}', 1);
INSERT INTO `#__components` VALUES (16, 'Categories', '', 0, 1, 'option=com_categories&extension=com_banner', 'Categories', '', 3, '', 1, '', 1);
INSERT INTO `#__components` VALUES (17, 'Wrapper', 'option=com_wrapper', 0, 0, '', 'Wrapper', 'com_wrapper', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (18, 'Mail To', '', 0, 0, '', '', 'com_mailto', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (19, 'Media Manager', '', 0, 0, 'option=com_media', 'Media Manager', 'com_media', 0, '', 1, '{"upload_extensions":"bmp,csv,doc,epg,gif,ico,jpg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,EPG,GIF,ICO,JPG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10000000","file_path":"images","image_path":"images","restrict_uploads":"1","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\/jpeg,image\/gif,image\/png,image\/bmp,application\/x-shockwave-flash,application\/msword,application\/excel,application\/pdf,application\/powerpoint,text\/plain,application\/x-zip","upload_mime_illegal":"text\/html","enable_flash":"1"}', 1);
INSERT INTO `#__components` VALUES (20, 'Articles', 'option=com_content', 0, 0, '', '', 'com_content', 0, '', 1, '{"show_noauth":"0","show_title":"1","link_titles":"0","show_intro":"1","show_category":"0","link_category":"0","show_author":"1","show_create_date":"1","show_modify_date":"1","show_item_navigation":"0","show_readmore":"1","show_vote":"0","show_icons":"1","show_pdf_icon":"1","show_print_icon":"1","show_email_icon":"1","show_hits":"1","feed_summary":"0","filter_tags":"","filter_attritbutes":""}', 1);
INSERT INTO `#__components` VALUES (21, 'Configuration Manager', '', 0, 0, '', 'Configuration', 'com_config', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (22, 'Installation Manager', '', 0, 0, '', 'Installer', 'com_installer', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (23, 'Language Manager', '', 0, 0, '', 'Languages', 'com_languages', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (24, 'Mass mail', '', 0, 0, '', 'Mass Mail', 'com_massmail', 0, '', 1, '{"mailSubjectPrefix":"","mailBodySuffix":""}', 1);
INSERT INTO `#__components` VALUES (25, 'Menu Editor', '', 0, 0, '', 'Menu Editor', 'com_menus', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (26, 'Messaging', '', 0, 0, '', 'Messages', 'com_messages', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (27, 'Modules Manager', '', 0, 0, '', 'Modules', 'com_modules', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (28, 'Plugin Manager', '', 0, 0, '', 'Plugins', 'com_plugins', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (29, 'Template Manager', '', 0, 0, '', 'Templates', 'com_templates', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (30, 'Cache Manager', '', 0, 0, '', 'Cache', 'com_cache', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (31, 'Control Panel', '', 0, 0, '', 'Control Panel', 'com_cpanel', 0, '', 1, '', 1);
INSERT INTO `#__components` VALUES (32, 'Members', '', 0, 0, 'option=com_members', 'Member Manager', 'com_members', 0, 'js/ThemeOffice/component.png', 0, '', 1);

# --------------------------------------------------------

#
# Table structure for table `#__content`
#

CREATE TABLE `#__content` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `title_alias` varchar(255) NOT NULL default '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL default '0',
  `sectionid` int(11) unsigned NOT NULL default '0',
  `mask` int(11) unsigned NOT NULL default '0',
  `catid` int(11) unsigned NOT NULL default '0',
  `created` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_by` int(11) unsigned NOT NULL default '0',
  `created_by_alias` varchar(255) NOT NULL default '',
  `modified` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_by` int(11) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL default '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL default '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` text NOT NULL,
  `version` int(11) unsigned NOT NULL default '1',
  `parentid` int(11) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0',
  `metadata` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `idx_section` (`sectionid`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__content_frontpage`
#

CREATE TABLE `#__content_frontpage` (
  `content_id` int(11) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`content_id`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__content_rating`
#

CREATE TABLE `#__content_rating` (
  `content_id` int(11) NOT NULL default '0',
  `rating_sum` int(11) unsigned NOT NULL default '0',
  `rating_count` int(11) unsigned NOT NULL default '0',
  `lastip` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`content_id`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

# Table structure for table `#__core_log_items`

CREATE TABLE `#__core_log_items` (
  `time_stamp` date NOT NULL default '0000-00-00',
  `item_table` varchar(50) NOT NULL default '',
  `item_id` int(11) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '0'
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

# Table structure for table `#__core_log_searches`

CREATE TABLE `#__core_log_searches` (
  `search_term` varchar(128) NOT NULL default '',
  `hits` int(11) unsigned NOT NULL default '0'
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

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
  `access` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
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


# Plugins
INSERT INTO `#__extensions` VALUES(0, 'Authentication - Joomla', 'plugin', 'joomla', 'authentication', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 1, 0);
INSERT INTO `#__extensions` VALUES(0, 'Authentication - LDAP', 'plugin', 'ldap', 'authentication', 0, 0, 0, 0, '', '{"host":"","port":"389","use_ldapV3":"0","negotiate_tls":"0","no_referrals":"0","auth_method":"bind","base_dn":"","search_string":"","users_dn":"","username":"","password":"","ldap_fullname":"fullName","ldap_email":"mail","ldap_uid":"uid"}', '', '', 0, '0000-00-00 00:00:00', 2, 0);
INSERT INTO `#__extensions` VALUES(0, 'Authentication - GMail', 'plugin', 'gmail', 'authentication', 0, 0, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 4, 0);
INSERT INTO `#__extensions` VALUES(0, 'Authentication - OpenID', 'plugin', 'openid', 'authentication', 0, 0, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 3, 0);
INSERT INTO `#__extensions` VALUES(0, 'User - Joomla!', 'plugin', 'joomla', 'user', 0, 1, 0, 0, '', '{"autoregister":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'User - Profile', 'plugin', 'profile', 'user', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Content', 'plugin', 'content', 'search', 0, 1, 0, 0, '', '{"search_limit":"50","search_content":"1","search_uncategorised":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 1, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Contact', 'plugin', 'contact', 'search', 0, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 7, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Categories', 'plugin', 'categories', 'search', 0, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 4, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Sections', 'plugin', 'sections', 'search', 0, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 5, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Newsfeeds', 'plugin', 'newsfeeds', 'search', 0, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 6, 0);
INSERT INTO `#__extensions` VALUES(0, 'Search - Weblinks', 'plugin', 'weblinks', 'search', 0, 1, 0, 0, '', '{"search_limit":"50"}', '', '', 0, '0000-00-00 00:00:00', 2, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Pagebreak', 'plugin', 'pagebreak', 'content', 0, 1, 0, 0, '', '{"enabled":"1","title":"1","multipage_toc":"1","showall":"1"}', '', '', 0, '0000-00-00 00:00:00', 10000, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Rating', 'plugin', 'vote', 'content', 0, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 4, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Email Cloaking', 'plugin', 'emailcloak', 'content', 0, 1, 0, 0, '', '{"mode":"1"}', '', '', 0, '0000-00-00 00:00:00', 5, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Code Hightlighter (GeSHi)', 'plugin', 'geshi', 'content', 0, 0, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 5, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Load Module', 'plugin', 'loadmodule', 'content', 0, 1, 0, 0, '', '{"enabled":"1","style":"table"}', '', '', 0, '0000-00-00 00:00:00', 6, 0);
INSERT INTO `#__extensions` VALUES(0, 'Content - Page Navigation', 'plugin', 'pagenavigation', 'content', 0, 1, 0, 0, '', '{"position":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor - No Editor', 'plugin', 'none', 'editors', 0, 1, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor - TinyMCE 2.0', 'plugin', 'tinymce', 'editors', 0, 1, 0, 0, '', '{"theme":"advanced","cleanup_startup":"0","cleanup_save":"2","cleanup_entities":"1","autosave":"0","compressed":"0","relative_urls":"1","text_direction":"ltr","lang_mode":"0","lang_code":"en","invalid_elements":"applet","content_css":"1","content_css_custom":"","newlines":"0","extended_elements":"","toolbar":"top","hr":"1","smilies":"1","table":"1","style":"1","layer":"1","xhtmlxtras":"0","template":"0","directionality":"1","fullscreen":"1","html_height":"550","html_width":"750","preview":"1","element_path":"0","insertdate":"1","format_date":"%Y-%m-%d","inserttime":"1","format_time":"%H:%M:%S"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor - XStandard Lite 2.0', 'plugin', 'xstandard', 'editors', 0, 0, 0, 1, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor Button - Image', 'plugin', 'image', 'editors-xtd', 0, 1, 0, 0, '', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor Button - Pagebreak', 'plugin', 'pagebreak', 'editors-xtd', 0, 1, 0, 0, '', '', '', '', 42, '2009-04-01 10:14:48', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'Editor Button - Readmore', 'plugin', 'readmore', 'editors-xtd', 0, 1, 0, 0, '', '', '', '', 42, '2009-04-01 10:14:53', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'System - SEF', 'plugin', 'sef', 'system', 0, 1, 0, 0, '', '', '', '', 42, '2009-04-01 10:14:57', 1, 0);
INSERT INTO `#__extensions` VALUES(0, 'System - Debug', 'plugin', 'debug', 'system', 0, 1, 0, 0, '', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"2","language_prefix":""}', '', '', 0, '0000-00-00 00:00:00', 2, 0);
INSERT INTO `#__extensions` VALUES(0, 'System - Cache', 'plugin', 'cache', 'system', 0, 0, 0, 0, '', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 0, 0);
INSERT INTO `#__extensions` VALUES(0, 'System - Log', 'plugin', 'log', 'system', 0, 0, 0, 1, '', '', '', '', 42, '2009-04-01 10:15:19', 5, 0);
INSERT INTO `#__extensions` VALUES(0, 'System - Remember Me', 'plugin', 'remember', 'system', 0, 1, 0, 1, '', '', '', '', 42, '2009-04-01 10:15:25', 6, 0);
INSERT INTO #__extensions VALUES(0,"System - Backlink","plugin","backlink","system",0,0,0,1,"","","","",0,"0000-00-00 00:00:00",7,0);
# Components
INSERT INTO #__extensions VALUES(0,"Banners","component","com_banners","",1,1,0,0,"","track_impressions=0\ntrack_clicks=0\ntag_prefix=\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Cache Manager","component","com_cache","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Configuration Manager","component","com_config","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Contact","component","com_contact","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Articles","component","com_content","",1,1,0,1,"","show_noauth=0\nshow_title=1\nlink_titles=0\nshow_intro=1\nshow_section=0\nlink_section=0\nshow_category=0\nlink_category=0\nshow_author=1\nshow_create_date=1\nshow_modify_date=1\nshow_item_navigation=0\nshow_readmore=1\nshow_vote=0\nshow_icons=1\nshow_pdf_icon=1\nshow_print_icon=1\nshow_email_icon=1\nshow_hits=1\nfeed_summary=0\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Control Panel","component","com_cpanel","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Installation Manager","component","com_installer","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Language Manager","component","com_languages","",1,1,0,1,"","administrator=en-GB\nsite=en-GB","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Mail To","component","com_mailto","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Mass mail","component","com_massmail","",1,1,0,1,"","mailSubjectPrefix=\nmailBodySuffix=\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Media Manager","component","com_media","",1,1,0,1,"","upload_extensions=bmp,csv,doc,epg,gif,ico,jpg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,EPG,GIF,ICO,JPG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\nupload_maxsize=10000000\nfile_path=images\nimage_path=images\nrestrict_uploads=1\ncheck_mime=1\nimage_extensions=bmp,gif,jpg,png\nignore_extensions=\nupload_mime=image/jpeg,image/gif,image/png,image/bmp,application/x-shockwave\nflash,application/msword,application/excel,application/pdf,application/powerpoint,text/plain,application/x-zip\nupload_mime_illegal=text/html\nenable_flash=1\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Menu Editor","component","com_menus","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Messaging","component","com_messages","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Modules Manager","component","com_modules","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"News Feeds","component","com_newsfeeds","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Plugin Manager","component","com_plugins","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Search","component","com_search","",1,1,0,1,"","enabled=0\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Template Manager","component","com_templates","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"User","component","com_user","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"User Manager","component","com_users","",1,1,0,1,"","allowUserRegistration=1\nnew_usertype=Registered\nuseractivation=1\nfrontend_userparams=1\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Web Links","component","com_weblinks","",1,1,0,0,"","show_comp_description=1\ncomp_description=\nshow_link_hits=1\nshow_link_description=1\nshow_other_cats=1\nshow_headings=1\nshow_page_title=1\nlink_target=0\nlink_icons=\n\n","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Wrapper","component","com_wrapper","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"Member Manager","component","com_members","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
# Modules
INSERT INTO #__extensions VALUES(0,"mod_login","module","mod_login","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_popular","module","mod_popular","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_latest","module","mod_latest","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_unread","module","mod_unread","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_online","module","mod_online","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_toolbar","module","mod_toolbar","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_quickicon","module","mod_quickicon","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_logged","module","mod_logged","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_footer","module","mod_footer","",1,1,0,1,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_menu","module","mod_menu","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_submenu","module","mod_submenu","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_status","module","mod_status","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);
INSERT INTO #__extensions VALUES(0,"mod_title","module","mod_title","",1,1,0,0,"","","","",0,"0000-00-00 00:00:00",0,0);

# --------------------------------------------------------

#
# Table structure for table `#__menu`
#

CREATE TABLE `#__menu` (
  `id` int(11) NOT NULL auto_increment,
  `menutype` varchar(75) default NULL,
  `name` varchar(255) default NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text,
  `type` varchar(50) NOT NULL default '',
  `published` tinyint(1) NOT NULL default 0,
  `parent` int(11) unsigned NOT NULL default 0,
  `componentid` int(11) unsigned NOT NULL default 0,
  `sublevel` int(11) default 0,
  `ordering` int(11) default 0,
  `checked_out` int(11) unsigned NOT NULL default 0,
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `pollid` int(11) NOT NULL default 0,
  `browserNav` tinyint(4) default 0,
  `access` tinyint(3) unsigned NOT NULL default 0,
  `utaccess` tinyint(3) unsigned NOT NULL default 0,
  `template_id` int(11) default 0,
  `params` text NOT NULL,
  `lft` int(11) unsigned NOT NULL default 0,
  `rgt` int(11) unsigned NOT NULL default 0,
  `home` INTEGER(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY  (`id`),
  KEY `componentid` (`componentid`,`menutype`,`published`,`access`),
  KEY `menutype` (`menutype`)
) TYPE=MyISAM CHARACTER SET `utf8`;

INSERT INTO `#__menu` VALUES (1, 'mainmenu', 'Home', 'home', 'index.php?option=com_content&view=frontpage', 'component', 1, 0, 20, 0, 1, 0, '0000-00-00 00:00:00', 0, 0, 0, 3, 0, '{"num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","orderby_pri":"","orderby_sec":"front","show_pagination":"2","show_pagination_results":"1","show_feed_link":"1","show_noauth":"","show_title":"","link_titles":"","show_intro":"","show_section":"","link_section":"","show_category":"","link_category":"","show_author":"","show_create_date":"","show_modify_date":"","show_item_navigation":"","show_readmore":"","show_vote":"","show_icons":"","show_pdf_icon":"","show_print_icon":"","show_email_icon":"","show_hits":"","feed_summary":"","page_title":"","show_page_title":"1","pageclass_sfx":"","menu_image":"-1","secure":"0"}', 0, 0, 1);

# --------------------------------------------------------

#
# Table structure for table `#__menu_types`
#

CREATE TABLE `#__menu_types` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `menutype` VARCHAR(75) NOT NULL DEFAULT '',
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `description` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY(`id`),
  UNIQUE `menutype`(`menutype`)
) TYPE=MyISAM CHARACTER SET `utf8`;

INSERT INTO `#__menu_types` VALUES (1, 'mainmenu', 'Main Menu', 'The main menu for the site');

# --------------------------------------------------------

#
# Table structure for table `#__messages`
#

CREATE TABLE `#__messages` (
  `message_id` int(10) unsigned NOT NULL auto_increment,
  `user_id_from` int(10) unsigned NOT NULL default '0',
  `user_id_to` int(10) unsigned NOT NULL default '0',
  `folder_id` int(10) unsigned NOT NULL default '0',
  `date_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` int(11) NOT NULL default '0',
  `priority` int(1) unsigned NOT NULL default '0',
  `subject` text NOT NULL default '',
  `message` text NOT NULL,
  PRIMARY KEY  (`message_id`),
  KEY `useridto_state` (`user_id_to`, `state`)
) TYPE=MyISAM CHARACTER SET `utf8`;
# --------------------------------------------------------

#
# Table structure for table `#__messages_cfg`
#

CREATE TABLE `#__messages_cfg` (
  `user_id` int(10) unsigned NOT NULL default '0',
  `cfg_name` varchar(100) NOT NULL default '',
  `cfg_value` varchar(255) NOT NULL default '',
  UNIQUE `idx_user_var_name` (`user_id`,`cfg_name`)
) TYPE=MyISAM CHARACTER SET `utf8`;
# --------------------------------------------------------

#
# Table structure for table `#__modules`
#

CREATE TABLE `#__modules` (
  `id` int(11) NOT NULL auto_increment,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  `position` varchar(50) default NULL,
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL default '0',
  `module` varchar(50) default NULL,
  `numnews` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `showtitle` tinyint(3) unsigned NOT NULL default '1',
  `params` text NOT NULL,
  `iscore` tinyint(4) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  `control` TEXT NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`)
) TYPE=MyISAM CHARACTER SET `utf8`;

INSERT INTO `#__modules` VALUES (1, 'Main Menu', '', 1, 'left', 0, '0000-00-00 00:00:00', 1, 'mod_mainmenu', 0, 0, 1, '{"menutype":"mainmenu","moduleclass_sfx":"_menu"}', 1, 0, '');
INSERT INTO `#__modules` VALUES (2, 'Login', '', 1, 'login', 0, '0000-00-00 00:00:00', 1, 'mod_login', 0, 0, 1, '{}', 1, 1, '');
INSERT INTO `#__modules` VALUES (3, 'Popular','',3,'cpanel',0,'0000-00-00 00:00:00',1,'mod_popular',0,2,1,'{}',0, 1, '');
INSERT INTO `#__modules` VALUES (4, 'Recent added Articles','',4,'cpanel',0,'0000-00-00 00:00:00',1,'mod_latest',0,2,1,'{"ordering":"c_dsc","user_id":"0","cache":"0"}',0, 1, '');
INSERT INTO `#__modules` VALUES (6, 'Unread Messages','',1,'header',0,'0000-00-00 00:00:00',1,'mod_unread',0,2,1,'{}',1, 1, '');
INSERT INTO `#__modules` VALUES (7, 'Online Users','',2,'header',0,'0000-00-00 00:00:00',1,'mod_online',0,2,1,'{}',1, 1, '');
INSERT INTO `#__modules` VALUES (8, 'Toolbar','',1,'toolbar',0,'0000-00-00 00:00:00',1,'mod_toolbar',0,2,1,'{}',1, 1, '');
INSERT INTO `#__modules` VALUES (9, 'Quick Icons','',1,'icon',0,'0000-00-00 00:00:00',1,'mod_quickicon',0,2,1,'{}',1,1, '');
INSERT INTO `#__modules` VALUES (10, 'Logged in Users','',2,'cpanel',0,'0000-00-00 00:00:00',1,'mod_logged',0,2,1,'{}',0,1, '');
INSERT INTO `#__modules` VALUES (11, 'Footer', '', 0, 'footer', 0, '0000-00-00 00:00:00', 1, 'mod_footer', 0, 0, 1, '{}', 1, 1, '');
INSERT INTO `#__modules` VALUES (12, 'Admin Menu','', 1,'menu', 0,'0000-00-00 00:00:00', 1,'mod_menu', 0, 2, 1, '{}', 0, 1, '');
INSERT INTO `#__modules` VALUES (13, 'Admin SubMenu','', 1,'submenu', 0,'0000-00-00 00:00:00', 1,'mod_submenu', 0, 2, 1, '{}', 0, 1, '');
INSERT INTO `#__modules` VALUES (14, 'User Status','', 1,'status', 0,'0000-00-00 00:00:00', 1,'mod_status', 0, 2, 1, '{}', 0, 1, '');
INSERT INTO `#__modules` VALUES (15, 'Title','', 1,'title', 0,'0000-00-00 00:00:00', 1,'mod_title', 0, 2, 1, '{}', 0, 1, '');

# --------------------------------------------------------

#
# Table structure for table `#__modules_menu`
#

CREATE TABLE `#__modules_menu` (
  `moduleid` int(11) NOT NULL default '0',
  `menuid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`moduleid`,`menuid`)
) TYPE=MyISAM CHARACTER SET `utf8`;

#
# Dumping data for table `#__modules_menu`
#

INSERT INTO `#__modules_menu` VALUES (1,0);

# --------------------------------------------------------

#
# Table structure for table `#__newsfeeds`
#

CREATE TABLE `#__newsfeeds` (
  `catid` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  `name` text NOT NULL,
  `alias` varchar(255) NOT NULL default '',
  `link` text NOT NULL,
  `filename` varchar(200) default NULL,
  `published` tinyint(1) NOT NULL default '0',
  `numarticles` int(11) unsigned NOT NULL default '1',
  `cache_time` int(11) unsigned NOT NULL default '3600',
  `checked_out` tinyint(3) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `rtl` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `published` (`published`),
  KEY `catid` (`catid`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__session`
#

CREATE TABLE `#__session` (
  `username` varchar(150) default '',
  `time` varchar(14) default '',
  `session_id` varchar(200) NOT NULL default '0',
  `guest` tinyint(4) default '1',
  `userid` int(11) default '0',
  `usertype` varchar(50) default '',
  `gid` tinyint(3) unsigned NOT NULL default '0',
  `client_id` tinyint(3) unsigned NOT NULL default '0',
  `data` longtext,
  PRIMARY KEY  (`session_id`(64)),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__stats_agents`
#

CREATE TABLE `#__stats_agents` (
  `agent` varchar(255) NOT NULL default '',
  `type` tinyint(1) unsigned NOT NULL default '0',
  `hits` int(11) unsigned NOT NULL default '1'
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__templates_menu`
#

CREATE TABLE `#__templates_menu` (
  `template` varchar(255) NOT NULL default '',
  `menuid` int(11) NOT NULL default '0',
  `client_id` tinyint(4) NOT NULL default '0',
  `params` text NOT NULL,
  PRIMARY KEY (`menuid`, `client_id`, `template`(255))
) TYPE=MyISAM CHARACTER SET `utf8`;

# Dumping data for table `#__templates_menu`
INSERT INTO `#__templates_menu` VALUES ('rhuk_milkyway', '0', '0', '{"colorVariation":"blue","backgroundVariation":"blue","widthStyle":"fmax"}');
INSERT INTO `#__templates_menu` VALUES ('khepri', '0', '1', '{"useRoundedCorners":"1","showSiteName":"0","headerColor":"h_green"}');

# --------------------------------------------------------

#
# Table structure for table `#__users`
#

CREATE TABLE `#__users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `username` varchar(150) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `password` varchar(100) NOT NULL default '',
  `usertype` varchar(25) NOT NULL default '',
  `block` tinyint(4) NOT NULL default '0',
  `sendEmail` tinyint(4) default '0',
  `gid` tinyint(3) unsigned NOT NULL default '1',
  `registerDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL default '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL default '',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `gid_block` (`gid`, `block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__weblinks`
#

CREATE TABLE `#__weblinks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `catid` int(11) NOT NULL default '0',
  `sid` int(11) NOT NULL default '0',
  `title` varchar(250) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `url` varchar(250) NOT NULL default '',
  `description` text NOT NULL default '',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL default '0',
  `state` tinyint(1) NOT NULL default '0',
  `checked_out` int(11) NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL default '0',
  `archived` tinyint(1) NOT NULL default '0',
  `approved` tinyint(1) NOT NULL default '1',
  `params` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `catid` (`catid`,`state`,`archived`)
) TYPE=MyISAM CHARACTER SET `utf8`;

# --------------------------------------------------------

#
# Table structure for table `#__contact_contacts`
#
CREATE TABLE IF NOT EXISTS `#__contact_contacts` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL default '',
  `published` tinyint(1) unsigned NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `params` text,
  `user_id` int(11) NOT NULL default '0',
  `access` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) DEFAULT CHARSET=utf8;

# --------------------------------------------------------

#
# Table structure for table `#__contact_con_cat_map`
#
CREATE TABLE IF NOT EXISTS `#__contact_con_cat_map` (
  `contact_id` int(11) NOT NULL,
  `catid` int(11) NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`contact_id`,`catid`)
) DEFAULT CHARSET=utf8;

# --------------------------------------------------------

#
# Table structure for table `#__contact_details`
#
CREATE TABLE IF NOT EXISTS `#__contact_details` (
  `contact_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `data` text character set utf8 NOT NULL,
  `show_contact` tinyint(1) NOT NULL default '1',
  `show_directory` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`contact_id`,`field_id`)
) DEFAULT CHARSET=utf8;

# --------------------------------------------------------

#
# Table structure for table `#__contact_fields`
#
CREATE TABLE IF NOT EXISTS `#__contact_fields` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `alias` varchar(255) NOT NULL,
  `description` mediumtext,
  `type` varchar(50) NOT NULL default 'text',
  `published` tinyint(1) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `pos` enum('title','top','left','main','right','bottom') NOT NULL default 'main',
  `access` tinyint(3) unsigned NOT NULL default '0',
  `params` text,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) DEFAULT CHARSET=utf8;

# Update Sites
CREATE TABLE  `#__updates` (
  `update_id` int(11) NOT NULL auto_increment,
  `update_site_id` int(11) default '0',
  `extension_id` int(11) default '0',
  `categoryid` int(11) default '0',
  `name` varchar(100) default '',
  `description` text,
  `element` varchar(100) default '',
  `type` varchar(20) default '',
  `folder` varchar(20) default '',
  `client_id` tinyint(3) default '0',
  `version` varchar(10) default '',
  `data` text,
  `detailsurl` text,
  PRIMARY KEY  (`update_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Available Updates';

CREATE TABLE  `#__update_sites` (
  `update_site_id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default '',
  `type` varchar(20) default '',
  `location` text,
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
  `description` text,
  `parent` int(11) default '0',
  `updatesite` int(11) default '0',
  PRIMARY KEY  (`categoryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Update Categories';


CREATE TABLE  `#__tasks` (
  `taskid` int(10) unsigned NOT NULL auto_increment,
  `tasksetid` int(10) unsigned NOT NULL default '0',
  `type` varchar(20) NOT NULL default '',
  `data` longtext,
  `offset` int(11) default '0',
  `total` int(11) default '0',
  `params` longtext,
  PRIMARY KEY  (`taskid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Individual tasks';

CREATE TABLE  `#__tasksets` (
  `tasksetid` int(10) unsigned NOT NULL auto_increment,
  `tasksetname` varchar(100) default NULL,
  `extensionid` int(10) unsigned default '0',
  `execution_page` text,
  `landing_page` text,
  `run_time` int(10) unsigned NOT NULL default '0',
  `max_time` int(10) unsigned NOT NULL default '0',
  `threshold` int(10) unsigned NOT NULL default '0',
  `data` text NOT NULL,
  PRIMARY KEY  (`tasksetid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Task Sets';


CREATE TABLE  `#__backups` (
  `backupid` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL default '',
  `description` text NOT NULL,
  `start` datetime NOT NULL default '0000-00-00 00:00:00',
  `end` datetime NOT NULL default '0000-00-00 00:00:00',
  `location` text NOT NULL,
  `data` text NOT NULL,
  `creator` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`backupid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Backups';

CREATE TABLE  `#__backup_entries` (
  `entryid` int(10) unsigned NOT NULL auto_increment,
  `backupid` int(10) unsigned NOT NULL default '0',
  `type` varchar(20) NOT NULL default '',
  `name` varchar(50) NOT NULL default '',
  `data` text NOT NULL,
  `params` text NOT NULL,
  PRIMARY KEY  (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Backup Entries';

--
-- Table structure for table `#__access_actions`
--

CREATE TABLE IF NOT EXISTS `#__access_actions` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `section_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_sections.id',
  `name` varchar(100) NOT NULL default '',
  `title` varchar(100) NOT NULL default '',
  `description` text,
  `access_type` int(1) unsigned NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_action_name_lookup` (`section_id`,`name`),
  KEY `idx_acl_manager_lookup` (`access_type`,`section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

REPLACE INTO `#__access_actions` VALUES 
(1, 1, 'core.view', 'View', '', 3, 0),
(2, 1, 'core.checkin.manage', 'JAction_Checkin_Manage', 'JAction_Checkin_Manage_Desc', 1, 0),
(3, 1, 'core.cache.manage', 'JAction_Cache_Manage', 'JAction_Cache_Manage_Desc', 1, 0),
(4, 1, 'core.config.manage', 'JAction_Config_Manage', 'JAction_Config_Manage_Desc', 1, 0),
(5, 1, 'core.installer.manage', 'JAction_Installer_Manage', 'JJAction_Installer_Manage_Desc', 1, 0),
(6, 1, 'core.languages.manage', 'JAction_Languages_Manage', 'JAction_Languages_Manage_Desc', 1, 0),
(7, 1, 'core.modules.manage', 'JAction_Modules_Manage', 'JAction_Modules_Manage_Desc', 1, 0),
(8, 1, 'core.plugins.manage', 'JAction_Plugins_Manage', 'JAction_Plugins_Manage_Desc', 1, 0),
(9, 1, 'core.templates.manage', 'JAction_Templates_Manage', 'JAction_Templates_Manage_Desc', 1, 0),
(10, 1, 'core.menus.manage', 'JAction_Menus_Manage', 'JAction_Menus_Manage_Desc', 1, 0),
(11, 1, 'core.users.manage', 'JAction_Users_Manage', 'JAction_Users_Manage_Desc', 1, 0),
(12, 1, 'core.media.manage', 'JAction_Media_Manage', 'JAction_Media_Manage_Desc', 1, 0),
(13, 1, 'core.site.login', 'JAction_Site_Login', 'JAction_Site_Login_Desc', 1, -1),
(14, 1, 'core.administrator.login', 'JAction_Administrator_Login', 'JAction_Administrator_Login_Desc', 1, -1),
(15, 1, 'core.root', 'JAction_Root', 'JAction_Root_Desc', 1, -2),
(16, 2, 'com_content.article.view', 'Article View', NULL, 3, 0)
;

-- --------------------------------------------------------

--
-- Table structure for table `#__access_action_rule_map`
--

CREATE TABLE IF NOT EXISTS `#__access_action_rule_map` (
  `action_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_actions.id',
  `rule_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_rules.id',
  PRIMARY KEY  (`action_id`,`rule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

REPLACE INTO `#__access_action_rule_map` VALUES 
(1, 1),
(1, 2),
(1, 3),
(13, 4),
(14, 5),
(16, 6)
;

-- --------------------------------------------------------

--
-- Table structure for table `#__access_assetgroups`
--

CREATE TABLE IF NOT EXISTS `#__access_assetgroups` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL default '0' COMMENT 'Adjacency List Reference Id',
  `left_id` int(10) unsigned NOT NULL default '0' COMMENT 'Nested Set Reference Id',
  `right_id` int(10) unsigned NOT NULL default '0' COMMENT 'Nested Set Reference Id',
  `title` varchar(100) NOT NULL default '',
  `section_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_sections.id',
  `section` varchar(100) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`section`,`title`),
  KEY `idx_assetgroup_adjacency_lookup` (`parent_id`),
  KEY `idx_assetgroup_nested_set_lookup` USING BTREE (`left_id`,`right_id`, `section_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

REPLACE INTO `#__access_assetgroups` VALUES 
(1, 0, 1, 6, 'Public', 1, 'core'),
(2, 1, 2, 3, 'Registered', 1, 'core'),
(3, 1, 4, 5, 'Special', 1, 'core');

-- --------------------------------------------------------

--
-- Table structure for table `#__access_assetgroup_rule_map`
--

CREATE TABLE IF NOT EXISTS `#__access_assetgroup_rule_map` (
  `group_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_assetgroups.id',
  `rule_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_rules.id',
  PRIMARY KEY  (`group_id`,`rule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

REPLACE INTO `jos_access_assetgroup_rule_map` VALUES 
(1, 1),
(2, 2),
(3, 3),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `#__access_assets`
--

CREATE TABLE IF NOT EXISTS `#__access_assets` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `section_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_sections.id',
  `section` varchar(100) NOT NULL default '0',
  `name` varchar(100) NOT NULL default '',
  `title` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_asset_name_lookup` (`section_id`,`name`),
  KEY `idx_asset_section_lookup` (`section`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `#__access_asset_assetgroup_map`
--

CREATE TABLE IF NOT EXISTS `#__access_asset_assetgroup_map` (
  `asset_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_assets.id',
  `group_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_assetgroups.id',
  PRIMARY KEY  (`asset_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `#__access_asset_rule_map`
--

CREATE TABLE IF NOT EXISTS `#__access_asset_rule_map` (
  `asset_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_assets.id',
  `rule_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_rules.id',
  PRIMARY KEY  (`asset_id`,`rule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `#__access_rules`
--

CREATE TABLE IF NOT EXISTS `#__access_rules` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `section_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_sections.id',
  `section` varchar(100) NOT NULL default '0',
  `name` varchar(100) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `description` varchar(255) default NULL,
  `ordering` int(11) NOT NULL default '0',
  `allow` int(1) unsigned NOT NULL default '0',
  `enabled` int(1) unsigned NOT NULL default '0',
  `access_type` int(1) unsigned NOT NULL default '0',
  `updated_date` int(10) unsigned NOT NULL default '0',
  `return` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_rule_name_lookup` (`section_id`,`name`),
  KEY `idx_access_check` (`enabled`, `allow`),
  KEY `idx_updated_lookup` (`updated_date`),
  KEY `idx_action_section_lookup` (`section`),
  KEY `idx_acl_manager_lookup` (`access_type`,`section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

REPLACE INTO `#__access_rules` VALUES 
(1, 1, 'core', 'core.view.1', 'SYSTEM', NULL, 0, 1, 1, 3, 0, NULL),
(2, 1, 'core', 'core.view.2', 'SYSTEM', NULL, 0, 1, 1, 3, 0, NULL),
(3, 1, 'core', 'core.view.3', 'SYSTEM', NULL, 0, 1, 1, 3, 0, NULL),
(4, 1, 'core', 'core.site.login', 'SYSTEM', NULL, 0, 1, 1, 1, 0, NULL),
(5, 1, 'core', 'core.administrator.login', 'SYSTEM', NULL, 0, 1, 1, 1, 0, NULL),
(6, 2, 'com_content', 'content.article.view', 'Article View', NULL, 0, 1, 1, 3, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `#__access_sections`
--

CREATE TABLE IF NOT EXISTS `#__access_sections` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `name` varchar(100) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `ordering` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_section_name_lookup` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

INSERT INTO `#__access_sections` VALUES 
(1, 'core', 'Core', -1),
(2, 'com_content', 'Content', 0);

-- --------------------------------------------------------

--
-- Table structure for table `#__usergroups`
--

CREATE TABLE IF NOT EXISTS `#__usergroups` (
  `id` int(10) unsigned NOT NULL auto_increment COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL default '0' COMMENT 'Adjacency List Reference Id',
  `left_id` int(10) unsigned NOT NULL default '0' COMMENT 'Nested Set Reference Id',
  `right_id` int(10) unsigned NOT NULL default '0' COMMENT 'Nested Set Reference Id',
  `title` varchar(100) NOT NULL default '',
  `section_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_sections.id',
  `section` varchar(100) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `idx_usergroup_title_lookup` (`section`,`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` USING BTREE (`left_id`,`right_id`, `section_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

REPLACE INTO `#__usergroups`
 (`id` ,`parent_id` ,`left_id` ,`right_id` ,`title` ,`section_id` ,`section`) VALUES
 (1 , 0, 1, 16, "Public", 1, "core"),
 (2 , 1, 2, 15, "Registered", 1, "core"),
 (3 , 2, 3, 8, "Author", 1, "core"),
 (4 , 3, 4, 7, "Editor", 1, "core"),
 (5 , 4, 5, 6, "Publisher", 1, "core"),
 (6 , 2, 9, 14, "Manager", 1, "core"),
 (7 , 6, 10, 13, "Administrator", 1, "core"),
 (8 , 7, 11, 12, "Super Administrator", 1, "core");

-- --------------------------------------------------------

--
-- Table structure for table `#__usergroup_rule_map`
--

CREATE TABLE IF NOT EXISTS `#__usergroup_rule_map` (
  `group_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__usergroups.id',
  `rule_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_rules.id',
  PRIMARY KEY  (`group_id`,`rule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `#__usergroup_rule_map` VALUES 
(1, 1),
(2, 2),
(6, 3),
(2, 4),
(6, 4),
(6, 5),
(1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `#__user_rule_map`
--

CREATE TABLE IF NOT EXISTS `#__user_rule_map` (
  `user_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__users.id',
  `rule_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__access_rules.id',
  PRIMARY KEY  (`user_id`,`rule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `#__user_usergroup_map`
--

CREATE TABLE IF NOT EXISTS `#__user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL default '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY  (`user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




--
-- Table structure for table `#__simple_templates`
--

CREATE TABLE IF NOT EXISTS `#__simple_templates` (
  `id` int(11) NOT NULL auto_increment,
  `context` varchar(100) NOT NULL COMMENT 'The context that the template is used in',
  `name` varchar(255) NOT NULL COMMENT 'The system name for programmatic lookup',
  `title` varchar(255) NOT NULL COMMENT 'A human readable title',
  `body_text` mediumtext NOT NULL COMMENT 'The body of the message - text version',
  `body_html` mediumtext NOT NULL COMMENT 'The body of the message - html version',
  `comments` mediumtext NOT NULL COMMENT 'General comments about this template',
  `published` tinyint(1) NOT NULL default '0',
  `ordering` int(11) NOT NULL default '0',
  `params` mediumtext NOT NULL COMMENT 'The parameters for the template',
  `checked_out` int(11) unsigned NOT NULL default '0',
  `checked_out_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user_id` int(11) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `modified_user_id` int(11) unsigned NOT NULL default '0',
  `modified_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_context_published` (`context`,`published`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores text templates for use by the system';


--
-- Table structure for table `#__user_profiles`
--

CREATE TABLE IF NOT EXISTS `#__user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` varchar(255) NOT NULL,
  `ordering` int(11) NOT NULL default '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

CREATE TABLE IF NOT EXISTS `#__menu_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(255) NOT NULL,
  `client_id` int(11) NOT NULL,
  `home` tinyint(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  `params` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;
