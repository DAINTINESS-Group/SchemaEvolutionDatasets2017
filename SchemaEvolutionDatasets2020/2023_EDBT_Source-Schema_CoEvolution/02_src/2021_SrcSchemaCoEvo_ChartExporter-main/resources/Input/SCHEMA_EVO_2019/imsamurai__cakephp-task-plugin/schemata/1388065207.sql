-- delimiter $$ $$

CREATE TABLE `tasks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `process_id` int(10) DEFAULT 0,
  `server_id` int(10) DEFAULT 0,
  `command` varchar(500) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `arguments` longtext,
  `hash` varchar(100) DEFAULT NULL,
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '0 - new\n1 - deffered\n2 - runned\n3 - finished\n4 - stopping\n5 - stopped',
  `code` int(10) DEFAULT '0' COMMENT '0 - ok\nother - error code',
  `code_string` varchar(500) DEFAULT NULL,
  `stdout` longtext,
  `stderr` longtext,
  `details` longtext,
  `timeout` int(10) unsigned DEFAULT '0',
  `scheduled` datetime DEFAULT NULL,
  `started` datetime DEFAULT NULL,
  `stopped` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 

CREATE TABLE `dependent_tasks` (
  `task_id` bigint(20) unsigned NOT NULL,
  `depends_on_task_id` bigint(20) unsigned NOT NULL
) ENGINE=MyISAM 

