-- -----------------------------------------------------
-- Hospital Creation Script
-- 
-- MySQL Workbench Forward Engineering
--
-- Contents:
--    54 `hospital`.`address` CREATE
--    71 `hospital`.`person` CREATE
--    89 `hospital`.`department` CREATE
--   104 `hospital`.`status` CREATE
--   117 `hospital`.`appointment` CREATE
--   152 `hospital`.`treatment` CREATE
--   181 `hospital`.`medication` CREATE
--   196 `hospital`.`dosage` CREATE
--   209 `hospital`.`frequency` CREATE
--   222 `hospital`.`duration` CREATE
--   235 `hospital`.`prescription` CREATE
--   280 `hospital`.`bill` CREATE
--   307 `hospital`.`room_type` CREATE
--   320 `hospital`.`room` CREATE
--   342 `hospital`.`overnight_room_assignment` CREATE
--   370 `hospital`.`role` CREATE
--   383 `hospital`.`person_has_address` CREATE
--   407 `hospital`.`person_has_role` CREATE
--   431 `hospital`.`staff` CREATE
-- 
-- Author:
--   Nathan Bird (bir19004@byui.edu)
-- -----------------------------------------------------


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `hospital`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`address` ;

CREATE TABLE IF NOT EXISTS `hospital`.`address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_1` VARCHAR(255) NOT NULL,
  `address_2` VARCHAR(255) NULL,
  `city` VARCHAR(45) NULL,
  `state` CHAR(2) NULL,
  `postal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`person` ;

CREATE TABLE IF NOT EXISTS `hospital`.`person` (
  `person_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `sex` ENUM('M', 'F', 'Other') NOT NULL,
  `date_of_birth` DATE NULL,
  `phone` VARCHAR(16) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE INDEX `patient_id_UNIQUE` (`person_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`department` ;

CREATE TABLE IF NOT EXISTS `hospital`.`department` (
  `department_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NULL,
  `phone` VARCHAR(16) NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`status` ;

CREATE TABLE IF NOT EXISTS `hospital`.`status` (
  `status_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `status_id_UNIQUE` (`status_id` ASC) VISIBLE,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`appointment` ;

CREATE TABLE IF NOT EXISTS `hospital`.`appointment` (
  `appointment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` INT UNSIGNED NOT NULL,
  `doctor_id` INT UNSIGNED NOT NULL,
  `datetime` DATETIME NOT NULL,
  `reason` TEXT NULL,
  `status_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`appointment_id`),
  UNIQUE INDEX `appointment_id_UNIQUE` (`appointment_id` ASC) VISIBLE,
  INDEX `fk_appointment_person1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_appointment_person2_idx` (`doctor_id` ASC) VISIBLE,
  INDEX `fk_appointment_status1_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_person1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_person2`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `hospital`.`status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`treatment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`treatment` ;

CREATE TABLE IF NOT EXISTS `hospital`.`treatment` (
  `treatment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `patient_id` INT UNSIGNED NOT NULL,
  `doctor_id` INT UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `diagnosis` TEXT NULL,
  `details` TEXT NULL,
  PRIMARY KEY (`treatment_id`),
  UNIQUE INDEX `treatment_id_UNIQUE` (`treatment_id` ASC) VISIBLE,
  INDEX `fk_treatment_person1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_treatment_person2_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_treatment_person1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_treatment_person2`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`medication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`medication` ;

CREATE TABLE IF NOT EXISTS `hospital`.`medication` (
  `medication_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `stock_quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`medication_id`),
  UNIQUE INDEX `medication_id_UNIQUE` (`medication_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`dosage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`dosage` ;

CREATE TABLE IF NOT EXISTS `hospital`.`dosage` (
  `dosage_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dosage` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dosage_id`),
  UNIQUE INDEX `dosage_id_UNIQUE` (`dosage_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`frequency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`frequency` ;

CREATE TABLE IF NOT EXISTS `hospital`.`frequency` (
  `frequency_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `frequency` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`frequency_id`),
  UNIQUE INDEX `frequency_id_UNIQUE` (`frequency_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`duration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`duration` ;

CREATE TABLE IF NOT EXISTS `hospital`.`duration` (
  `duration_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `duration` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`duration_id`),
  UNIQUE INDEX `duration_id_UNIQUE` (`duration_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`prescription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`prescription` ;

CREATE TABLE IF NOT EXISTS `hospital`.`prescription` (
  `treatment_id` BIGINT UNSIGNED NOT NULL,
  `medication_id` BIGINT UNSIGNED NOT NULL,
  `dosage_id` INT UNSIGNED NOT NULL,
  `frequency_id` INT UNSIGNED NOT NULL,
  `duration_id` INT UNSIGNED NOT NULL,
  INDEX `fk_prescription_treatment1_idx` (`treatment_id` ASC) VISIBLE,
  INDEX `fk_prescription_medication1_idx` (`medication_id` ASC) VISIBLE,
  PRIMARY KEY (`treatment_id`, `medication_id`),
  INDEX `fk_prescription_dosage1_idx` (`dosage_id` ASC) VISIBLE,
  INDEX `fk_prescription_frequency1_idx` (`frequency_id` ASC) VISIBLE,
  INDEX `fk_prescription_duration1_idx` (`duration_id` ASC) VISIBLE,
  CONSTRAINT `fk_prescription_treatment1`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `hospital`.`treatment` (`treatment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_medication1`
    FOREIGN KEY (`medication_id`)
    REFERENCES `hospital`.`medication` (`medication_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_dosage1`
    FOREIGN KEY (`dosage_id`)
    REFERENCES `hospital`.`dosage` (`dosage_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_frequency1`
    FOREIGN KEY (`frequency_id`)
    REFERENCES `hospital`.`frequency` (`frequency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_duration1`
    FOREIGN KEY (`duration_id`)
    REFERENCES `hospital`.`duration` (`duration_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`bill`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`bill` ;

CREATE TABLE IF NOT EXISTS `hospital`.`bill` (
  `patient_id` INT UNSIGNED NOT NULL,
  `treatment_id` BIGINT UNSIGNED NOT NULL,
  `date` DATE NOT NULL,
  `total` DECIMAL NOT NULL,
  `paid_amount` DECIMAL NULL DEFAULT 0,
  PRIMARY KEY (`patient_id`, `treatment_id`),
  INDEX `fk_bill_treatment1_idx` (`treatment_id` ASC) VISIBLE,
  INDEX `fk_bill_person1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_bill_treatment1`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `hospital`.`treatment` (`treatment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bill_person1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`room_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`room_type` ;

CREATE TABLE IF NOT EXISTS `hospital`.`room_type` (
  `room_type_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`room_type_id`),
  UNIQUE INDEX `room_type_id_UNIQUE` (`room_type_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`room` ;

CREATE TABLE IF NOT EXISTS `hospital`.`room` (
  `room_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` SMALLINT UNSIGNED NOT NULL,
  `room_type_id` SMALLINT UNSIGNED NOT NULL,
  `capacity` SMALLINT UNSIGNED NOT NULL,
  `available` TINYINT NOT NULL,
  PRIMARY KEY (`room_id`),
  UNIQUE INDEX `room_id_UNIQUE` (`room_id` ASC) VISIBLE,
  INDEX `fk_room_room_type1_idx` (`room_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_room_type1`
    FOREIGN KEY (`room_type_id`)
    REFERENCES `hospital`.`room_type` (`room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`overnight_room_assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`overnight_room_assignment` ;

CREATE TABLE IF NOT EXISTS `hospital`.`overnight_room_assignment` (
  `assignment_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_id` INT UNSIGNED NOT NULL,
  `room_id` INT UNSIGNED NOT NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59',
  PRIMARY KEY (`assignment_id`),
  UNIQUE INDEX `patient_room_assignment_id_UNIQUE` (`assignment_id` ASC) VISIBLE,
  INDEX `fk_patient_room_assignment_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_patient_room_assignment_room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_room_assignment_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_room_assignment_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `hospital`.`room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`role` ;

CREATE TABLE IF NOT EXISTS `hospital`.`role` (
  `role_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`person_has_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`person_has_address` ;

CREATE TABLE IF NOT EXISTS `hospital`.`person_has_address` (
  `person_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  `current` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_address_has_person_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_address_has_person_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_has_person_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_has_person_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `hospital`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`person_has_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`person_has_role` ;

CREATE TABLE IF NOT EXISTS `hospital`.`person_has_role` (
  `person_id` INT UNSIGNED NOT NULL,
  `role_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`person_id`, `role_id`),
  INDEX `fk_person_has_role_role1_idx` (`role_id` ASC) VISIBLE,
  INDEX `fk_person_has_role_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_has_role_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_role_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `hospital`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospital`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hospital`.`staff` ;

CREATE TABLE IF NOT EXISTS `hospital`.`staff` (
  `person_id` INT UNSIGNED NOT NULL,
  `department_id` SMALLINT UNSIGNED NOT NULL,
  `currently_employed` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`person_id`, `department_id`),
  INDEX `fk_staff_person1_idx` (`person_id` ASC) VISIBLE,
  INDEX `fk_staff_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `hospital`.`person` (`person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hospital`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
