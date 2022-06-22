SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `language` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    `label` VARCHAR(50) NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `collection` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `language_id` INT NULL,
    `name` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_collection_language1_idx` (`language_id` ASC),
    CONSTRAINT `fk_collection_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `field` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `collection_id` INT NULL,
    `language_id` INT NULL,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `value` TEXT NULL DEFAULT NULL,
    `label` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_field_collection1_idx` (`collection_id` ASC),
    INDEX `fk_field_language1_idx` (`language_id` ASC),
    CONSTRAINT `fk_field_collection1`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_field_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `options` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `text` TEXT NULL DEFAULT NULL,
    `field_id` INT NULL,
    `language_id` INT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_options_field_idx` (`field_id` ASC),
    INDEX `fk_options_language1_idx` (`language_id` ASC),
    CONSTRAINT `fk_options_field`
    FOREIGN KEY (`field_id`)
    REFERENCES `field` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_options_language1`
    FOREIGN KEY (`language_id`)
    REFERENCES `language` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
    ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
