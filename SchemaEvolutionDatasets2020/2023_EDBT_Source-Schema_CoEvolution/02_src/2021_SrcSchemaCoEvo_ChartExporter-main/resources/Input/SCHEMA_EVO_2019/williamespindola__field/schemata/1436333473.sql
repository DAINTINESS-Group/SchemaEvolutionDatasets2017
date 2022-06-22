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
  INDEX `fk_options_field_idx` (`field_id` ASC),
  CONSTRAINT `fk_options_field`
  FOREIGN KEY (`field_id`)
  REFERENCES `field` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `collection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `label` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `collection_field` (
  `collection_id` INT NOT NULL,
  `field_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`, `collection_id`, `field_id`),
  INDEX `fk_collection_has_field_field1_idx` (`field_id` ASC),
  INDEX `fk_collection_has_field_collection1_idx` (`collection_id` ASC),
  CONSTRAINT `fk_collection_has_field_collection1`
  FOREIGN KEY (`collection_id`)
  REFERENCES `collection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_collection_has_field_field1`
  FOREIGN KEY (`field_id`)
  REFERENCES `field` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;