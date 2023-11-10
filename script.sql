-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema moba
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moba` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `moba` ;

-- -----------------------------------------------------
-- Table `moba`.`categories_products_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`categories_products_services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `description` VARCHAR(60) NULL DEFAULT NULL,
  `status` ENUM('active', 'inactive') NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `popular` ENUM('Alta', 'Media', 'Baja') NULL DEFAULT NULL,
  `type` ENUM('servicio', 'producto') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`units` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `unit_type` ENUM('unidad', 'docena', 'centena', 'mil') NOT NULL,
  `size` ENUM('mm', 'cm', 'm') NULL DEFAULT NULL,
  `area` ENUM('cm2', 'm2') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`materials_raws`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`materials_raws` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `existing_quantity` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `units_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_materials_raws_units1_idx` (`units_id` ASC) VISIBLE,
  CONSTRAINT `fk_materials_raws_units1`
    FOREIGN KEY (`units_id`)
    REFERENCES `moba`.`units` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`number_phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`number_phones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(65) NULL DEFAULT NULL,
  `date_start` DATE NULL DEFAULT NULL,
  `date_end` DATE NULL DEFAULT NULL,
  `status` ENUM('en curso', 'finalizado', 'pausado', 'pendiente') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`team_works`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`team_works` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `specialty` VARCHAR(65) NULL DEFAULT NULL,
  `assigned_work` TEXT NULL DEFAULT NULL,
  `assigned_date` DATE NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `projects_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_team_works_projects1_idx` (`projects_id` ASC) VISIBLE,
  CONSTRAINT `fk_team_works_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `moba`.`projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`regions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`towns`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`towns` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `regions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_towns_regions1_idx` (`regions_id` ASC) VISIBLE,
  CONSTRAINT `fk_towns_regions1`
    FOREIGN KEY (`regions_id`)
    REFERENCES `moba`.`regions` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`users` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `email_verified_at` TIMESTAMP NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`people` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_card` INT NOT NULL,
  `addres` VARCHAR(55) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `team_works_id` INT NOT NULL,
  `number_phones_id` INT NOT NULL,
  `towns_id` INT NOT NULL,
  `users_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_card_UNIQUE` (`id_card` ASC) VISIBLE,
  INDEX `fk_people_team_works1_idx` (`team_works_id` ASC) VISIBLE,
  INDEX `fk_people_number_phones1_idx` (`number_phones_id` ASC) VISIBLE,
  INDEX `fk_people_towns1_idx` (`towns_id` ASC) VISIBLE,
  INDEX `fk_people_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_people_number_phones1`
    FOREIGN KEY (`number_phones_id`)
    REFERENCES `moba`.`number_phones` (`id`),
  CONSTRAINT `fk_people_team_works1`
    FOREIGN KEY (`team_works_id`)
    REFERENCES `moba`.`team_works` (`id`),
  CONSTRAINT `fk_people_towns1`
    FOREIGN KEY (`towns_id`)
    REFERENCES `moba`.`towns` (`id`),
  CONSTRAINT `fk_people_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `moba`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`purchases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `people_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_purchases_people1_idx` (`people_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `moba`.`people` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`detail_purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`detail_purchases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL DEFAULT NULL,
  `price_unit` INT NULL DEFAULT NULL,
  `subtotal` INT NULL DEFAULT NULL,
  `discount` INT NULL DEFAULT NULL,
  `total` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `materials_raws_id` INT NOT NULL,
  `purchases_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detail_purchases_materials_raws1_idx` (`materials_raws_id` ASC) VISIBLE,
  INDEX `fk_detail_purchases_purchases1_idx` (`purchases_id` ASC) VISIBLE,
  CONSTRAINT `fk_detail_purchases_materials_raws1`
    FOREIGN KEY (`materials_raws_id`)
    REFERENCES `moba`.`materials_raws` (`id`),
  CONSTRAINT `fk_detail_purchases_purchases1`
    FOREIGN KEY (`purchases_id`)
    REFERENCES `moba`.`purchases` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `units_id` INT NOT NULL,
  `categories_products_services_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_units1_idx` (`units_id` ASC) VISIBLE,
  INDEX `fk_products_categories_products_services1_idx` (`categories_products_services_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_categories_products_services1`
    FOREIGN KEY (`categories_products_services_id`)
    REFERENCES `moba`.`categories_products_services` (`id`),
  CONSTRAINT `fk_products_units1`
    FOREIGN KEY (`units_id`)
    REFERENCES `moba`.`units` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`quotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`quotes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_issuance` DATE NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `total` INT NULL DEFAULT NULL,
  `discount` INT NULL DEFAULT NULL,
  `status` ENUM('aprobado', 'rechazado', 'pendiente') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `people_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_quotes_people1_idx` (`people_id` ASC) VISIBLE,
  CONSTRAINT `fk_quotes_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `moba`.`people` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`services` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `date_start` DATE NULL DEFAULT NULL,
  `date_end` DATE NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `categories_products_services_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_services_categories_products_services1_idx` (`categories_products_services_id` ASC) VISIBLE,
  CONSTRAINT `fk_services_categories_products_services1`
    FOREIGN KEY (`categories_products_services_id`)
    REFERENCES `moba`.`categories_products_services` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`detail_quotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`detail_quotes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `services_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  `projects_id` INT NOT NULL,
  `quotes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detail_quotes_services1_idx` (`services_id` ASC) VISIBLE,
  INDEX `fk_detail_quotes_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_detail_quotes_projects1_idx` (`projects_id` ASC) VISIBLE,
  INDEX `fk_detail_quotes_quotes1_idx` (`quotes_id` ASC) VISIBLE,
  CONSTRAINT `fk_detail_quotes_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `moba`.`products` (`id`),
  CONSTRAINT `fk_detail_quotes_projects1`
    FOREIGN KEY (`projects_id`)
    REFERENCES `moba`.`projects` (`id`),
  CONSTRAINT `fk_detail_quotes_quotes1`
    FOREIGN KEY (`quotes_id`)
    REFERENCES `moba`.`quotes` (`id`),
  CONSTRAINT `fk_detail_quotes_services1`
    FOREIGN KEY (`services_id`)
    REFERENCES `moba`.`services` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `people_id` INT NOT NULL,
  `quotes_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sales_people1_idx` (`people_id` ASC) VISIBLE,
  INDEX `fk_sales_quotes1_idx` (`quotes_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `moba`.`people` (`id`),
  CONSTRAINT `fk_sales_quotes1`
    FOREIGN KEY (`quotes_id`)
    REFERENCES `moba`.`quotes` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`detail_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`detail_sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL DEFAULT NULL,
  `price_unit` INT NULL DEFAULT NULL,
  `subtotal` INT NULL DEFAULT NULL,
  `discount` INT NULL DEFAULT NULL,
  `total` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `sales_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detail_sales_sales1_idx` (`sales_id` ASC) VISIBLE,
  INDEX `fk_detail_sales_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_detail_sales_sales1`
    FOREIGN KEY (`sales_id`)
    REFERENCES `moba`.`sales` (`id`),
  CONSTRAINT `fk_detail_sales_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `moba`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `place` VARCHAR(60) NULL DEFAULT NULL,
  `title` VARCHAR(55) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `date_start` DATE NULL DEFAULT NULL,
  `date_end` DATE NULL DEFAULT NULL,
  `importance_range` ENUM('alta', 'media', 'baja') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`event_person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`event_person` (
  `people_id` INT NOT NULL,
  `events_id` INT NOT NULL,
  INDEX `fk_event_person_people1_idx` (`people_id` ASC) VISIBLE,
  INDEX `fk_event_person_events1_idx` (`events_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_person_events1`
    FOREIGN KEY (`events_id`)
    REFERENCES `moba`.`events` (`id`),
  CONSTRAINT `fk_event_person_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `moba`.`people` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`failed_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`failed_jobs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` VARCHAR(255) NOT NULL,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `failed_jobs_uuid_unique` (`uuid` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`material_raw_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`material_raw_product` (
  `materials_raws_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  INDEX `fk_material_raw_product_materials_raws1_idx` (`materials_raws_id` ASC) VISIBLE,
  INDEX `fk_material_raw_product_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_material_raw_product_materials_raws1`
    FOREIGN KEY (`materials_raws_id`)
    REFERENCES `moba`.`materials_raws` (`id`),
  CONSTRAINT `fk_material_raw_product_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `moba`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`migrations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`password_reset_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`password_resets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`password_resets` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  INDEX `password_resets_email_index` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `moba`.`personal_access_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moba`.`personal_access_tokens` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` VARCHAR(255) NOT NULL,
  `tokenable_id` BIGINT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `abilities` TEXT NULL DEFAULT NULL,
  `last_used_at` TIMESTAMP NULL DEFAULT NULL,
  `expires_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `personal_access_tokens_token_unique` (`token` ASC) VISIBLE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type` ASC, `tokenable_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
