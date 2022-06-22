CREATE TABLE IF NOT EXISTS `field` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `value` TEXT NULL,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `option` (
  `id` INT NOT NULL,
  `option` TEXT NULL,
  `field_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_option_field_idx` (`field_id` ASC),
  CONSTRAINT `fk_option_field`
    FOREIGN KEY (`field_id`)
    REFERENCES `field` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;