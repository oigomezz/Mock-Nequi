-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`accounts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mattress` DECIMAL NOT NULL,
  `disponible` DECIMAL NOT NULL,
  `total` DECIMAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(60) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`, `accounts_id`),
  CONSTRAINT `fk_users_accounts`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`transactions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `from` INT NOT NULL,
  `to` INT NOT NULL,
  `description` VARCHAR(80) NOT NULL,
  `value` DECIMAL NOT NULL,
  `date` DATE NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_transactions_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pockets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`pockets` ;

CREATE TABLE IF NOT EXISTS `mydb`.`pockets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pocketMoney` DECIMAL NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pockets_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`goals` ;

CREATE TABLE IF NOT EXISTS `mydb`.`goals` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `totalAmount` INT NOT NULL,
  `fulfilled` BINARY NOT NULL,
  `savedMoney` DECIMAL NOT NULL,
  `accounts_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_goals_accounts1`
    FOREIGN KEY (`accounts_id`)
    REFERENCES `mydb`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

