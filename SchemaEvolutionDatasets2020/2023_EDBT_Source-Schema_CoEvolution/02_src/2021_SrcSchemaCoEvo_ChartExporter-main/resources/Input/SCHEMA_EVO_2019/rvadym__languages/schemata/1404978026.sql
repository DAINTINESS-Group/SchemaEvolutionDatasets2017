-- -----------------------------------------------------
-- Table `languages`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `language` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `ui_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `languages`.`translation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `translation` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(128) NOT NULL DEFAULT '',
  `en` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;
