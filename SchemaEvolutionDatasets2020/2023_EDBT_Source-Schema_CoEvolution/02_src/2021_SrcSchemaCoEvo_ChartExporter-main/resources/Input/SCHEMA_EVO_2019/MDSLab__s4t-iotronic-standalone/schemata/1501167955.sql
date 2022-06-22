CREATE TABLE IF NOT EXISTS `board_codes` (	  `code` VARCHAR(36) NOT NULL,
	  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`code`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `user_groups` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(50) NULL DEFAULT NULL,
	  PRIMARY KEY (`id`))	ENGINE = InnoDB	AUTO_INCREMENT = 2	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `users` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `username` VARCHAR(50) NULL DEFAULT NULL,
	  `password` VARCHAR(25) NULL DEFAULT NULL,
	  `group_id` INT(8) NOT NULL,
	  `email` VARCHAR(100) NOT NULL,
	  `active` TINYINT(1) NULL DEFAULT '0',
	  PRIMARY KEY (`id`),
	  INDEX `group_id` (`group_id` ASC),
	  CONSTRAINT `users_ibfk_1`	    FOREIGN KEY (`group_id`)	    REFERENCES `user_groups` (`id`)	    ON DELETE RESTRICT	    ON UPDATE RESTRICT)	ENGINE = InnoDB	AUTO_INCREMENT = 2	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `board_imports` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `idate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `user_id` INT(8) NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `user_id` (`user_id` ASC),
	  CONSTRAINT `board_imports_ibfk_1`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `board_types` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `sku` VARCHAR(15) NOT NULL,
	  `image` VARCHAR(250) NULL DEFAULT NULL,
	  `electric_schema` VARCHAR(250) NULL DEFAULT NULL,
	  PRIMARY KEY (`id`))	ENGINE = InnoDB	AUTO_INCREMENT = 2	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `boards` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `type_id` INT(8) NOT NULL,
	  `name` VARCHAR(200) NULL DEFAULT NULL,
	  `description` TEXT NULL DEFAULT NULL,
	  `language` VARCHAR(5) NULL DEFAULT NULL,
	  `store_url` VARCHAR(200) NULL DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `type_id` (`type_id` ASC),
	  CONSTRAINT `boards_ibfk_1`	    FOREIGN KEY (`type_id`)	    REFERENCES `board_types` (`id`)	    ON DELETE RESTRICT	    ON UPDATE RESTRICT)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `boards_connected` (	  `board_code` VARCHAR(36) NOT NULL,
	  `label` VARCHAR(100) NOT NULL,
	  `session_id` VARCHAR(250) NULL DEFAULT NULL,
	  `status` VARCHAR(15) NULL DEFAULT NULL,
	  `altitude` VARCHAR(45) NULL DEFAULT NULL,
	  `longitude` VARCHAR(45) NULL DEFAULT NULL,
	  `latitude` VARCHAR(45) NULL DEFAULT NULL,
	  PRIMARY KEY (`board_code`),
	  INDEX `fk_boards_connected_board_codes1_idx` (`board_code` ASC),
	  UNIQUE INDEX `board_codes_code_UNIQUE` (`board_code` ASC),
	  CONSTRAINT `fk_boards_connected_board_codes1`	    FOREIGN KEY (`board_code`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

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
	  INDEX `fk_plugins_injected_board_codes1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_plugins_injected_plugins1`	    FOREIGN KEY (`plugin_id`)	    REFERENCES `plugins` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_plugins_injected_board_codes1`	    FOREIGN KEY (`board_id`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `reverse_cloud_services` (	  `board_id` VARCHAR(36) NOT NULL,
	  `service` VARCHAR(50) NOT NULL,
	  `public_ip` VARCHAR(16) NOT NULL,
	  `public_port` VARCHAR(5) NOT NULL,
	  PRIMARY KEY (`board_id`,
 `service`))	ENGINE = MEMORY	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `user_boards` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `user_id` INT(8) NOT NULL,
	  `board_type` INT(8) NOT NULL,
	  `board_code` VARCHAR(36) NOT NULL,
	  `cloud_enabled` TINYINT(1) NULL DEFAULT 0,
	  `net_enabled` TINYINT(1) NULL DEFAULT 0,
	  PRIMARY KEY (`id`),
	  INDEX `user_id` (`user_id` ASC),
	  INDEX `board_type` (`board_type` ASC),
	  INDEX `board_code` (`board_code` ASC),
	  CONSTRAINT `user_boards_ibfk_1`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`),
	  CONSTRAINT `user_boards_ibfk_2`	    FOREIGN KEY (`board_type`)	    REFERENCES `board_types` (`id`)	    ON DELETE RESTRICT	    ON UPDATE RESTRICT,
	  CONSTRAINT `user_boards_ibfk_3`	    FOREIGN KEY (`board_code`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	AUTO_INCREMENT = 18	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `user_profiles` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `user_id` INT(8) NOT NULL,
	  `name` VARCHAR(50) NULL DEFAULT NULL,
	  `surname` VARCHAR(50) NULL DEFAULT NULL,
	  `avatar` VARCHAR(200) NULL DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `user_id` (`user_id` ASC),
	  CONSTRAINT `user_profiles_ibfk_1`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`)	    ON DELETE RESTRICT	    ON UPDATE RESTRICT)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `userprojects` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `user_id` INT(8) NOT NULL,
	  `title` VARCHAR(100) NOT NULL,
	  `description` TEXT NULL DEFAULT NULL,
	  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `status` VARCHAR(15) NULL DEFAULT 'private',
	  PRIMARY KEY (`id`),
	  INDEX `user_id` (`user_id` ASC),
	  CONSTRAINT `userprojects_ibfk_1`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `userproject_comments` (	  `id` INT(8) NOT NULL AUTO_INCREMENT,
	  `project_id` INT(8) NOT NULL,
	  `user_id` INT(8) NOT NULL,
	  `content` TEXT NOT NULL,
	  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `status` VARCHAR(15) NULL DEFAULT 'public',
	  PRIMARY KEY (`id`),
	  INDEX `project_id` (`project_id` ASC),
	  INDEX `user_id` (`user_id` ASC),
	  CONSTRAINT `userproject_comments_ibfk_1`	    FOREIGN KEY (`project_id`)	    REFERENCES `userprojects` (`id`),
	  CONSTRAINT `userproject_comments_ibfk_2`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `userproject_likes` (	  `project_id` INT(8) NOT NULL,
	  `user_id` INT(8) NOT NULL,
	  INDEX `project_id` (`project_id` ASC),
	  INDEX `user_id` (`user_id` ASC),
	  CONSTRAINT `userproject_likes_ibfk_1`	    FOREIGN KEY (`project_id`)	    REFERENCES `userprojects` (`id`),
	  CONSTRAINT `userproject_likes_ibfk_2`	    FOREIGN KEY (`user_id`)	    REFERENCES `users` (`id`))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

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
	  INDEX `fk_socat_connections_board_codes1_idx` (`id_board` ASC),
	  UNIQUE INDEX `id_board_UNIQUE` (`id_board` ASC),
	  CONSTRAINT `fk_socat_connections_board_codes1`	    FOREIGN KEY (`id_board`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

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
	  INDEX `fk_sensors_on_board_board_codes1_idx` (`id_board` ASC),
	  PRIMARY KEY (`id_sensor`,
 `id_board`),
	  CONSTRAINT `fk_sensors_on_board_sensors1`	    FOREIGN KEY (`id_sensor`)	    REFERENCES `sensors` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_sensors_on_board_board_codes1`	    FOREIGN KEY (`id_board`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `plugin_sensors` (	  `plugins_id` INT(11) NOT NULL,
	  `sensors_id` INT NOT NULL,
	  INDEX `fk_plugin_sensors_plugins1_idx` (`plugins_id` ASC),
	  INDEX `fk_plugin_sensors_sensors1_idx` (`sensors_id` ASC),
	  PRIMARY KEY (`plugins_id`,
 `sensors_id`),
	  CONSTRAINT `fk_plugin_sensors_plugins1`	    FOREIGN KEY (`plugins_id`)	    REFERENCES `plugins` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_plugin_sensors_sensors1`	    FOREIGN KEY (`sensors_id`)	    REFERENCES `sensors` (`id`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `free_addresses` (	  `vlans_id` INT NOT NULL,
	  `ip` VARCHAR(45) NOT NULL,
	  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  INDEX `fk_free_addresses_vlans1_idx` (`vlans_id` ASC),
	  PRIMARY KEY (`vlans_id`,
 `ip`),
	  CONSTRAINT `fk_free_addresses_vlans1`	    FOREIGN KEY (`vlans_id`)	    REFERENCES `vlans` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `drivers` (	  `id` INT NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(20) NOT NULL,
	  `jsonschema` LONGTEXT NOT NULL,
	  `code` LONGTEXT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `drivers_injected` (	  `board_id` VARCHAR(36) NOT NULL,
	  `driver_id` INT NOT NULL,
	  `state` VARCHAR(20) NOT NULL,
	  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`board_id`,
 `driver_id`),
	  INDEX `fk_drivers_injected_board_codes1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_drivers_injected_drivers1`	    FOREIGN KEY (`driver_id`)	    REFERENCES `drivers` (`id`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_drivers_injected_board_codes1`	    FOREIGN KEY (`board_id`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mountpoints` (	  `src_board` VARCHAR(36) NOT NULL,
	  `dst_board` VARCHAR(36) NOT NULL,
	  `src_path` VARCHAR(45) NOT NULL,
	  `dst_path` VARCHAR(45) NOT NULL,
	  `status` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`src_board`,
 `dst_board`,
 `src_path`,
 `dst_path`),
	  INDEX `fk_mountpoints_board_codes1_idx` (`src_board` ASC),
	  INDEX `fk_mountpoints_board_codes2_idx` (`dst_board` ASC),
	  CONSTRAINT `fk_mountpoints_board_codes1`	    FOREIGN KEY (`src_board`)	    REFERENCES `board_codes` (`code`)	    ON DELETE CASCADE	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_mountpoints_board_codes2`	    FOREIGN KEY (`dst_board`)	    REFERENCES `board_codes` (`code`)	    ON DELETE NO ACTION	    ON UPDATE NO ACTION)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `services` (	  `id` INT(11) NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(45) NOT NULL,
	  `port` INT NOT NULL,
	  `protocol` VARCHAR(10) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name_UNIQUE` (`name` ASC))	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `active_services` (	  `service_id` INT NOT NULL,
	  `board_id` VARCHAR(36) NOT NULL,
	  `public_port` INT NOT NULL,
	  `last_update` TIMESTAMP NOT NULL,
	  PRIMARY KEY (`service_id`,
 `board_id`,
 `public_port`),
	  INDEX `fk_active_services_services1_idx` (`service_id` ASC),
	  INDEX `fk_active_services_board_codes1_idx` (`board_id` ASC),
	  CONSTRAINT `fk_active_services_services1`	    FOREIGN KEY (`service_id`)	    REFERENCES `services` (`id`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE,
	  CONSTRAINT `fk_active_services_board_codes1`	    FOREIGN KEY (`board_id`)	    REFERENCES `board_codes` (`code`)	    ON DELETE NO ACTION	    ON UPDATE CASCADE)	ENGINE = InnoDB	DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `view1` (`id` INT);

