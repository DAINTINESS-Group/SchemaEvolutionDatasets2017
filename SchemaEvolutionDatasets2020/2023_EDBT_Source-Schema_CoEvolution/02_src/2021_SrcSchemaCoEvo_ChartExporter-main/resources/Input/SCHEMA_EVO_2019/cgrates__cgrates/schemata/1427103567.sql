--
-- Table structure for table `tp_timings`
--
DROP TABLE IF EXISTS `tp_timings`;
CREATE TABLE `tp_timings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `years` varchar(255) NOT NULL,
  `months` varchar(255) NOT NULL,
  `month_days` varchar(255) NOT NULL,
  `week_days` varchar(255) NOT NULL,
  `time` varchar(32) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  KEY `tpid_tmid` (`tpid`,`tag`),
  UNIQUE KEY `tpid_tag` (`tpid`,`tag`)
);

--
-- Table structure for table `tp_destinations`
--

DROP TABLE IF EXISTS `tp_destinations`;
CREATE TABLE `tp_destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `prefix` varchar(24) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  KEY `tpid_dstid` (`tpid`,`tag`),
  UNIQUE KEY `tpid_dest_prefix` (`tpid`,`tag`,`prefix`)
);

--
-- Table structure for table `tp_rates`
--

DROP TABLE IF EXISTS `tp_rates`;
CREATE TABLE `tp_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `connect_fee` decimal(7,4) NOT NULL,
  `max_cost` decimal(7,4) NOT NULL,
  `max_cost_strategy` varchar(16) NOT NULL,
  `rate` decimal(7,4) NOT NULL,
  `rate_unit` varchar(16) NOT NULL,
  `rate_increment` varchar(16) NOT NULL,
  `group_interval_start` varchar(16) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tprate` (`tpid`,`tag`,`group_interval_start`),
  KEY `tpid` (`tpid`),
  KEY `tpid_rtid` (`tpid`,`tag`)
);

--
-- Table structure for table `destination_rates`
--

DROP TABLE IF EXISTS `tp_destination_rates`;
CREATE TABLE `tp_destination_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `destinations_tag` varchar(64) NOT NULL,
  `rates_tag` varchar(64) NOT NULL,
  `rounding_method` varchar(255) NOT NULL,
  `rounding_decimals` tinyint(4) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  KEY `tpid_drid` (`tpid`,`tag`),
  UNIQUE KEY `tpid_drid_dstid` (`tpid`,`tag`,`destinations_tag`)
);

--
-- Table structure for table `tp_rating_plans`
--

DROP TABLE IF EXISTS `tp_rating_plans`;
CREATE TABLE `tp_rating_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `destrates_tag` varchar(64) NOT NULL,
  `timing_tag` varchar(64) NOT NULL,
  `weight` DECIMAL(8,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  KEY `tpid_rpl` (`tpid`,`tag`),
  UNIQUE KEY `tpid_rplid_destrates_timings_weight` (`tpid`,`tag`,`destrates_tag`,`timing_tag`)
);

--
-- Table structure for table `tp_rate_profiles`
--

DROP TABLE IF EXISTS `tp_rating_profiles`;
CREATE TABLE `tp_rating_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `loadid` varchar(64) NOT NULL,
  `direction` varchar(8) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `activation_time` varchar(24) NOT NULL,
  `rating_plan_tag` varchar(64) NOT NULL,
  `fallback_subjects` varchar(64),
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid_loadid` (`tpid`, `loadid`),
  UNIQUE KEY `tpid_loadid_tenant_category_dir_subj_atime` (`tpid`,`loadid`, `tenant`,`category`,`direction`,`subject`,`activation_time`)
);

--
-- Table structure for table `tp_shared_groups`
--

DROP TABLE IF EXISTS `tp_shared_groups`;
CREATE TABLE `tp_shared_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `account` varchar(24) NOT NULL,
  `strategy` varchar(24) NOT NULL,
  `rating_subject` varchar(24) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  UNIQUE KEY `unique_shared_group` (`tpid`,`tag`,`account`,`strategy`,`rating_subject`)
);

--
-- Table structure for table `tp_actions`
--

DROP TABLE IF EXISTS `tp_actions`;
CREATE TABLE `tp_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `action` varchar(24) NOT NULL,
  `balance_tag` varchar(64) NOT NULL,
  `balance_type` varchar(24) NOT NULL,
  `direction` varchar(8) NOT NULL,
  `units` DECIMAL(20,4) NOT NULL,
  `expiry_time` varchar(24) NOT NULL,
  `timing_tags` varchar(128) NOT NULL,
  `destination_tag` varchar(64) NOT NULL,
  `rating_subject` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `shared_group` varchar(64) NOT NULL,
  `balance_weight` DECIMAL(8,2) NOT NULL,
  `extra_parameters` varchar(256) NOT NULL,
  `weight` DECIMAL(8,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  UNIQUE KEY `unique_action` (`tpid`,`tag`,`action`,`balance_tag`,`balance_type`,`direction`,`expiry_time`,`timing_tags`,`destination_tag`,`shared_group`,`balance_weight`,`weight`)
);

