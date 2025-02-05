-- MySQL Script generated by MySQL Workbench
-- lun 18 set 2017 17:27:40 CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema new-s4t-iotronic
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `new-s4t-iotronic` ;

-- -----------------------------------------------------
-- Schema new-s4t-iotronic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new-s4t-iotronic` DEFAULT CHARACTER SET latin1 ;
USE `new-s4t-iotronic` ;

-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`board_codes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`board_codes` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`board_codes` (
  `code` VARCHAR(36) NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`layouts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`layouts` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`layouts` (
  `id_layout` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NULL,
  `manufacturer` VARCHAR(45) NULL,
  `image` VARCHAR(45) NULL,
  PRIMARY KEY (`id_layout`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`projects` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`projects` (
  `uuid` VARCHAR(36) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (`uuid`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`users` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`users` (
  `uuid` VARCHAR(36) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(60) NULL DEFAULT NULL,
  `email` VARCHAR(50) NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `latest_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`boards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`boards` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`boards` (
  `board_code` VARCHAR(36) NOT NULL,
  `label` VARCHAR(100) NOT NULL,
  `session_id` VARCHAR(250) NULL DEFAULT NULL,
  `status` VARCHAR(15) NULL DEFAULT NULL,
  `latest_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` INT NULL,
  `description` VARCHAR(300) NULL DEFAULT NULL,
  `net_enabled` TINYINT(1) NOT NULL,
  `projects_id` VARCHAR(36) NULL,
  `users_id` VARCHAR(36) NULL,
  `mobile` TINYINT(1) NOT NULL,
  `position_refresh_time` INT NULL,
  `notify` TINYINT(1) NOT NULL,
  `notify_rate` VARCHAR(45) NULL,
  `notify_retry` INT NULL,
  `extra` VARCHAR(600) NULL,
  PRIMARY KEY (`board_code`),
  INDEX `fk_boards_layout1_idx` (`type` ASC),
  INDEX `fk_boards_projects1_idx` (`projects_id` ASC),
  INDEX `fk_boards_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_boards_layout1`
    FOREIGN KEY (`type`)
    REFERENCES `new-s4t-iotronic`.`layouts` (`id_layout`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_boards_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `new-s4t-iotronic`.`projects` (`uuid`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_boards_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `new-s4t-iotronic`.`users` (`uuid`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`plugins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`plugins` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`plugins` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `category` VARCHAR(20) NOT NULL,
  `jsonschema` LONGTEXT NOT NULL,
  `code` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`plugins_injected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`plugins_injected` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`plugins_injected` (
  `board_id` VARCHAR(36) NOT NULL,
  `plugin_id` INT(11) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_plugins_injected_plugins1_idx` (`plugin_id` ASC),
  PRIMARY KEY (`board_id`, `plugin_id`),
  INDEX `fk_plugins_injected_boards1_idx` (`board_id` ASC),
  CONSTRAINT `fk_plugins_injected_plugins1`
    FOREIGN KEY (`plugin_id`)
    REFERENCES `new-s4t-iotronic`.`plugins` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plugins_injected_boards1`
    FOREIGN KEY (`board_id`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`reverse_cloud_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`reverse_cloud_services` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`reverse_cloud_services` (
  `board_id` VARCHAR(36) NOT NULL,
  `service` VARCHAR(50) NOT NULL,
  `public_ip` VARCHAR(16) NOT NULL,
  `public_port` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`board_id`, `service`))
