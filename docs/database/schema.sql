-- ==============================================================================
-- DATABASE CREATION SCRIPT: VetCare Pro
-- Veterinary Clinic Management System
-- Version: 2.0 (23 Tables)
-- RDBMS: MySQL 8.x | Engine: InnoDB | Charset: utf8mb4 | Collation: utf8mb4_unicode_ci
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS `vetcare_db` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `vetcare_db`;

SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing tables to allow clean initialization
DROP TABLE IF EXISTS `notifications`;
DROP TABLE IF EXISTS `stock_transactions`;
DROP TABLE IF EXISTS `service_price_history`;
DROP TABLE IF EXISTS `invoice_items`;
DROP TABLE IF EXISTS `invoices`;
DROP TABLE IF EXISTS `prescription_items`;
DROP TABLE IF EXISTS `prescriptions`;
DROP TABLE IF EXISTS `diagnoses`;
DROP TABLE IF EXISTS `medical_records`;
DROP TABLE IF EXISTS `vaccinations`;
DROP TABLE IF EXISTS `vaccines`;
DROP TABLE IF EXISTS `medicines`;
DROP TABLE IF EXISTS `services`;
DROP TABLE IF EXISTS `vet_leaves`;
DROP TABLE IF EXISTS `vet_working_hours`;
DROP TABLE IF EXISTS `appointments`;
DROP TABLE IF EXISTS `pets`;
DROP TABLE IF EXISTS `receptionists`;
DROP TABLE IF EXISTS `veterinarians`;
DROP TABLE IF EXISTS `pet_owners`;
DROP TABLE IF EXISTS `user_roles`;
DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------------------
-- 1. MODULE A: USERS & AUTHENTICATION (RBAC)
-- ------------------------------------------------------------------------------

CREATE TABLE `users` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_users_email` (`email`),
    INDEX `idx_users_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `roles` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `description` VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_roles` (
    `user_id` BIGINT NOT NULL,
    `role_id` INT NOT NULL,
    PRIMARY KEY (`user_id`, `role_id`),
    CONSTRAINT `fk_ur_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_ur_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 2. MODULE B: STAKEHOLDER PROFILES
-- ------------------------------------------------------------------------------

CREATE TABLE `pet_owners` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20),
    `address` TEXT,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_pet_owners_phone` (`phone`),
    CONSTRAINT `fk_owner_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `veterinarians` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `specialization` VARCHAR(100),
    `license_number` VARCHAR(50) NOT NULL UNIQUE,
    `is_available` BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT `fk_vet_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `receptionists` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `employee_code` VARCHAR(30) NOT NULL UNIQUE,
    CONSTRAINT `fk_recep_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 3. MODULE C: PETS (PATIENTS)
-- ------------------------------------------------------------------------------

