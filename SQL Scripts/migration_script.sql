-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: timesheet
-- Source Schemata: timesheet
-- Created: Wed Jan 30 17:01:14 2019
-- Workbench Version: 8.0.13
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema timesheet
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `timesheet` ;
CREATE SCHEMA IF NOT EXISTS `timesheet` ;

-- ----------------------------------------------------------------------------
-- Table timesheet.auth
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `timesheet`.`auth` (
  `email` VARCHAR(32) NOT NULL,
  `password` VARCHAR(20) NULL DEFAULT NULL,
  `isvalid` INT(11) NULL DEFAULT NULL,
  `companyid` INT(11) NULL DEFAULT NULL,
  `name` VARCHAR(20) NULL DEFAULT NULL,
  `isadmin` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`email`),
  INDEX `companyid` (`companyid` ASC) VISIBLE,
  CONSTRAINT `auth_ibfk_1`
    FOREIGN KEY (`companyid`)
    REFERENCES `timesheet`.`company` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table timesheet.company
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `timesheet`.`company` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table timesheet.period
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `timesheet`.`period` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `from_date` DATE NULL DEFAULT NULL,
  `to_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table timesheet.timesheet
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `timesheet`.`timesheet` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(32) NULL DEFAULT NULL,
  `periodid` INT(11) NULL DEFAULT NULL,
  `day` DATE NULL DEFAULT NULL,
  `hours` DECIMAL(4,2) NULL DEFAULT NULL,
  `overtime` DECIMAL(4,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `email` (`email` ASC) VISIBLE,
  INDEX `periodid` (`periodid` ASC) VISIBLE,
  CONSTRAINT `timesheet_ibfk_1`
    FOREIGN KEY (`email`)
    REFERENCES `timesheet`.`auth` (`email`),
  CONSTRAINT `timesheet_ibfk_2`
    FOREIGN KEY (`periodid`)
    REFERENCES `timesheet`.`period` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 0
DEFAULT CHARACTER SET = utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;