ENGINE = MEMORY
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`vlans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`vlans` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`vlans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vlan_name` VARCHAR(45) NOT NULL,
  `vlan_ip` VARCHAR(45) NOT NULL,
  `vlan_mask` VARCHAR(45) NOT NULL,
  `net_uuid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`socat_connections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`socat_connections` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`socat_connections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_board` VARCHAR(36) NOT NULL,
  `port` INT(6) NULL,
  `ip_board` VARCHAR(45) NULL,
  `ip_server` VARCHAR(45) NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `id_board`),
  INDEX `fk_socat_connections_boards1_idx` (`id_board` ASC),
  CONSTRAINT `fk_socat_connections_boards1`
    FOREIGN KEY (`id_board`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`vlans_connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`vlans_connection` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`vlans_connection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_vlan` INT NOT NULL,
  `id_socat_connection` INT NOT NULL,
  `ip_vlan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vlans_connection_vlans1_idx` (`id_vlan` ASC),
  INDEX `fk_vlans_connection_socat_connections1_idx` (`id_socat_connection` ASC),
  CONSTRAINT `fk_vlans_connection_vlans1`
    FOREIGN KEY (`id_vlan`)
    REFERENCES `new-s4t-iotronic`.`vlans` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vlans_connection_socat_connections1`
    FOREIGN KEY (`id_socat_connection`)
    REFERENCES `new-s4t-iotronic`.`socat_connections` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`sensors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`sensors` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`sensors` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `unit` VARCHAR(45) NOT NULL,
  `fabric_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`sensors_on_board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`sensors_on_board` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`sensors_on_board` (
  `id_sensor` INT NOT NULL,
  `id_board` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id_sensor`, `id_board`),
  INDEX `fk_sensors_on_board_boards_connected1_idx` (`id_board` ASC),
  CONSTRAINT `fk_sensors_on_board_sensors1`
    FOREIGN KEY (`id_sensor`)
    REFERENCES `new-s4t-iotronic`.`sensors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sensors_on_board_boards1`
    FOREIGN KEY (`id_board`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`plugin_sensors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`plugin_sensors` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`plugin_sensors` (
  `plugins_id` INT(11) NOT NULL,
  `sensors_id` INT NOT NULL,
  INDEX `fk_plugin_sensors_plugins1_idx` (`plugins_id` ASC),
  INDEX `fk_plugin_sensors_sensors1_idx` (`sensors_id` ASC),
  PRIMARY KEY (`plugins_id`, `sensors_id`),
  CONSTRAINT `fk_plugin_sensors_plugins1`
    FOREIGN KEY (`plugins_id`)
    REFERENCES `new-s4t-iotronic`.`plugins` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plugin_sensors_sensors1`
    FOREIGN KEY (`sensors_id`)
    REFERENCES `new-s4t-iotronic`.`sensors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`free_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`free_addresses` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`free_addresses` (
  `ip` VARCHAR(45) NOT NULL,
  `vlans_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_free_addresses_vlans1_idx` (`vlans_id` ASC),
  PRIMARY KEY (`ip`, `vlans_id`),
  CONSTRAINT `fk_free_addresses_vlans1`
    FOREIGN KEY (`vlans_id`)
    REFERENCES `new-s4t-iotronic`.`vlans` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`drivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`drivers` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`drivers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `jsonschema` LONGTEXT NOT NULL,
  `code` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`drivers_injected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`drivers_injected` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`drivers_injected` (
  `driver_id` INT NOT NULL,
  `board_id` VARCHAR(36) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`driver_id`, `board_id`),
  INDEX `fk_drivers_injected_boards1_idx` (`board_id` ASC),
  CONSTRAINT `fk_drivers_injected_drivers1`
    FOREIGN KEY (`driver_id`)
    REFERENCES `new-s4t-iotronic`.`drivers` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_drivers_injected_boards_connected1`
    FOREIGN KEY (`board_id`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`mountpoints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`mountpoints` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`mountpoints` (
  `src_board` VARCHAR(36) NOT NULL,
  `dst_board` VARCHAR(36) NOT NULL,
  `src_path` VARCHAR(45) NOT NULL,
  `dst_path` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`src_board`, `dst_board`, `src_path`, `dst_path`),
  INDEX `fk_mountpoints_boards_connected1_idx` (`src_board` ASC),
  INDEX `fk_mountpoints_boards_connected2_idx` (`dst_board` ASC),
  CONSTRAINT `fk_mountpoints_boards1`
    FOREIGN KEY (`src_board`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mountpoints_boards2`
    FOREIGN KEY (`dst_board`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`services` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`services` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `port` INT NOT NULL,
  `protocol` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`active_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`active_services` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`active_services` (
  `service_id` INT NOT NULL,
  `board_id` VARCHAR(36) NOT NULL,
  `public_port` INT NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`service_id`, `board_id`, `public_port`),
  INDEX `fk_active_services_services1_idx` (`service_id` ASC),
  INDEX `fk_active_services_boards1_idx` (`board_id` ASC),
  CONSTRAINT `fk_active_services_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `new-s4t-iotronic`.`services` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_active_services_boards1`
    FOREIGN KEY (`board_id`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`coordinates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`coordinates` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`coordinates` (
  `coordinates_id` INT NOT NULL AUTO_INCREMENT,
  `board_id` VARCHAR(36) NOT NULL,
  `altitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  `latitude` VARCHAR(45) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coordinates_id`),
  CONSTRAINT `fk_coordinates_boards1`
    FOREIGN KEY (`board_id`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`modules` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`modules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `new-s4t-iotronic`.`active_modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new-s4t-iotronic`.`active_modules` ;

CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`active_modules` (
  `module_id` INT NOT NULL,
  `board_id` VARCHAR(36) NOT NULL,
  `latest_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`module_id`, `board_id`),
  INDEX `fk_active_services_services1_idx` (`module_id` ASC),
  INDEX `fk_active_services_boards1_idx` (`board_id` ASC),
  CONSTRAINT `fk_active_services_services10`
    FOREIGN KEY (`module_id`)
    REFERENCES `new-s4t-iotronic`.`modules` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_active_services_boards10`
    FOREIGN KEY (`board_id`)
    REFERENCES `new-s4t-iotronic`.`boards` (`board_code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `new-s4t-iotronic` ;

-- -----------------------------------------------------
-- Placeholder table for view `new-s4t-iotronic`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new-s4t-iotronic`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `new-s4t-iotronic`.`view1`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `new-s4t-iotronic`.`view1` ;
DROP TABLE IF EXISTS `new-s4t-iotronic`.`view1`;
USE `new-s4t-iotronic`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `new-s4t-iotronic`.`layouts`
-- -----------------------------------------------------
START TRANSACTION;
USE `new-s4t-iotronic`;
INSERT INTO `new-s4t-iotronic`.`layouts` (`id_layout`, `model`, `manufacturer`, `image`) VALUES (1, 'YUN', 'Arduino', 'linino');
INSERT INTO `new-s4t-iotronic`.`layouts` (`id_layout`, `model`, `manufacturer`, `image`) VALUES (2, 'server', 'standard', '-');
INSERT INTO `new-s4t-iotronic`.`layouts` (`id_layout`, `model`, `manufacturer`, `image`) VALUES (3, 'Raspberry Pi 3', 'Raspberry', '-');

COMMIT;


-- -----------------------------------------------------
-- Data for table `new-s4t-iotronic`.`sensors`
-- -----------------------------------------------------
START TRANSACTION;
USE `new-s4t-iotronic`;
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (1, 'temperature', '°C', 'TinkerKit', 'Thermistor');
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (2, 'brightness', 'lux', 'TinkerKit', 'LDR');
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (3, 'humidity', '%', 'Honeywell', 'HIH-4030');
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (4, 'sound_detect', 'db', 'Keyes', 'HY-038');
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (5, 'gas', 'ppm', 'Grove', 'MQ9');
INSERT INTO `new-s4t-iotronic`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (6, 'barometer', 'hPa', 'TinkerKit', 'mpl3115');

COMMIT;


-- -----------------------------------------------------
-- Data for table `new-s4t-iotronic`.`services`
-- -----------------------------------------------------
START TRANSACTION;
USE `new-s4t-iotronic`;
INSERT INTO `new-s4t-iotronic`.`services` (`id`, `name`, `port`, `protocol`) VALUES (1, 'SSH', 22, 'TCP');

COMMIT;