CREATE TABLE `pets` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `owner_id` BIGINT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `species` VARCHAR(50) NOT NULL,
    `breed` VARCHAR(100),
    `date_of_birth` DATE,
    `gender` VARCHAR(10) DEFAULT 'UNKNOWN',
    `weight` DECIMAL(5,2),
    `microchip_id` VARCHAR(50) UNIQUE,
    `known_allergies` TEXT,
    `photo_url` VARCHAR(500),
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_pets_owner` (`owner_id`),
    INDEX `idx_pets_species` (`species`),
    CONSTRAINT `fk_pet_owner` FOREIGN KEY (`owner_id`) REFERENCES `pet_owners` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 4. MODULE D: VET SCHEDULE & LEAVES (MODULE I)
-- ------------------------------------------------------------------------------

CREATE TABLE `vet_working_hours` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `vet_id` BIGINT NOT NULL,
    `day_of_week` VARCHAR(10) NOT NULL,
    `start_time` TIME NOT NULL,
    `end_time` TIME NOT NULL,
    `slot_duration_minutes` INT NOT NULL DEFAULT 30,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE KEY `uk_vet_day` (`vet_id`, `day_of_week`),
    CONSTRAINT `fk_vwh_vet` FOREIGN KEY (`vet_id`) REFERENCES `veterinarians` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vet_leaves` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `vet_id` BIGINT NOT NULL,
    `leave_type` VARCHAR(20) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `reason` TEXT,
    `status` VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    `approved_by` BIGINT NULL,
    INDEX `idx_leaves_dates` (`vet_id`, `start_date`, `end_date`),
    CONSTRAINT `fk_vl_vet` FOREIGN KEY (`vet_id`) REFERENCES `veterinarians` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_vl_approver` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 5. MODULE E: APPOINTMENTS
-- ------------------------------------------------------------------------------

CREATE TABLE `appointments` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `pet_id` BIGINT NOT NULL,
    `vet_id` BIGINT NOT NULL,
    `owner_id` BIGINT NOT NULL,
    `scheduled_at` DATETIME NOT NULL,
    `status` VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    `reason_for_visit` TEXT NOT NULL,
    `notes` TEXT,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_apt_vet_date` (`vet_id`, `scheduled_at`),
    INDEX `idx_apt_status` (`status`),
    INDEX `idx_apt_owner` (`owner_id`),
    CONSTRAINT `fk_apt_pet` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_apt_vet` FOREIGN KEY (`vet_id`) REFERENCES `veterinarians` (`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_apt_owner` FOREIGN KEY (`owner_id`) REFERENCES `pet_owners` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 6. MODULE F: MEDICAL RECORDS & DIAGNOSES (SOAP)
-- ------------------------------------------------------------------------------

CREATE TABLE `medical_records` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `appointment_id` BIGINT NOT NULL UNIQUE,
    `visit_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `subjective` TEXT,
    `objective` TEXT,
    `assessment` TEXT,
    `plan` TEXT,
    `weight_kg` DECIMAL(5,2),
    `temperature_celsius` DECIMAL(4,1),
    `heart_rate_bpm` INT,
    `respiratory_rate` INT,
    `additional_notes` TEXT,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_mr_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `diagnoses` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `medical_record_id` BIGINT NOT NULL,
    `diagnosis_name` VARCHAR(200) NOT NULL,
    `icd_code` VARCHAR(20),
    `severity` VARCHAR(20) DEFAULT 'MODERATE',
    `notes` TEXT,
    `is_primary` BOOLEAN NOT NULL DEFAULT FALSE,
    INDEX `idx_diag_mr` (`medical_record_id`),
    CONSTRAINT `fk_diag_mr` FOREIGN KEY (`medical_record_id`) REFERENCES `medical_records` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 7. MODULE G: MEDICINES, PRESCRIPTIONS & INVENTORY (MODULE K)
-- ------------------------------------------------------------------------------

