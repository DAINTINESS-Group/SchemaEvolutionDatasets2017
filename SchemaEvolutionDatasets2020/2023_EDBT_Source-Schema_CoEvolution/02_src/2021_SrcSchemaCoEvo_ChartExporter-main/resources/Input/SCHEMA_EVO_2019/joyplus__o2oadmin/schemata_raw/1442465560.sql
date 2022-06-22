CREATE TABLE `pmp_app_info` (
  `id` int(11) NOT NULL,
  `app_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pkg_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pcat` int(11) DEFAULT NULL,
  `ua` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `pmp_app_info` ADD PRIMARY KEY (`id`);
ALTER TABLE `pmp_app_info` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;


/*20150820*/
ALTER TABLE `pmp_demand_adspace` ADD `app_id` int(11) NOT NULL AFTER `demand_id`;
ALTER TABLE `pmp_demand_adspace` ADD `adspace_type` int(1) NOT NULL AFTER `app_id`;
ALTER TABLE `pmp_request_log` ADD `did` VARCHAR(50) NOT NULL AFTER `bid`;
ALTER TABLE `pmp_tracking_log` ADD `did` VARCHAR(50) NOT NULL AFTER `bid`;
ALTER TABLE `pmp_demand_response_log` ADD `did` VARCHAR(50) NOT NULL AFTER `bid`;

/*20150821*/
ALTER TABLE `pmp_adspace` ADD `tpl_name` VARCHAR(20) NOT NULL AFTER `creative_type`;

/*20150825*/
CREATE TABLE `pmp_campaign_creative` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campaign_id` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `creative_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creative_status` int(11) DEFAULT NULL COMMENT '0：暂停1： 运行',
  `landing_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imp_tracking_url` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `clk_tracking_url` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `display_title` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_text` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL，
  PRIMARY KEY (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 COLLATE=utf8_unicode_ci;

ALTER TABLE `pmp_adspace` ADD `forever_flg` INT(2) NOT NULL AFTER `media_id`;

/*20150828*/
ALTER TABLE `pmp_campaign`
  DROP `width`,
  DROP `height`,
  DROP `creative_url`;

/*20150831*/
ALTER TABLE `pmp_adspace` CHANGE `del_flg` `del_flg` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE `pmp_demand_platform_desk` CHANGE `del_flg` `del_flg` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE `pmp_demand_adspace` CHANGE `del_flg` `del_flg` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE `pmp_media` CHANGE `del_flg` `del_flg` TINYINT(1) NULL DEFAULT '0';
UPDATE `pmp_demand_adspace` SET `del_flg` = 0;
UPDATE `pmp_adspace` SET `del_flg` = 0;
UPDATE `pmp_demand_adspace` SET `del_flg` = 0;
UPDATE `pmp_media` SET `del_flg` = 0;

ALTER TABLE `pmp_demand_adspace` ADD `real_adspace_key` VARCHAR(50) NOT NULL AFTER `update_time`;
ALTER table pmp_demand_adspace add UNIQUE UNIQUE_DEMAND_ADSPACE_KEY(demand_adspace_key);


/*20150913*/
-- -----------------------------------------------------
-- Table `pmp`.`pmp_campaign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_campaign` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `campaign_status` INT(11) NOT NULL COMMENT '0：暂停1： 运行',
  `landing_url` VARCHAR(500) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `demand_adspace_id` INT(11) NOT NULL,
  `imp_tracking_url` VARCHAR(1000) NULL,
  `clk_tracking_url` VARCHAR(1000) NULL,
  `landing_url` VARCHAR(1000) NULL,
  `ad_type` INT NULL,
  `campaign_type` INT NULL COMMENT '0: 开屏，1: banner, 2: 信息流',
  `accurate_type` INT NULL COMMENT '0:精准,1:适中,2:广泛',
  `pricing_type` INT NULL COMMENT '0:cpc,1:cpm,2:RD',
  `strategy_type` INT NULL,
  `budget_type` INT NULL,
  `budget` INT NULL,
  `bid_price` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

/*roll back some records*/
INSERT INTO `pmp_campaign` (`id`, `name`, `start_date`, `end_date`, `campaign_status`, `landing_url`, `demand_adspace_id`) VALUES
(1, '开屏', '2015-06-30', '2015-09-30', 1, 'http://www.baidu.com', 9),
(2, 'banner_normal', '2015-06-30', '2015-09-30', 1, 'http://www.baidu.com', 10),
(3, 'banner_webview', '2015-06-30', '2015-09-30', 1, 'http://www.baidu.com', 11);


-- -----------------------------------------------------
-- Table `pmp`.`pmp_campaign_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_campaign_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `advertiser_Id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `budget` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pmp`.`pmp_advertiser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_advertiser` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(500) NULL,
  `advertiser_type` INT NOT NULL DEFAULT 0 COMMENT '0: 广告主；1：代理商',
  `del_flg` INT NOT NULL DEFAULT 0,
  `category_key` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pmp`.`pmp_lov`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_lov` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lov_code` VARCHAR(45) NOT NULL,
  `lov_key` INT NOT NULL,
  `lov_value` VARCHAR(45) NOT NULL,
  `disp_order` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pmp`.`pmp_campaign_daily_config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_campaign_daily_config` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campaign_id` INT NOT NULL,
  `week_day` INT NOT NULL,
  `target_hours` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pmp`.`pmp_campaign_targeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pmp`.`pmp_campaign_targeting` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `campaign_id` INT NOT NULL,
  `targeting_type` VARCHAR(45) NULL,
  `targeting_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


ALTER TABLE `pmp_adspace` ADD `cpm` FLOAT NOT NULL AFTER `forever_flg`, ADD `cpc` FLOAT NOT NULL AFTER `cpm`, ADD `pricing_type` INT NOT NULL AFTER `cpc`;
ALTER TABLE `pmp_demand_adspace` ADD `cpm` FLOAT NOT NULL AFTER `adspace_type`, ADD `cpc` FLOAT NOT NULL AFTER `cpm`, ADD `pricing_type` INT NOT NULL AFTER `cpc`;
ALTER TABLE `pmp_daily_report` ADD `cost` FLOAT NOT NULL AFTER `updateTime`, ADD `spending` FLOAT NOT NULL AFTER `cost`;
ALTER TABLE `pmp_campaign_daily_report` ADD `cost` FLOAT NOT NULL AFTER `spending`;


/*20150915*/
ALTER TABLE `pmp_campaign` ADD `imp` INT NOT NULL AFTER `bid_price`, ADD `clk` INT NOT NULL AFTER `imp`;
