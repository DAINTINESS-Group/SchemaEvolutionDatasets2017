SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `frbcat`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`authors` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ivorn` VARCHAR(255) NOT NULL,
  `title` TINYTEXT NULL DEFAULT NULL,
  `logo_url` TINYTEXT NULL DEFAULT NULL,
  `short_name` TINYTEXT NULL DEFAULT NULL,
  `contact_name` TINYTEXT NULL DEFAULT NULL,
  `contact_email` TINYTEXT NULL DEFAULT NULL,
  `contact_phone` TINYTEXT NULL DEFAULT NULL,
  `other_information` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `authors_ivorn_idx` (`ivorn` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`frbs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`frbs` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` INT(10) UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `utc` DATETIME NOT NULL,
  `private` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `frbs_name_idx` USING BTREE (`name` ASC),
  INDEX `frbs_author_id_fk` (`author_id` ASC),
  CONSTRAINT `frbs_author_id_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `frbcat`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`publications` (
  `id` INT(10) UNSIGNED NOT NULL,
  `type` TEXT NULL DEFAULT NULL,
  `reference` TEXT NULL DEFAULT NULL,
  `link` TEXT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`frbs_have_publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`frbs_have_publications` (
  `frb_id` INT(10) UNSIGNED NOT NULL,
  `pub_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`frb_id`, `pub_id`),
  INDEX `frbs_have_publications_pub_id_fk` (`pub_id` ASC),
  CONSTRAINT `frbs_have_publications_frb_id_fk`
    FOREIGN KEY (`frb_id`)
    REFERENCES `frbcat`.`frbs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `frbs_have_publications_pub_id_fk`
    FOREIGN KEY (`pub_id`)
    REFERENCES `frbcat`.`publications` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`frbs_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`frbs_notes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `frb_id` INT(10) UNSIGNED NOT NULL,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` VARCHAR(32) NOT NULL DEFAULT '',
  `note` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `frbs_notes_frb_id_fk` (`frb_id` ASC),
  CONSTRAINT `frbs_notes_frb_id_fk`
    FOREIGN KEY (`frb_id`)
    REFERENCES `frbcat`.`frbs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`observations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`observations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `frb_id` INT(10) UNSIGNED NOT NULL,
  `author_id` INT(10) UNSIGNED NOT NULL,
  `type` TEXT NULL DEFAULT NULL,
  `telescope` VARCHAR(128) NOT NULL,
  `utc` DATETIME NOT NULL,
  `data_link` TEXT NULL DEFAULT NULL,
  `detected` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `observations_author_id_fk` (`author_id` ASC),
  INDEX `observations_frb_id_fk` (`frb_id` ASC),
  UNIQUE INDEX `observations_unique` (`frb_id` ASC, `telescope` ASC, `utc` ASC),
  CONSTRAINT `observations_author_id_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `frbcat`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `observations_frb_id_fk`
    FOREIGN KEY (`frb_id`)
    REFERENCES `frbcat`.`frbs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`observations_have_publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`observations_have_publications` (
  `obs_id` INT(10) UNSIGNED NOT NULL,
  `pub_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`obs_id`, `pub_id`),
  INDEX `observations_have_publications_pub_id_fk` (`pub_id` ASC),
  CONSTRAINT `observations_have_publications_obs_id_fk`
    FOREIGN KEY (`obs_id`)
    REFERENCES `frbcat`.`observations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `observations_have_publications_pub_id_fk`
    FOREIGN KEY (`pub_id`)
    REFERENCES `frbcat`.`publications` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`observations_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`observations_notes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `obs_id` INT(10) UNSIGNED NOT NULL,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` VARCHAR(32) NOT NULL DEFAULT '',
  `note` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `observations_notes_obs_id_fk` (`obs_id` ASC),
  CONSTRAINT `observations_notes_obs_id_fk`
    FOREIGN KEY (`obs_id`)
    REFERENCES `frbcat`.`observations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_images` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` TEXT NULL DEFAULT NULL,
  `caption` LONGTEXT NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_observations_params`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_observations_params` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `obs_id` INT(10) UNSIGNED NOT NULL,
  `author_id` INT(10) UNSIGNED NOT NULL,
  `settings_id` VARCHAR(255) NOT NULL,
  `receiver` TEXT NULL DEFAULT NULL,
  `backend` TEXT NULL DEFAULT NULL,
  `beam` VARCHAR(8) NULL DEFAULT NULL,
  `raj` VARCHAR(16) NOT NULL DEFAULT '',
  `decj` VARCHAR(16) NOT NULL DEFAULT '',
  `gl` FLOAT NULL DEFAULT NULL,
  `gb` FLOAT NULL DEFAULT NULL,
  `pointing_error` FLOAT NULL DEFAULT NULL COMMENT 'pointing accuracy in arcsec',
  `FWHM` FLOAT NULL DEFAULT NULL COMMENT 'FWHM of beam in arcmin',
  `sampling_time` FLOAT NULL DEFAULT NULL,
  `bandwidth` FLOAT NULL DEFAULT NULL COMMENT 'in MHz',
  `centre_frequency` FLOAT NULL DEFAULT NULL COMMENT 'in MHz',
  `npol` INT(10) NULL DEFAULT NULL,
  `channel_bandwidth` FLOAT NULL DEFAULT NULL COMMENT 'in MHz',
  `bits_per_sample` TINYINT(4) NULL DEFAULT NULL,
  `gain` FLOAT NULL DEFAULT NULL COMMENT 'K/Jy',
  `tsys` FLOAT NULL DEFAULT NULL COMMENT 'K',
  `ne2001_dm_limit` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `rop_author_id_fk` (`author_id` ASC),
  INDEX `rop_obs_id_fk` (`obs_id` ASC),
  UNIQUE INDEX `rop_unique` (`obs_id` ASC, `settings_id` ASC),
  CONSTRAINT `radio_observed_params_author_id_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `frbcat`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `radio_observed_params_obs_id_fk`
    FOREIGN KEY (`obs_id`)
    REFERENCES `frbcat`.`observations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_measured_params`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_measured_params` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rop_id` INT(10) UNSIGNED NOT NULL,
  `author_id` INT(10) UNSIGNED NOT NULL,
  `voevent_ivorn` VARCHAR(255) NOT NULL,
  `voevent_xml` LONGTEXT NOT NULL,
  `dm` FLOAT NOT NULL,
  `dm_error` FLOAT NULL DEFAULT NULL,
  `snr` FLOAT NOT NULL,
  `width` FLOAT NOT NULL,
  `width_error_upper` FLOAT NULL DEFAULT NULL,
  `width_error_lower` FLOAT NULL DEFAULT NULL,
  `flux` FLOAT NULL DEFAULT NULL,
  `flux_prefix` VARCHAR(255) NULL DEFAULT NULL,
  `flux_error_upper` FLOAT NULL DEFAULT NULL,
  `flux_error_lower` FLOAT NULL DEFAULT NULL,
  `flux_calibrated` TINYINT(4) NULL DEFAULT NULL,
  `dm_index` FLOAT NULL DEFAULT NULL,
  `dm_index_error` FLOAT NULL DEFAULT NULL,
  `scattering_index` FLOAT NULL DEFAULT NULL,
  `scattering_index_error` FLOAT NULL DEFAULT NULL,
  `scattering_time` FLOAT NULL DEFAULT NULL COMMENT 'At 1 GHz',
  `scattering_time_error` FLOAT NULL DEFAULT NULL,
  `linear_poln_frac` FLOAT NULL DEFAULT NULL,
  `linear_poln_frac_error` FLOAT NULL DEFAULT NULL,
  `circular_poln_frac` FLOAT NULL DEFAULT NULL,
  `circular_poln_frac_error` FLOAT NULL DEFAULT NULL,
  `spectral_index` FLOAT NULL DEFAULT NULL,
  `spectral_index_error` FLOAT NULL DEFAULT NULL,
  `z_phot` FLOAT NULL DEFAULT NULL,
  `z_phot_error` FLOAT NULL DEFAULT NULL,
  `z_spec` FLOAT NULL DEFAULT NULL,
  `z_spec_error` FLOAT NULL DEFAULT NULL,
  `rank` INT(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `rmp_rop_id_fk` (`rop_id` ASC),
  INDEX `rmp_author_id_fk` (`author_id` ASC),
  UNIQUE INDEX `rmp_unique` (`voevent_ivorn` ASC),
  CONSTRAINT `radio_measured_params_author_id_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `frbcat`.`authors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `radio_measured_params_rop_id_fk`
    FOREIGN KEY (`rop_id`)
    REFERENCES `frbcat`.`radio_observations_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_images_have_radio_measured_params`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_images_have_radio_measured_params` (
  `radio_image_id` INT(10) UNSIGNED NOT NULL,
  `rmp_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`radio_image_id`, `rmp_id`),
  INDEX `radio_images_have_radio_measured_params_rmp_id_fk` (`rmp_id` ASC),
  CONSTRAINT `radio_images_have_radio_measured_params_radio_image_id_fk`
    FOREIGN KEY (`radio_image_id`)
    REFERENCES `frbcat`.`radio_images` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `radio_images_have_radio_measured_params_rmp_id_fk`
    FOREIGN KEY (`rmp_id`)
    REFERENCES `frbcat`.`radio_measured_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_measured_params_have_publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_measured_params_have_publications` (
  `rmp_id` INT(10) UNSIGNED NOT NULL,
  `pub_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`rmp_id`, `pub_id`),
  INDEX `radio_measured_params_have_publications_pub_id_fk` (`pub_id` ASC),
  CONSTRAINT `radio_measured_params_have_publications_pub_id_fk`
    FOREIGN KEY (`pub_id`)
    REFERENCES `frbcat`.`publications` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `radio_measured_params_have_publications_rmp_id_fk`
    FOREIGN KEY (`rmp_id`)
    REFERENCES `frbcat`.`radio_measured_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_measured_params_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_measured_params_notes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rmp_id` INT(10) UNSIGNED NOT NULL,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` VARCHAR(32) NOT NULL DEFAULT '',
  `note` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `radio_measured_params_notes_rmp_id_fk` (`rmp_id` ASC),
  CONSTRAINT `radio_measured_params_notes_rmp_id_fk`
    FOREIGN KEY (`rmp_id`)
    REFERENCES `frbcat`.`radio_measured_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_observations_params_have_publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_observations_params_have_publications` (
  `rop_id` INT(10) UNSIGNED NOT NULL,
  `pub_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`rop_id`, `pub_id`),
  INDEX `radio_observed_params_have_publications_pub_id_fk` (`pub_id` ASC),
  CONSTRAINT `radio_observed_params_have_publications_pub_id_fk`
    FOREIGN KEY (`pub_id`)
    REFERENCES `frbcat`.`publications` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `radio_observed_params_have_publications_rop_id_fk`
    FOREIGN KEY (`rop_id`)
    REFERENCES `frbcat`.`radio_observations_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `frbcat`.`radio_observations_params_notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `frbcat`.`radio_observations_params_notes` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rop_id` INT(10) UNSIGNED NOT NULL,
  `last_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` VARCHAR(32) NOT NULL DEFAULT '',
  `note` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `radio_observed_params_notes_rop_id_fk` (`rop_id` ASC),
  CONSTRAINT `radio_observed_params_notes_rop_id_fk`
    FOREIGN KEY (`rop_id`)
    REFERENCES `frbcat`.`radio_observations_params` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
