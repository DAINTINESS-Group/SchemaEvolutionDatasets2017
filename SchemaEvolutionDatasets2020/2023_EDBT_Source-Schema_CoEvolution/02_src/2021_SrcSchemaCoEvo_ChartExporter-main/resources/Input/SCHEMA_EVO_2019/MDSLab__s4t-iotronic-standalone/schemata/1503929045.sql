CREATE TABLE IF NOT EXISTS `board_codes` (	  `code` VARCHAR(36) NOT NULL,
	  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`code`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `layouts` (	  `id_layout` INT NOT NULL AUTO_INCREMENT,
	  `model` VARCHAR(45) NULL,
	  `manufacturer` VARCHAR(45) NULL,
	  `image` VARCHAR(45) NULL,
	  PRIMARY KEY (`id_layout`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `projects` (	  `uuid` VARCHAR(36) NOT NULL,
	  `name` VARCHAR(50) NOT NULL,
	  `description` VARCHAR(300) NULL DEFAULT NULL,
	  PRIMARY KEY (`uuid`))	ENGINE = InnoDB	AUTO_INCREMENT = 2	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `users` (	  `uuid` VARCHAR(36) NOT NULL,
	  `username` VARCHAR(50) NOT NULL,
	  `password` VARCHAR(60) NULL DEFAULT NULL,
	  `email` VARCHAR(50) NOT NULL,
	  `first_name` VARCHAR(45) NULL DEFAULT NULL,
	  `last_name` VARCHAR(45) NULL DEFAULT NULL,
	  `latest_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`uuid`))	ENGINE = InnoDB	AUTO_INCREMENT = 2	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `boards` (	  `board_code` VARCHAR(36) NOT NULL,
	  `label` VARCHAR(100) NOT NULL,
	  `session_id` VARCHAR(250) NULL DEFAULT NULL,
	  `status` VARCHAR(15) NULL DEFAULT NULL,
	  `latest_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	  `type` INT NULL,
	  `description` VARCHAR(300) NULL DEFAULT NULL,
	  `net_enabled` TINYINT(1) NOT NULL,
	  `projects_id` VARCHAR(36) NULL,
	  `users_id` VARCHAR(36) NULL,
	  `mobile` TINYINT(1) NOT NULL,
	  `position_refresh_time` INT NULL,
	  PRIMARY KEY (`board_code`),
	  INDEX `fk_boards_layout1_idx` (`type` ASC),
	  INDEX `fk_boards_projects1_idx` (`projects_id` ASC),
	  INDEX `fk_boards_users1_idx` (`users_id` ASC),
	  CONSTRAINT `fk_boards_layout1`	    FOREIGN KEY (`type`)	    REFERENCES `layouts` (`id_layout`)	    ON DELETE SET NULL	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_boards_projects1`	    FOREIGN KEY (`projects_id`)	    REFERENCES `projects` (`uuid`)	    ON DELETE SET NULL	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_boards_users1`	    FOREIGN KEY (`users_id`)	    REFERENCES `users` (`uuid`)	    ON DELETE SET NULL	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `plugins` (	  `id` INT(11) NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(20) NOT NULL,
	  `category` VARCHAR(20) NOT NULL,
	  `jsonschema` LONGTEXT NOT NULL,
	  `code` LONGTEXT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	AUTO_INCREMENT = 10	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `plugins_injected` (	  `board_id` VARCHAR(36) NOT NULL,
	  `plugin_id` INT(11) NOT NULL,
	  `state` VARCHAR(20) NOT NULL,
	  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  INDEX `fk_plugins_injected_plugins1_idx` (`plugin_id` ASC),
	  PRIMARY KEY (`board_id`,
 `plugin_id`),
	  INDEX `fk_plugins_injected_boards1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_plugins_injected_plugins1`	    FOREIGN KEY (`plugin_id`)	    REFERENCES `plugins` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_plugins_injected_boards1`	    FOREIGN KEY (`board_id`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `reverse_cloud_services` (	  `board_id` VARCHAR(36) NOT NULL,
	  `service` VARCHAR(50) NOT NULL,
	  `public_ip` VARCHAR(16) NOT NULL,
	  `public_port` VARCHAR(5) NOT NULL,
	  PRIMARY KEY (`board_id`,
 `service`))	ENGINE = MEMORY	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `vlans` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `vlan_name` VARCHAR(45) NOT NULL,
	  `vlan_ip` VARCHAR(45) NOT NULL,
	  `vlan_mask` VARCHAR(45) NOT NULL,
	  `net_uuid` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `socat_connections` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `id_board` VARCHAR(36) NOT NULL,
	  `port` INT(6) NULL,
	  `ip_board` VARCHAR(45) NULL,
	  `ip_server` VARCHAR(45) NULL,
	  `status` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`id`,
 `id_board`),
	  INDEX `fk_socat_connections_boards1_idx` (`id_board` ASC),
	  CONSTRAINT `fk_socat_connections_boards1`	    FOREIGN KEY (`id_board`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `vlans_connection` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `id_vlan` INT NOT NULL,
	  `id_socat_connection` INT NOT NULL,
	  `ip_vlan` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `fk_vlans_connection_vlans1_idx` (`id_vlan` ASC),
	  INDEX `fk_vlans_connection_socat_connections1_idx` (`id_socat_connection` ASC),
	  CONSTRAINT `fk_vlans_connection_vlans1`	    FOREIGN KEY (`id_vlan`)	    REFERENCES `vlans` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_vlans_connection_socat_connections1`	    FOREIGN KEY (`id_socat_connection`)	    REFERENCES `socat_connections` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `sensors` (	  `id` INT NOT NULL,
	  `type` VARCHAR(45) NOT NULL,
	  `unit` VARCHAR(45) NOT NULL,
	  `fabric_name` VARCHAR(45) NULL,
	  `model` VARCHAR(45) NULL,
	  PRIMARY KEY (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `sensors_on_board` (	  `id_sensor` INT NOT NULL,
	  `id_board` VARCHAR(36) NOT NULL,
	  PRIMARY KEY (`id_sensor`,
 `id_board`),
	  INDEX `fk_sensors_on_board_boards_connected1_idx` (`id_board` ASC),
	  CONSTRAINT `fk_sensors_on_board_sensors1`	    FOREIGN KEY (`id_sensor`)	    REFERENCES `sensors` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_sensors_on_board_boards1`	    FOREIGN KEY (`id_board`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `plugin_sensors` (	  `plugins_id` INT(11) NOT NULL,
	  `sensors_id` INT NOT NULL,
	  INDEX `fk_plugin_sensors_plugins1_idx` (`plugins_id` ASC),
	  INDEX `fk_plugin_sensors_sensors1_idx` (`sensors_id` ASC),
	  PRIMARY KEY (`plugins_id`,
 `sensors_id`),
	  CONSTRAINT `fk_plugin_sensors_plugins1`	    FOREIGN KEY (`plugins_id`)	    REFERENCES `plugins` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_plugin_sensors_sensors1`	    FOREIGN KEY (`sensors_id`)	    REFERENCES `sensors` (`id`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `free_addresses` (	  `ip` VARCHAR(45) NOT NULL,
	  `vlans_id` INT NOT NULL,
	  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  INDEX `fk_free_addresses_vlans1_idx` (`vlans_id` ASC),
	  PRIMARY KEY (`ip`,
 `vlans_id`),
	  CONSTRAINT `fk_free_addresses_vlans1`	    FOREIGN KEY (`vlans_id`)	    REFERENCES `vlans` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `drivers` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(20) NOT NULL,
	  `jsonschema` LONGTEXT NOT NULL,
	  `code` LONGTEXT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `drivers_injected` (	  `driver_id` INT NOT NULL,
	  `board_id` VARCHAR(36) NOT NULL,
	  `state` VARCHAR(20) NOT NULL,
	  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`driver_id`,
 `board_id`),
	  INDEX `fk_drivers_injected_boards1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_drivers_injected_drivers1`	    FOREIGN KEY (`driver_id`)	    REFERENCES `drivers` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_drivers_injected_boards_connected1`	    FOREIGN KEY (`board_id`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mountpoints` (	  `src_board` VARCHAR(36) NOT NULL,
	  `dst_board` VARCHAR(36) NOT NULL,
	  `src_path` VARCHAR(45) NOT NULL,
	  `dst_path` VARCHAR(45) NOT NULL,
	  `status` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`src_board`,
 `dst_board`,
 `src_path`,
 `dst_path`),
	  INDEX `fk_mountpoints_boards_connected1_idx` (`src_board` ASC),
	  INDEX `fk_mountpoints_boards_connected2_idx` (`dst_board` ASC),
	  CONSTRAINT `fk_mountpoints_boards1`	    FOREIGN KEY (`src_board`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_mountpoints_boards2`	    FOREIGN KEY (`dst_board`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `services` (	  `id` INT(11) NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(45) NOT NULL,
	  `port` INT NOT NULL,
	  `protocol` VARCHAR(10) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `active_services` (	  `service_id` INT NOT NULL,
	  `board_id` VARCHAR(36) NOT NULL,
	  `public_port` INT NOT NULL,
	  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`service_id`,
 `board_id`,
 `public_port`),
	  INDEX `fk_active_services_services1_idx` (`service_id` ASC),
	  INDEX `fk_active_services_boards1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_active_services_services1`	    FOREIGN KEY (`service_id`)	    REFERENCES `services` (`id`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_active_services_boards1`	    FOREIGN KEY (`board_id`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `coordinates` (	  `coordinates_id` INT NOT NULL AUTO_INCREMENT,
	  `board_id` VARCHAR(36) NOT NULL,
	  `altitude` VARCHAR(45) NOT NULL,
	  `longitude` VARCHAR(45) NOT NULL,
	  `latitude` VARCHAR(45) NOT NULL,
	  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`coordinates_id`),
	  CONSTRAINT `fk_coordinates_boards1`	    FOREIGN KEY (`board_id`)	    REFERENCES `boards` (`board_code`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `modules` (	  `id` INT(11) NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(45) NOT NULL,
	  `description` VARCHAR(300) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `active_modules` (	  `module_id` INT NOT NULL,
	  `board_id` VARCHAR(36) NOT NULL,
	  `latest_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`module_id`,
 `board_id`),
	  INDEX `fk_active_services_services1_idx` (`module_id` ASC),
	  INDEX `fk_active_services_boards1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_active_services_services10`	    FOREIGN KEY (`module_id`)	    REFERENCES `modules` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_active_services_boards10`	    FOREIGN KEY (`board_id`)	    REFERENCES `boards` (`board_code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `view1` (`id` INT);