CREATE TABLE `medicines` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL UNIQUE,
    `active_ingredient` VARCHAR(200),
    `dosage_form` VARCHAR(50),
    `unit` VARCHAR(30) NOT NULL,
    `unit_price` DECIMAL(10,2) NOT NULL CHECK (`unit_price` >= 0),
    `stock_quantity` INT NOT NULL DEFAULT 0,
    `min_stock_threshold` INT NOT NULL DEFAULT 10,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `expiry_date` DATE,
    `last_restocked_at` DATETIME,
    `supplier_name` VARCHAR(200),
    INDEX `idx_medicines_stock` (`stock_quantity`, `min_stock_threshold`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `prescriptions` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `medical_record_id` BIGINT NOT NULL UNIQUE,
    `issued_date` DATE NOT NULL,
    `expiry_date` DATE,
    `status` VARCHAR(30) NOT NULL DEFAULT 'PENDING_DISPENSING',
    `notes` TEXT,
    CONSTRAINT `fk_presc_mr` FOREIGN KEY (`medical_record_id`) REFERENCES `medical_records` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `prescription_items` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `prescription_id` BIGINT NOT NULL,
    `medicine_id` BIGINT NOT NULL,
    `dosage` VARCHAR(100) NOT NULL,
    `frequency` VARCHAR(100) NOT NULL,
    `duration_days` INT NOT NULL,
    `instructions` TEXT,
    `quantity` INT NOT NULL,
    INDEX `idx_pi_prescription` (`prescription_id`),
    CONSTRAINT `fk_pi_presc` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_pi_med` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `stock_transactions` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `medicine_id` BIGINT NOT NULL,
    `transaction_type` VARCHAR(30) NOT NULL,
    `quantity_change` INT NOT NULL,
    `quantity_after` INT NOT NULL,
    `reference_id` BIGINT NULL,
    `batch_number` VARCHAR(50),
    `expiry_date` DATE,
    `supplier_name` VARCHAR(200),
    `unit_cost` DECIMAL(10,2),
    `notes` TEXT,
    `performed_by` BIGINT NOT NULL,
    `transaction_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX `idx_st_med_date` (`medicine_id`, `transaction_date`),
    CONSTRAINT `fk_st_med` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_st_user` FOREIGN KEY (`performed_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 8. MODULE H: VACCINES & VACCINATIONS
-- ------------------------------------------------------------------------------

CREATE TABLE `vaccines` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL UNIQUE,
    `manufacturer` VARCHAR(200),
    `description` TEXT,
    `interval_days` INT,
    `target_species` VARCHAR(50) DEFAULT 'BOTH'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vaccinations` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `pet_id` BIGINT NOT NULL,
    `vaccine_id` BIGINT NOT NULL,
    `vet_id` BIGINT NOT NULL,
    `administered_date` DATE NOT NULL,
    `next_due_date` DATE,
    `batch_number` VARCHAR(50) NOT NULL,
    `notes` TEXT,
    `reminder_sent` BOOLEAN NOT NULL DEFAULT FALSE,
    INDEX `idx_vacc_pet` (`pet_id`),
    INDEX `idx_vacc_next_due` (`next_due_date`),
    CONSTRAINT `fk_vacc_pet` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_vacc_vaccine` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines` (`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_vacc_vet` FOREIGN KEY (`vet_id`) REFERENCES `veterinarians` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 9. MODULE I: CLINIC SERVICES & PRICE HISTORY (MODULE J)
-- ------------------------------------------------------------------------------

CREATE TABLE `services` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `category` VARCHAR(30) NOT NULL,
    `description` TEXT,
    `price` DECIMAL(10,2) NOT NULL CHECK (`price` >= 0),
    `duration_minutes` INT DEFAULT 30,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_services_cat` (`category`, `is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `service_price_history` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `service_id` BIGINT NOT NULL,
    `old_price` DECIMAL(10,2) NOT NULL,
    `new_price` DECIMAL(10,2) NOT NULL,
    `changed_by` BIGINT NOT NULL,
    `changed_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `fk_sph_service` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_sph_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 10. MODULE J: INVOICES & BILLING
-- ------------------------------------------------------------------------------

CREATE TABLE `invoices` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `appointment_id` BIGINT NOT NULL UNIQUE,
    `issued_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `subtotal` DECIMAL(12,2) NOT NULL DEFAULT 0,
    `tax` DECIMAL(12,2) NOT NULL DEFAULT 0,
    `total_amount` DECIMAL(12,2) NOT NULL DEFAULT 0,
    `amount_paid` DECIMAL(12,2) NOT NULL DEFAULT 0,
    `payment_status` VARCHAR(20) NOT NULL DEFAULT 'UNPAID',
    `payment_method` VARCHAR(30) NULL,
    `paid_at` DATETIME NULL,
    INDEX `idx_inv_status` (`payment_status`),
    CONSTRAINT `fk_inv_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `invoice_items` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `invoice_id` BIGINT NOT NULL,
    `description` VARCHAR(300) NOT NULL,
    `item_type` VARCHAR(20) NOT NULL,
    `quantity` INT NOT NULL DEFAULT 1,
    `unit_price` DECIMAL(10,2) NOT NULL,
    `subtotal` DECIMAL(10,2) NOT NULL,
    INDEX `idx_ii_invoice` (`invoice_id`),
    CONSTRAINT `fk_ii_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------------------
-- 11. MODULE K: NOTIFICATIONS
-- ------------------------------------------------------------------------------

CREATE TABLE `notifications` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL,
    `type` VARCHAR(30) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `message` TEXT NOT NULL,
    `scheduled_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `is_sent` BOOLEAN NOT NULL DEFAULT FALSE,
    `channel` VARCHAR(20) NOT NULL DEFAULT 'IN_APP',
    `sent_at` DATETIME NULL,
    INDEX `idx_noti_user_sent` (`user_id`, `is_sent`),
    CONSTRAINT `fk_noti_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