--
-- Table structure for table `tp_action_timings`
--

DROP TABLE IF EXISTS `tp_action_plans`;
CREATE TABLE `tp_action_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `actions_tag` varchar(64) NOT NULL,
  `timing_tag` varchar(64) NOT NULL,
  `weight` DECIMAL(8,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  UNIQUE KEY `unique_action_schedule` (`tpid`,`tag`,`actions_tag`)
);

--
-- Table structure for table `tp_action_triggers`
--

DROP TABLE IF EXISTS `tp_action_triggers`;
CREATE TABLE `tp_action_triggers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `unique_id` varchar(64) NOT NULL,
  `balance_tag` varchar(64) NOT NULL,
  `balance_type` varchar(24) NOT NULL,
  `balance_direction` varchar(8) NOT NULL,
  `threshold_type` char(12) NOT NULL,
  `threshold_value` DECIMAL(20,4) NOT NULL,
  `recurrent` BOOLEAN NOT NULL,
  `min_sleep` varchar(16) NOT NULL,
  `balance_destination_tag` varchar(64) NOT NULL,
  `balance_weight` DECIMAL(8,2) NOT NULL, 
  `balance_expiry_time` varchar(24) NOT NULL,
  `balance_timing_tags` varchar(128) NOT NULL, 
  `balance_rating_subject` varchar(64) NOT NULL,
  `balance_category` varchar(32) NOT NULL,
  `balance_shared_group` varchar(64) NOT NULL,
  `min_queued_items` int(11) NOT NULL,
  `actions_tag` varchar(64) NOT NULL,
  `weight` DECIMAL(8,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  UNIQUE KEY `unique_trigger_definition` (`tpid`,`tag`,`balance_tag`,`balance_type`,`balance_direction`,`threshold_type`,`threshold_value`,`balance_destination_tag`,`actions_tag`)
);

--
-- Table structure for table `tp_account_actions`
--

DROP TABLE IF EXISTS `tp_account_actions`;
CREATE TABLE `tp_account_actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `loadid` varchar(64) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `account` varchar(64) NOT NULL,
  `direction` varchar(8) NOT NULL,
  `action_plan_tag` varchar(64),
  `action_triggers_tag` varchar(64),
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`),
  UNIQUE KEY `unique_tp_account` (`tpid`,`loadid`,`tenant`,`account`,`direction`)
);

--
-- Table structure for table `tp_lcr_rules`
--

DROP TABLE IF EXISTS tp_lcr_rules;
CREATE TABLE tp_lcr_rules (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `direction`	varchar(8) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `customer` varchar(64) NOT NULL,
  `destination_tag` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `strategy` varchar(16) NOT NULL,
  `suppliers`	varchar(64) NOT NULL,
  `activation_time` varchar(24) NOT NULL,
  `weight` DECIMAL(8,2) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`)
);

--
-- Table structure for table `tp_derived_chargers`
--

DROP TABLE IF EXISTS tp_derived_chargers;
CREATE TABLE tp_derived_chargers (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `loadid` varchar(64) NOT NULL,
  `direction` varchar(8) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `account` varchar(24) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `runid`  varchar(24) NOT NULL,
  `run_filters`  varchar(256) NOT NULL,
  `req_type_field`  varchar(24) NOT NULL,
  `direction_field`  varchar(24) NOT NULL,
  `tenant_field`  varchar(24) NOT NULL,
  `category_field`  varchar(24) NOT NULL,
  `account_field`  varchar(24) NOT NULL,
  `subject_field`  varchar(24) NOT NULL,
  `destination_field`  varchar(24) NOT NULL,
  `setup_time_field`  varchar(24) NOT NULL,
  `answer_time_field`  varchar(24) NOT NULL,
  `usage_field`  varchar(24) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`)
);


--
-- Table structure for table `tp_cdr_stats`
--

DROP TABLE IF EXISTS tp_cdr_stats;
CREATE TABLE tp_cdr_stats (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tpid` varchar(64) NOT NULL,
  `tag` varchar(64) NOT NULL,
  `queue_length` int(11) NOT NULL,
  `time_window` varchar(8) NOT NULL,
  `metrics` varchar(64) NOT NULL,
  `setup_interval` varchar(64) NOT NULL,
  `tor` varchar(64) NOT NULL,
  `cdr_host` varchar(64) NOT NULL,
  `cdr_source` varchar(64) NOT NULL,
  `req_type` varchar(64) NOT NULL,
  `direction` varchar(8) NOT NULL,
  `tenant` varchar(64) NOT NULL,
  `category` varchar(32) NOT NULL,
  `account` varchar(24) NOT NULL,
  `subject` varchar(64) NOT NULL,
  `destination_prefix` varchar(64) NOT NULL,
  `usage_interval` varchar(64) NOT NULL,
  `mediation_runids` varchar(64) NOT NULL,
  `rated_account` varchar(64) NOT NULL,
  `rated_subject` varchar(64) NOT NULL,
  `cost_interval` varchar(24) NOT NULL,
  `action_triggers` varchar(64) NOT NULL,
  `created_at` TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tpid` (`tpid`)
);
