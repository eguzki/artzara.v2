-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema artzara
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `artzara` ;

-- -----------------------------------------------------
-- Schema artzara
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `artzara` DEFAULT CHARACTER SET utf8 ;
USE `artzara` ;

-- -----------------------------------------------------
-- Table `artzara`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`member` ;

CREATE TABLE IF NOT EXISTS `artzara`.`member` (
  `idmember` INT(11) NOT NULL AUTO_INCREMENT,
  `username` INT(11) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `surname1` VARCHAR(100) NOT NULL,
  `surname2` VARCHAR(100) NOT NULL,
  `image` VARCHAR(300) NULL,
  `lastmodified` DATETIME NOT NULL,
  `reg_date` DATETIME NOT NULL,
  `active` TINYINT(1) NOT NULL,
  `isAdmin` TINYINT(1) NOT NULL,
  `birth` DATE NULL,
  `address` VARCHAR(120) NULL,
  `zip_code` VARCHAR(20) NULL,
  `town` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `tel` VARCHAR(45) NULL,
  `tel2` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `bank_account` VARCHAR(45) NOT NULL,
  `postal_send` TINYINT(1) NOT NULL,
  `notes` VARCHAR(2000) NULL,
  `pwd` VARCHAR(128) NOT NULL,
  `lastlogin` DATETIME NOT NULL,
  `id_card` VARCHAR(45) NULL,
  `card` VARCHAR(45) NULL,
  `type` INT(11) NOT NULL,
  PRIMARY KEY (`idmember`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `artzara`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`account` ;

CREATE TABLE IF NOT EXISTS `artzara`.`account` (
  `idaccount` INT(11) NOT NULL AUTO_INCREMENT,
  `idmember` INT(11) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `date` DATETIME NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `type` INT(11) NOT NULL,
  PRIMARY KEY (`idaccount`),
  INDEX `fk_account_member1_idx` (`idmember` ASC),
  CONSTRAINT `fk_account_member1`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`invoice` ;

CREATE TABLE IF NOT EXISTS `artzara`.`invoice` (
  `idinvoice` INT(11) NOT NULL AUTO_INCREMENT,
  `state` INT(11) NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `idmember` INT(11) NOT NULL,
  `last_modif` DATETIME NOT NULL,
  PRIMARY KEY (`idinvoice`),
  INDEX `fk_invoice_member1_idx` (`idmember` ASC),
  CONSTRAINT `fk_invoice_member1`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`product_family`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`product_family` ;

CREATE TABLE IF NOT EXISTS `artzara`.`product_family` (
  `idproduct_family` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `name_es` VARCHAR(45) NULL,
  `image` VARCHAR(300) NULL,
  `active` TINYINT(1) NOT NULL,
  `reg_date` DATETIME NOT NULL,
  PRIMARY KEY (`idproduct_family`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`provider` ;

CREATE TABLE IF NOT EXISTS `artzara`.`provider` (
  `idprovider` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `image` VARCHAR(200) NULL,
  `reg_date` DATE NULL,
  `phone` VARCHAR(45) NULL,
  `notes` VARCHAR(2000) NULL,
  PRIMARY KEY (`idprovider`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`product_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`product_item` ;

CREATE TABLE IF NOT EXISTS `artzara`.`product_item` (
  `idproduct_item` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `name_es` VARCHAR(45) NULL,
  `image` VARCHAR(300) NULL,
  `active` TINYINT(1) NOT NULL,
  `reg_date` DATETIME NOT NULL,
  `idproduct_family` INT(11) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `idprovider` INT(11) NOT NULL,
  `stock` INT(11) NOT NULL,
  PRIMARY KEY (`idproduct_item`),
  INDEX `fk_product_item_product_family_idx` (`idproduct_family` ASC),
  INDEX `fk_product_item_provider1_idx` (`idprovider` ASC),
  CONSTRAINT `fk_product_item_product_family`
    FOREIGN KEY (`idproduct_family`)
    REFERENCES `artzara`.`product_family` (`idproduct_family`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_item_provider1`
    FOREIGN KEY (`idprovider`)
    REFERENCES `artzara`.`provider` (`idprovider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`inv_prod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`inv_prod` ;

CREATE TABLE IF NOT EXISTS `artzara`.`inv_prod` (
  `idinvoice` INT(11) NOT NULL,
  `idproduct_item` INT(11) NOT NULL,
  `count` INT(11) NOT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idinvoice`, `idproduct_item`),
  INDEX `fk_invoice_has_product_item_product_item1_idx` (`idproduct_item` ASC),
  INDEX `fk_invoice_has_product_item_invoice1_idx` (`idinvoice` ASC),
  CONSTRAINT `fk_invoice_has_product_item_invoice1`
    FOREIGN KEY (`idinvoice`)
    REFERENCES `artzara`.`invoice` (`idinvoice`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_has_product_item_product_item1`
    FOREIGN KEY (`idproduct_item`)
    REFERENCES `artzara`.`product_item` (`idproduct_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`deposit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`deposit` ;

CREATE TABLE IF NOT EXISTS `artzara`.`deposit` (
  `iddeposit` INT(11) NOT NULL AUTO_INCREMENT,
  `state` INT(11) NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `idmember` INT(11) NOT NULL,
  PRIMARY KEY (`iddeposit`),
  INDEX `fk_deposit_member1_idx` (`idmember` ASC),
  CONSTRAINT `fk_deposit_member1`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `artzara`.`lunchtables`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`lunchtables` ;

CREATE TABLE IF NOT EXISTS `artzara`.`lunchtables` (
  `idtable` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `guestnum` SMALLINT NOT NULL,
  PRIMARY KEY (`idtable`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`tablereservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`tablereservation` ;

CREATE TABLE IF NOT EXISTS `artzara`.`tablereservation` (
  `idreservation` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `reservationtype` TINYINT NOT NULL,
  `guestnum` SMALLINT NOT NULL,
  `idmember` INT(11) NOT NULL,
  `idtable` INT(11) NOT NULL,
  `isadmin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idreservation`),
  INDEX `fk_tablereservation_member1_idx` (`idmember` ASC),
  INDEX `fk_tablereservation_lunchtables_idx` (`idtable` ASC),
  CONSTRAINT `fk_tablereservation_member1`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tablereservation_table1`
    FOREIGN KEY (`idtable`)
    REFERENCES `artzara`.`lunchtables` (`idtable`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`provider_invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`provider_invoices` ;

CREATE TABLE IF NOT EXISTS `artzara`.`provider_invoices` (
  `idprovider_invoices` VARCHAR(50) NOT NULL,
  `date` DATE NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `idprovider` INT NOT NULL,
  PRIMARY KEY (`idprovider_invoices`),
  INDEX `fk_provider_invoices_provider1_idx` (`idprovider` ASC),
  CONSTRAINT `fk_provider_invoices_provider1`
    FOREIGN KEY (`idprovider`)
    REFERENCES `artzara`.`provider` (`idprovider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`provider_invoices_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`provider_invoices_product` ;

CREATE TABLE IF NOT EXISTS `artzara`.`provider_invoices_product` (
  `provider_invoices_idprovider_invoices` VARCHAR(50) NOT NULL,
  `product_item_idproduct_item` INT(11) NOT NULL,
  `count` INT(11) NOT NULL,
  PRIMARY KEY (`provider_invoices_idprovider_invoices`, `product_item_idproduct_item`),
  INDEX `fk_table1_provider_invoices1_idx` (`provider_invoices_idprovider_invoices` ASC),
  INDEX `fk_table1_product_item1_idx` (`product_item_idproduct_item` ASC),
  CONSTRAINT `fk_table1_provider_invoices1`
    FOREIGN KEY (`provider_invoices_idprovider_invoices`)
    REFERENCES `artzara`.`provider_invoices` (`idprovider_invoices`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_product_item1`
    FOREIGN KEY (`product_item_idproduct_item`)
    REFERENCES `artzara`.`product_item` (`idproduct_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`ovens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`ovens` ;

CREATE TABLE IF NOT EXISTS `artzara`.`ovens` (
  `idoven` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idoven`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`ovenreservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`ovenreservation` ;

CREATE TABLE IF NOT EXISTS `artzara`.`ovenreservation` (
  `idreservation` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `reservationtype` TINYINT NOT NULL,
  `idmember` INT(11) NOT NULL,
  `idoven` INT(11) NOT NULL,
  `isadmin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idreservation`),
  INDEX `fk_tablereservation_member1_idx` (`idmember` ASC),
  INDEX `fk_ovenreservation_oventables1_idx` (`idoven` ASC),
  CONSTRAINT `fk_tablereservation_member10`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ovenreservation_oventables1`
    FOREIGN KEY (`idoven`)
    REFERENCES `artzara`.`ovens` (`idoven`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`fireplaces`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`fireplaces` ;

CREATE TABLE IF NOT EXISTS `artzara`.`fireplaces` (
  `idfireplace` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfireplace`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `artzara`.`fireplacereservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `artzara`.`fireplacereservation` ;

CREATE TABLE IF NOT EXISTS `artzara`.`fireplacereservation` (
  `idreservation` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `reservationtype` TINYINT NOT NULL,
  `idmember` INT(11) NOT NULL,
  `idfireplace` INT(11) NOT NULL,
  `isadmin` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idreservation`),
  INDEX `fk_tablereservation_member1_idx` (`idmember` ASC),
  INDEX `fk_fireplacereservation_fireplacetables1_idx` (`idfireplace` ASC),
  CONSTRAINT `fk_tablereservation_member100`
    FOREIGN KEY (`idmember`)
    REFERENCES `artzara`.`member` (`idmember`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fireplacereservation_fireplacetables1`
    FOREIGN KEY (`idfireplace`)
    REFERENCES `artzara`.`fireplaces` (`idfireplace`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
