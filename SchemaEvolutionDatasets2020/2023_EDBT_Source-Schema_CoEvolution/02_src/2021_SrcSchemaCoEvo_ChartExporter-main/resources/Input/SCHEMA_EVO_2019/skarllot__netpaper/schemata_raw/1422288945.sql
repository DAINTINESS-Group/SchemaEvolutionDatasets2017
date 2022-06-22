SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `netpaper` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `netpaper` ;

-- -----------------------------------------------------
-- Table `netpaper`.`location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`location` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`rack`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`rack` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `location` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_rack_1_idx` (`location` ASC) ,
  CONSTRAINT `fk_rack_location`
    FOREIGN KEY (`location` )
    REFERENCES `netpaper`.`location` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`device_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`device_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`device`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`device` (
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
    REFERENCES `netpaper`.`device_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `netpaper`.`rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`device_port`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`device_port` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `device` INT NOT NULL ,
  `number` SMALLINT NOT NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_device_port_1_idx` (`device` ASC) ,
  CONSTRAINT `fk_deviceport_device`
    FOREIGN KEY (`device` )
    REFERENCES `netpaper`.`device` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`connection_type`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`connection_type` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`connection`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`connection` (
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
    REFERENCES `netpaper`.`connection_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `netpaper`.`rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_deviceport_1`
    FOREIGN KEY (`deviceport_1` )
    REFERENCES `netpaper`.`device_port` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connection_deviceport_2`
    FOREIGN KEY (`deviceport_2` )
    REFERENCES `netpaper`.`device_port` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`language`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`language` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `code` VARCHAR(5) NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(64) NULL ,
  `email` VARCHAR(255) NULL ,
  `name` VARCHAR(255) NOT NULL ,
  `admin` TINYINT(1) NOT NULL DEFAULT 0 ,
  `is_ldap` TINYINT(1) NOT NULL DEFAULT 0 ,
  `language` INT NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_1_idx` (`language` ASC) ,
  CONSTRAINT `fk_user_language`
    FOREIGN KEY (`language` )
    REFERENCES `netpaper`.`language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`user_group`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`user_group` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user` INT NOT NULL ,
  `group` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_usergroup_user_idx` (`user` ASC) ,
  INDEX `fk_usergroup_group_idx` (`group` ASC) ,
  CONSTRAINT `fk_usergroup_user`
    FOREIGN KEY (`user` )
    REFERENCES `netpaper`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usergroup_group`
    FOREIGN KEY (`group` )
    REFERENCES `netpaper`.`group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`access_location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`access_location` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group` INT NOT NULL ,
  `location` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accesslocation_group_idx` (`group` ASC) ,
  INDEX `fk_accesslocation_location_idx` (`location` ASC) ,
  CONSTRAINT `fk_accesslocation_group`
    FOREIGN KEY (`group` )
    REFERENCES `netpaper`.`group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accesslocation_location`
    FOREIGN KEY (`location` )
    REFERENCES `netpaper`.`location` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`access_rack`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`access_rack` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `group` INT NOT NULL ,
  `rack` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_accessrack_group_idx` (`group` ASC) ,
  INDEX `fk_accessrack_rack_idx` (`rack` ASC) ,
  CONSTRAINT `fk_accessrack_group`
    FOREIGN KEY (`group` )
    REFERENCES `netpaper`.`group` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_accessrack_rack`
    FOREIGN KEY (`rack` )
    REFERENCES `netpaper`.`rack` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`connection_type_lang`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`connection_type_lang` (
  `language` INT NOT NULL ,
  `connection_type` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`language`, `connection_type`) ,
  INDEX `fk_connectiontypelang_language_idx` (`language` ASC) ,
  INDEX `fk_connectiontypelang_connectiontype_idx` (`connection_type` ASC) ,
  CONSTRAINT `fk_connectiontypelang_language`
    FOREIGN KEY (`language` )
    REFERENCES `netpaper`.`language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_connectiontypelang_connectiontype`
    FOREIGN KEY (`connection_type` )
    REFERENCES `netpaper`.`connection_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`device_type_lang`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`device_type_lang` (
  `language` INT NOT NULL ,
  `device_type` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`language`, `device_type`) ,
  INDEX `fk_devicetypelang_language_idx` (`language` ASC) ,
  INDEX `fk_devicetypelang_devicetype_idx` (`device_type` ASC) ,
  CONSTRAINT `fk_devicetypelang_language`
    FOREIGN KEY (`language` )
    REFERENCES `netpaper`.`language` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devicetypelang_devicetype`
    FOREIGN KEY (`device_type` )
    REFERENCES `netpaper`.`device_type` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`session`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`session` (
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
    REFERENCES `netpaper`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`dbversion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`dbversion` (
  `value` VARCHAR(9) NOT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `netpaper`.`ldap`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `netpaper`.`ldap` (
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
-- Data for table `netpaper`.`device_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Switch');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Patch Panel');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Router');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Hub');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Access Point');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Server');
INSERT INTO `netpaper`.`device_type` (`id`, `name`) VALUES (DEFAULT, 'Workstation');

COMMIT;

-- -----------------------------------------------------
-- Data for table `netpaper`.`connection_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`connection_type` (`id`, `name`) VALUES (DEFAULT, 'Electrical Patch Cord');
INSERT INTO `netpaper`.`connection_type` (`id`, `name`) VALUES (DEFAULT, 'Optical Patch Cord');
INSERT INTO `netpaper`.`connection_type` (`id`, `name`) VALUES (DEFAULT, 'Electrical Cable');
INSERT INTO `netpaper`.`connection_type` (`id`, `name`) VALUES (DEFAULT, 'Optical Cable');

COMMIT;

-- -----------------------------------------------------
-- Data for table `netpaper`.`language`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`language` (`id`, `code`, `name`) VALUES (DEFAULT, 'en-US', 'English (Default)');
INSERT INTO `netpaper`.`language` (`id`, `code`, `name`) VALUES (DEFAULT, 'pt-BR', 'Português (Brasil)');

COMMIT;

-- -----------------------------------------------------
-- Data for table `netpaper`.`connection_type_lang`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 1, 'Patch Cord Elétrico');
INSERT INTO `netpaper`.`connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 2, 'Patch Cord Óptico');
INSERT INTO `netpaper`.`connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 3, 'Cabo Elétrico');
INSERT INTO `netpaper`.`connection_type_lang` (`language`, `connection_type`, `name`) VALUES (2, 4, 'Cabo Óptico');

COMMIT;

-- -----------------------------------------------------
-- Data for table `netpaper`.`device_type_lang`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 1, 'Switch');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 2, 'Patch Panel');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 3, 'Roteador');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 4, 'Hub');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 5, 'Access Point');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 6, 'Servidor');
INSERT INTO `netpaper`.`device_type_lang` (`language`, `device_type`, `name`) VALUES (2, 7, 'Estação de Trabalho');

COMMIT;

-- -----------------------------------------------------
-- Data for table `netpaper`.`dbversion`
-- -----------------------------------------------------
START TRANSACTION;
USE `netpaper`;
INSERT INTO `netpaper`.`dbversion` (`value`) VALUES ('0.1');

COMMIT;
