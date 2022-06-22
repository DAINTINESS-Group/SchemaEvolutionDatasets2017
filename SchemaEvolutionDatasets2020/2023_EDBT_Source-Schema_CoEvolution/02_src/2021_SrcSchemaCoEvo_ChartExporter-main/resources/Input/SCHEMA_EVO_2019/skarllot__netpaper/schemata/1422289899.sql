SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `netpaper` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `netpaper` ;

-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rack`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `rack` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `location` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_rack_1_idx` (`location` ASC) ,
  CONSTRAINT `fk_rack_location`
    FOREIGN KEY (`location` )
    REFERENCES `location` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `device_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `device` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `rack` INT NOT NULL ,
  `device_type` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_device_1_idx` (`device_type` ASC) ,
  INDEX `fk_device_2_idx` (`rack` ASC) ,
  CONSTRAINT `fk_device_devicetype`
    FOREIGN KEY (`device_type` )
    REFERENCES `device_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device_port`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `device_port` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `device` INT NOT NULL ,
  `number` SMALLINT NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_device_port_1_idx` (`device` ASC) ,
  CONSTRAINT `fk_deviceport_device`
    FOREIGN KEY (`device` )
    REFERENCES `device` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connection_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `connection_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connection`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `connection` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `connection_type` INT NOT NULL ,
  `rack` INT NOT NULL ,
  `deviceport_1` INT NOT NULL ,
  `deviceport_2` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_connection_1_idx` (`connection_type` ASC) ,
  INDEX `fk_connection_2_idx` (`rack` ASC) ,
  INDEX `fk_connection_3_idx` (`deviceport_1` ASC) ,
  INDEX `fk_connection_4_idx` (`deviceport_2` ASC) ,
  CONSTRAINT `fk_connection_connectiontype`
    FOREIGN KEY (`connection_type` )
    REFERENCES `connection_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_deviceport_1`
    FOREIGN KEY (`deviceport_1` )
    REFERENCES `device_port` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_deviceport_2`
    FOREIGN KEY (`deviceport_2` )
    REFERENCES `device_port` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `language` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(5) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(64) NULL ,
  `email` VARCHAR(255) NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `isAdmin` TINYINT(1) NOT NULL DEFAULT 0 ,
  `isLdap` TINYINT(1) NOT NULL DEFAULT 0 ,
  `language` INT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_1_idx` (`language` ASC) ,
  CONSTRAINT `fk_user_language`
    FOREIGN KEY (`language` )
    REFERENCES `language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `user_group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user` INT NOT NULL ,
  `group` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_usergroup_user_idx` (`user` ASC) ,
  INDEX `fk_usergroup_group_idx` (`group` ASC) ,
  CONSTRAINT `fk_usergroup_user`
    FOREIGN KEY (`user` )
    REFERENCES `user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usergroup_group`
    FOREIGN KEY (`group` )
    REFERENCES `group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `access_location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `access_location` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group` INT NOT NULL ,
  `location` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accesslocation_group_idx` (`group` ASC) ,
  INDEX `fk_accesslocation_location_idx` (`location` ASC) ,
  CONSTRAINT `fk_accesslocation_group`
    FOREIGN KEY (`group` )
    REFERENCES `group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accesslocation_location`
    FOREIGN KEY (`location` )
    REFERENCES `location` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `access_rack`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `access_rack` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group` INT NOT NULL ,
  `rack` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accessrack_group_idx` (`group` ASC) ,
  INDEX `fk_accessrack_rack_idx` (`rack` ASC) ,
  CONSTRAINT `fk_accessrack_group`
    FOREIGN KEY (`group` )
    REFERENCES `group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accessrack_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connection_type_lang`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `connection_type_lang` (
  `language` INT NOT NULL ,
  `connection_type` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`language`, `connection_type`) ,
  INDEX `fk_connectiontypelang_language_idx` (`language` ASC) ,
  INDEX `fk_connectiontypelang_connectiontype_idx` (`connection_type` ASC) ,
  CONSTRAINT `fk_connectiontypelang_language`
    FOREIGN KEY (`language` )
    REFERENCES `language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connectiontypelang_connectiontype`
    FOREIGN KEY (`connection_type` )
    REFERENCES `connection_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device_type_lang`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `device_type_lang` (
  `language` INT NOT NULL ,
  `device_type` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`language`, `device_type`) ,
  INDEX `fk_devicetypelang_language_idx` (`language` ASC) ,
  INDEX `fk_devicetypelang_devicetype_idx` (`device_type` ASC) ,
  CONSTRAINT `fk_devicetypelang_language`
    FOREIGN KEY (`language` )
    REFERENCES `language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devicetypelang_devicetype`
    FOREIGN KEY (`device_type` )
    REFERENCES `device_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `session`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `session` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user` INT NOT NULL ,
  `auth_token` VARCHAR(255) NOT NULL ,
  `ipaddress` VARCHAR(15) NULL ,
  `ip6address` VARCHAR(39) NULL ,
  `created_at` DATETIME NOT NULL ,
  `updated_at` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_session_user_idx` (`user` ASC) ,
  CONSTRAINT `fk_session_user`
    FOREIGN KEY (`user` )
    REFERENCES `user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbversion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `dbversion` (
  `value` VARCHAR(9) NOT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ldap`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `ldap` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `domain_name` VARCHAR(255) NOT NULL ,
  `base_dn` VARCHAR(255) NULL ,
  `servers_name` VARCHAR(255) NOT NULL ,
  `use_ssl` TINYINT(1) NOT NULL ,
  `use_tls` TINYINT(1) NOT NULL ,
  `port` SMALLINT NULL ,
  `filter` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

USE `netpaper` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `device_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Switch');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Patch Panel');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Router');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Hub');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Access Point');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Server');
INSERT INTO `device_type` (`id`, `name`) VALUES (DEFAULT, 'Workstation');

COMMIT;

-- -----------------------------------------------------
-- Data for table `connection_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `connection_type` (`id`, `name`) VALUES (DEFAULT, 'Electrical Patch Cord');
INSERT INTO `connection_type` (`id`, `name`) VALUES (DEFAULT, 'Optical Patch Cord');
INSERT INTO `connection_type` (`id`, `name`) VALUES (DEFAULT, 'Electrical Cable');
INSERT INTO `connection_type` (`id`, `name`) VALUES (DEFAULT, 'Optical Cable');

COMMIT;

-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `language` (`id`, `code`, `name`) VALUES (DEFAULT, 'en-US', 'English (Default)');
INSERT INTO `language` (`id`, `code`, `name`) VALUES (DEFAULT, 'pt-BR', 'Português (Brasil)');

COMMIT;

-- -----------------------------------------------------
-- Data for table `connection_type_lang`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 1, 'Patch Cord Elétrico');
INSERT INTO `connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 2, 'Patch Cord Óptico');
INSERT INTO `connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 3, 'Cabo Elétrico');
INSERT INTO `connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 4, 'Cabo Óptico');

COMMIT;

-- -----------------------------------------------------
-- Data for table `device_type_lang`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 1, 'Switch');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 2, 'Patch Panel');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 3, 'Roteador');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 4, 'Hub');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 5, 'Access Point');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 6, 'Servidor');
INSERT INTO `device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 7, 'Estação de Trabalho');

COMMIT;

-- -----------------------------------------------------
-- Data for table `dbversion`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `dbversion` (`value`) VALUES ('0.1');

COMMIT;
