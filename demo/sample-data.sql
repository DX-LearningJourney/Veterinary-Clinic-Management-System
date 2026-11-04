-- ==============================================================================
-- SAMPLE DATA SCRIPT: VetCare Pro
-- Veterinary Clinic Management System
-- Purpose: Realistic sample data for Demonstration & Testing
-- ==============================================================================

USE `vetcare_db`;

SET FOREIGN_KEY_CHECKS = 0;

-- Clean existing data
TRUNCATE TABLE `notifications`;
TRUNCATE TABLE `stock_transactions`;
TRUNCATE TABLE `service_price_history`;
TRUNCATE TABLE `invoice_items`;
TRUNCATE TABLE `invoices`;
TRUNCATE TABLE `prescription_items`;
TRUNCATE TABLE `prescriptions`;
TRUNCATE TABLE `diagnoses`;
TRUNCATE TABLE `medical_records`;
TRUNCATE TABLE `vaccinations`;
TRUNCATE TABLE `vaccines`;
TRUNCATE TABLE `medicines`;
TRUNCATE TABLE `services`;
TRUNCATE TABLE `vet_leaves`;
TRUNCATE TABLE `vet_working_hours`;
TRUNCATE TABLE `appointments`;
TRUNCATE TABLE `pets`;
TRUNCATE TABLE `receptionists`;
TRUNCATE TABLE `veterinarians`;
TRUNCATE TABLE `pet_owners`;
TRUNCATE TABLE `user_roles`;
TRUNCATE TABLE `roles`;
TRUNCATE TABLE `users`;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------------------
-- 1. ROLES
-- ------------------------------------------------------------------------------
INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'ROLE_ADMIN', 'System administrator with full permissions'),
(2, 'ROLE_VETERINARIAN', 'Doctor performing exams, diagnosis and prescriptions'),
(3, 'ROLE_RECEPTIONIST', 'Front-desk staff handling bookings, check-in and billing'),
(4, 'ROLE_PET_OWNER', 'Client who registers pets and schedules appointments');

-- ------------------------------------------------------------------------------
-- 2. USERS (bcrypt hash for password: "password123")
-- Hash: $2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m
-- ------------------------------------------------------------------------------
INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `is_active`) VALUES
(1, 'admin', 'admin@vetcare.clinic', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE),
(2, 'dr_minh', 'minh.tran@vetcare.clinic', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE),
(3, 'dr_linh', 'linh.le@vetcare.clinic', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE),
(4, 'recep_hoa', 'hoa.pham@vetcare.clinic', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE),
(5, 'owner_jane', 'jane.nguyen@gmail.com', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE),
(6, 'owner_david', 'david.tran@gmail.com', '$2a$10$7Q2V8p7O6Z3Jm1Q5u7m8ue0L5x/9K8w2r6o8m4c2p0v6k8q2r6o8m', TRUE);

-- Map User Roles
INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 1), -- Admin
(2, 2), -- Dr. Minh (Vet)
(3, 2), -- Dr. Linh (Vet)
(4, 3), -- Hoa (Receptionist)
(5, 4), -- Jane (Pet Owner)
(6, 4); -- David (Pet Owner)

-- ------------------------------------------------------------------------------
-- 3. PROFILES
-- ------------------------------------------------------------------------------
INSERT INTO `veterinarians` (`id`, `user_id`, `full_name`, `specialization`, `license_number`, `is_available`) VALUES
(1, 2, 'BS. Trần Văn Minh', 'Nội khoa & Thú nhỏ (Canine & Feline Internal Medicine)', 'VET-HCM-0192', TRUE),
(2, 3, 'BS. Lê Thị Khánh Linh', 'Phẫu thuật ngoại khoa & Da liễu (Surgery & Dermatology)', 'VET-HCM-0245', TRUE);

INSERT INTO `receptionists` (`id`, `user_id`, `full_name`, `employee_code`) VALUES
(1, 4, 'Phạm Quỳnh Hoa', 'EMP-REC-001');

INSERT INTO `pet_owners` (`id`, `user_id`, `full_name`, `phone`, `address`) VALUES
(1, 5, 'Nguyễn Thị Ngọc Jane', '0908123456', '123 Nguyễn Thị Minh Khai, P.6, Quận 3, TP.HCM'),
(2, 6, 'Trần Quốc David', '0919876543', '45 Lê Duẩn, P. Bến Nghé, Quận 1, TP.HCM'),
(3, 1, 'Admin Quản Trị', '0903000999', 'Hệ thống VetCare Pro');

-- ------------------------------------------------------------------------------
-- 4. VET WORKING HOURS (Module I)
-- ------------------------------------------------------------------------------
INSERT INTO `vet_working_hours` (`vet_id`, `day_of_week`, `start_time`, `end_time`, `slot_duration_minutes`, `is_active`) VALUES
(1, 'MON', '08:00:00', '17:00:00', 30, TRUE),
(1, 'TUE', '08:00:00', '17:00:00', 30, TRUE),
(1, 'WED', '08:00:00', '17:00:00', 30, TRUE),
(1, 'THU', '08:00:00', '17:00:00', 30, TRUE),
(1, 'FRI', '08:00:00', '17:00:00', 30, TRUE),
(1, 'SAT', '08:00:00', '12:00:00', 30, TRUE),
(2, 'MON', '09:00:00', '18:00:00', 30, TRUE),
(2, 'TUE', '09:00:00', '18:00:00', 30, TRUE),
(2, 'WED', '09:00:00', '18:00:00', 30, TRUE),
(2, 'THU', '09:00:00', '18:00:00', 30, TRUE),
(2, 'FRI', '09:00:00', '18:00:00', 30, TRUE),
(2, 'SAT', '13:00:00', '17:00:00', 30, TRUE);

-- ------------------------------------------------------------------------------
-- 5. PETS
-- ------------------------------------------------------------------------------
INSERT INTO `pets` (`id`, `owner_id`, `name`, `species`, `breed`, `date_of_birth`, `gender`, `weight`, `microchip_id`, `known_allergies`, `photo_url`) VALUES
(1, 1, 'Milo', 'Chó (Dog)', 'Golden Retriever', '2022-03-15', 'MALE', 28.50, 'MC-VN-908123', 'Dị ứng thuốc kháng sinh nhóm Penicillin', 'https://images.unsplash.com/photo-1552053831-71594a27632d'),
(2, 1, 'Luna', 'Mèo (Cat)', 'Persian (Mèo Ba Tư)', '2023-05-10', 'FEMALE', 4.20, 'MC-VN-908124', 'Không ghi nhận', 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba'),
(3, 2, 'Max', 'Chó (Dog)', 'Poodle Toy', '2021-08-20', 'MALE', 5.80, 'MC-VN-456789', 'Dị ứng hải sản, thức ăn hạt chứa bột tôm', 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee'),
(4, 2, 'Bella', 'Mèo (Cat)', 'British Shorthair (Mèo Anh Lông Ngắn)', '2023-11-01', 'FEMALE', 3.60, 'MC-VN-456790', 'Không ghi nhận', 'https://images.unsplash.com/photo-1573865526739-10659fec78a5'),
(5, 1, 'Kiki', 'Chó (Dog)', 'Corgi Pembroke', '2024-01-12', 'MALE', 9.50, 'MC-VN-908125', 'Không ghi nhận', 'https://images.unsplash.com/photo-1612536057832-2ff7ead58194');

-- ------------------------------------------------------------------------------
-- 6. SERVICES (Module J)
-- ------------------------------------------------------------------------------
INSERT INTO `services` (`id`, `name`, `category`, `description`, `price`, `duration_minutes`, `is_active`) VALUES
(1, 'Khám lâm sàng tổng quát', 'CONSULTATION', 'Kiểm tra toàn diện tim phổi, mắt, tai, răng miệng, thân nhiệt và cân nặng', 150000.00, 30, TRUE),
(2, 'Khám chuyên khoa da liễu / ngoại khoa', 'CONSULTATION', 'Khám chuyên sâu bệnh lý ngoài da hoặc chỉ định can thiệp ngoại khoa', 200000.00, 30, TRUE),
(3, 'Xét nghiệm công thức máu tổng quát (CBC)', 'LAB_TEST', 'Đánh giá số lượng bạch cầu, hồng cầu, tiểu cầu, dấu hiệu nhiễm trùng', 250000.00, 20, TRUE),
(4, 'Chụp X-quang kỹ thuật số (1 tư thế)', 'PROCEDURE', 'Chụp phim kiểm tra xương khớp hoặc lồng ngực/ổ bụng', 350000.00, 20, TRUE),
(5, 'Siêu âm ổ bụng màu tổng quát', 'PROCEDURE', 'Khảo sát gan, mật, thận, bàng quang, tử cung/tuyến tiền liệt', 300000.00, 30, TRUE),
(6, 'Công tiêm chủng & khám sàng lọc vaccine', 'VACCINATION_SERVICE', 'Bao gồm khám sàng lọc trước tiêm và lưu sổ theo dõi', 50000.00, 15, TRUE),
(7, 'Cắt móng, vệ sinh tai & vắt tuyến hôi', 'GROOMING', 'Chăm sóc vệ sinh cơ bản cho thú cưng', 100000.00, 30, TRUE),
(8, 'Lấy cao răng siêu âm & đánh bóng răng', 'PROCEDURE', 'Vệ sinh khoang miệng và ngừa viêm nướu, có gây mê an toàn', 800000.00, 60, TRUE);

-- ------------------------------------------------------------------------------
-- 7. VACCINES (Catalog)
-- ------------------------------------------------------------------------------
INSERT INTO `vaccines` (`id`, `name`, `manufacturer`, `description`, `interval_days`, `target_species`) VALUES
(1, 'Nobivac Rabies (Phòng dại)', 'MSD Animal Health', 'Vaccine phòng bệnh dại cho chó mèo từ 3 tháng tuổi', 365, 'BOTH'),
(2, 'Nobivac DHPPi (Vaccine 5 bệnh chó)', 'MSD Animal Health', 'Phòng Carred, Parvo, Viêm gan truyền nhiễm, Cúm, Phó cúm', 365, 'DOG'),
(3, 'Vanguard Plus 5/L (Vaccine 7 bệnh chó)', 'Zoetis', 'Phòng 5 virus và 2 chủng xoắn khuẩn Leptospira', 365, 'DOG'),
(4, 'Nobivac Tricat Trio (Vaccine 3 bệnh mèo)', 'MSD Animal Health', 'Phòng Giảm bạch cầu (Feline Panleukopenia), Viêm mũi khí quản, Calicivirus', 365, 'CAT'),
(5, 'Purevax FeLV (Phòng bạch cầu mèo)', 'Boehringer Ingelheim', 'Phòng virus ung thư bạch cầu ở mèo', 365, 'CAT'),
(6, 'Bordetella Bronchiseptica (Ho cũi chó)', 'Zoetis', 'Vaccine nhỏ mũi ngừa ho cũi chó truyền nhiễm', 180, 'DOG');

-- ------------------------------------------------------------------------------
-- 8. MEDICINES & INVENTORY (Module K)
-- ------------------------------------------------------------------------------
INSERT INTO `medicines` (`id`, `name`, `active_ingredient`, `dosage_form`, `unit`, `unit_price`, `stock_quantity`, `min_stock_threshold`, `is_active`, `expiry_date`, `supplier_name`) VALUES
(1, 'Amoxicillin 500mg', 'Amoxicillin Trihydrate', 'Viên nén', 'Viên', 12000.00, 150, 30, TRUE, '2026-12-31', 'Dược Thú Y Vemedim'),
(2, 'Clavamox 250mg', 'Amoxicillin + Clavulanic Acid', 'Viên nén', 'Viên', 28000.00, 65, 20, TRUE, '2026-10-15', 'Zoetis Vietnam'),
(3, 'Metronidazole 250mg', 'Metronidazole', 'Viên nén', 'Viên', 8000.00, 12, 20, TRUE, '2026-08-30', 'Pharbaco'), -- LOW STOCK
(4, 'Prednisolone 5mg', 'Prednisolone', 'Viên nén', 'Viên', 5000.00, 0, 15, TRUE, '2026-05-20', 'Sanofi'), -- OUT OF STOCK
(5, 'Meloxicam 0.5mg/ml Drop', 'Meloxicam', 'Dung dịch nhỏ giọt', 'Lọ 10ml', 185000.00, 25, 10, TRUE, '2027-01-10', 'Boehringer Ingelheim'),
(6, 'NexGard Spectra (7.5-15kg)', 'Afoxolaner + Milbemycin Oxime', 'Viên nhai', 'Hộp 3 viên', 450000.00, 30, 10, TRUE, '2027-04-15', 'Boehringer Ingelheim'),
(7, 'Revolution for Cats (2.6-7.5kg)', 'Selamectin', 'Ống nhỏ gáy', 'Ống', 220000.00, 40, 15, TRUE, '2027-06-30', 'Zoetis Vietnam'),
(8, 'Bravecto Chewable Dog (20-40kg)', 'Fluralaner', 'Viên nhai', 'Viên', 680000.00, 18, 5, TRUE, '2027-03-20', 'MSD Animal Health'),
(9, 'Nutri-Plus Gel', 'Vitamin & Khoáng chất cao đạm', 'Gel dinh dưỡng', 'Tuýp 120g', 210000.00, 50, 15, TRUE, '2026-11-25', 'Virbac'),
(10, 'Betadine Dung dịch sát trùng', 'Povidone Iodine 10%', 'Dung dịch', 'Chai 500ml', 95000.00, 8, 10, TRUE, '2026-09-15', 'Mundipharma'); -- LOW STOCK

-- ------------------------------------------------------------------------------
-- 9. APPOINTMENTS
-- ------------------------------------------------------------------------------
INSERT INTO `appointments` (`id`, `pet_id`, `vet_id`, `owner_id`, `scheduled_at`, `status`, `reason_for_visit`, `notes`) VALUES
(1, 1, 1, 1, '2026-11-04 09:00:00', 'COMPLETED', 'Khám định kỳ & kiểm tra mắt đỏ', 'Chủ quan sát thấy gãi mắt liên tục 2 ngày nay'),
(2, 2, 2, 1, '2026-11-04 10:30:00', 'COMPLETED', 'Tiêm nhắc vaccine 3 bệnh mèo & xổ giun', 'Mèo ăn ngủ bình thường, thân nhiệt ổn định'),
(3, 3, 1, 2, '2026-11-04 14:00:00', 'CHECKED_IN', 'Bỏ ăn, nôn bọt trắng sáng nay', 'Đã tiếp nhận tại quầy lễ tân, đang chờ gọi vào phòng khám 1'),
(4, 4, 2, 2, '2026-11-04 15:30:00', 'CONFIRMED', 'Kiểm tra nấm da vùng tai và cằm', 'Lịch hẹn đặt qua web, đã xác nhận qua điện thoại'),
(5, 5, 1, 1, '2026-11-05 09:30:00', 'PENDING', 'Tiêm phòng vaccine dại hàng năm', 'Lịch hẹn mới đăng ký, chờ lễ tân duyệt'),
(6, 1, 1, 1, '2026-10-20 08:30:00', 'CLOSED', 'Tái khám sau điều trị viêm da dị ứng', 'Hóa đơn đã thanh toán đầy đủ'),
(7, 3, 2, 2, '2026-10-25 11:00:00', 'CLOSED', 'Cắt tỉa móng và vệ sinh tai định kỳ', 'Thanh toán tiền mặt'),
(8, 2, 1, 1, '2026-10-28 16:00:00', 'CANCELLED', 'Khám tiêu hóa', 'Chủ bận việc đột xuất xin hủy trước 4 tiếng'),
(9, 4, 2, 2, '2026-11-06 10:00:00', 'CONFIRMED', 'Tái khám nấm da đợt 2', 'Bác sĩ Linh hẹn tái khám'),
(10, 5, 1, 1, '2026-11-07 14:30:00', 'PENDING', 'Tư vấn dinh dưỡng cho chó con', 'Chủ muốn chuyển loại hạt dinh dưỡng');

-- ------------------------------------------------------------------------------
-- 10. MEDICAL RECORDS & DIAGNOSES (SOAP)
-- ------------------------------------------------------------------------------
INSERT INTO `medical_records` (`id`, `appointment_id`, `visit_date`, `subjective`, `objective`, `assessment`, `plan`, `weight_kg`, `temperature_celsius`, `heart_rate_bpm`, `respiratory_rate`, `additional_notes`) VALUES
(1, 1, '2026-11-04 09:15:00', 
 'Chủ nuôi báo Milo hay dụi mắt phải vào chân, chảy gỉ mắt vàng 2 ngày nay, ăn uống vận động vẫn tốt.',
 'Mắt phải cương tụ kết mạc nhẹ, giác mạc trong suốt không xước (test Fluorescein âm tính), thân nhiệt 38.6°C, hạch ngoại biên không sưng.',
 'Viêm kết mạc mắt phải cấp tính (Acute conjunctivitis OD).',
 'Nhỏ mắt dung dịch kháng sinh chuyên dụng Tobramycin 0.3% ngày 3 lần. Đeo loa chống cào gãi. Tái khám sau 5 ngày nếu không giảm.',
 28.50, 38.6, 95, 24, 'Nhắc chủ cẩn trọng vì Milo có tiền sử dị ứng Penicillin'),

(2, 2, '2026-11-04 10:45:00',
 'Luna đi khám để tiêm phòng định kỳ hàng năm theo lịch hẹn hệ thống.',
 'Khám lâm sàng: Niêm mạc hồng hào, tim phổi đều, hạch lympho bình thường, nhiệt độ 38.4°C, lông da sạch không bọ chét.',
 'Thể trạng khỏe mạnh, đủ điều kiện tiêm phòng vaccine định kỳ.',
 'Tiêm dưới da 01 liều vaccine Nobivac Tricat Trio. Theo dõi phản ứng quá mẫn 30 phút tại phòng khám.',
 4.20, 38.4, 130, 28, 'Đã dán tem vaccine và ghi sổ điện tử');

INSERT INTO `diagnoses` (`id`, `medical_record_id`, `diagnosis_name`, `icd_code`, `severity`, `notes`, `is_primary`) VALUES
(1, 1, 'Viêm kết mạc mắt phải (Conjunctivitis)', 'H10.9', 'MILD', 'Mắt phải đỏ nhẹ, không tổn thương giác mạc sâu', TRUE),
(2, 2, 'Khám sức khỏe tổng quát tiêm phòng định kỳ', 'Z00.0', 'MILD', 'Đủ tiêu chuẩn tiêm chủng an toàn', TRUE);

-- ------------------------------------------------------------------------------
-- 11. PRESCRIPTIONS & PRESCRIPTION ITEMS
-- ------------------------------------------------------------------------------
INSERT INTO `prescriptions` (`id`, `medical_record_id`, `issued_date`, `expiry_date`, `status`, `notes`) VALUES
(1, 1, '2026-11-04', '2026-11-11', 'DISPENSED', 'Nhỏ mắt cách xa các thuốc khác 15 phút');

INSERT INTO `prescription_items` (`id`, `prescription_id`, `medicine_id`, `dosage`, `frequency`, `duration_days`, `instructions`, `quantity`) VALUES
(1, 1, 1, '1 viên (500mg)', '2 lần/ngày sau ăn', 5, 'Uống trực tiếp hoặc trộn thức ăn', 10),
(2, 1, 9, '3cm gel', '1 lần/ngày', 10, 'Bổ sung dinh dưỡng tăng sức đề kháng', 1);

-- ------------------------------------------------------------------------------
-- 12. VACCINATIONS
-- ------------------------------------------------------------------------------
INSERT INTO `vaccinations` (`id`, `pet_id`, `vaccine_id`, `vet_id`, `administered_date`, `next_due_date`, `batch_number`, `notes`, `reminder_sent`) VALUES
(1, 2, 4, 2, '2026-11-04', '2027-11-04', 'B-TRI-9923', 'Mèo tiêm Nobivac Tricat Trio êm, không phản ứng phụ', FALSE),
(2, 1, 1, 1, '2025-11-10', '2026-11-10', 'RAB-2024-01', 'Tiêm phòng dại mũi nhắc', TRUE),
(3, 1, 2, 1, '2025-12-05', '2026-12-05', 'DHPP-8871', 'Mũi nhắc 5 bệnh chó', FALSE),
(4, 3, 3, 2, '2026-02-15', '2027-02-15', 'VANG-1029', 'Vaccine 7 bệnh chó Vanguard', FALSE),
(5, 4, 4, 2, '2026-03-20', '2027-03-20', 'TRI-7761', 'Nobivac Tricat Trio', FALSE);

-- ------------------------------------------------------------------------------
-- 13. INVOICES & INVOICE ITEMS
-- ------------------------------------------------------------------------------
INSERT INTO `invoices` (`id`, `appointment_id`, `issued_at`, `subtotal`, `tax`, `total_amount`, `amount_paid`, `payment_status`, `payment_method`, `paid_at`) VALUES
(1, 1, '2026-11-04 09:40:00', 480000.00, 0.00, 480000.00, 480000.00, 'PAID', 'BANK_TRANSFER', '2026-11-04 09:42:15'),
(2, 2, '2026-11-04 11:00:00', 250000.00, 0.00, 250000.00, 250000.00, 'PAID', 'CASH', '2026-11-04 11:02:00'),
(3, 6, '2026-10-20 09:10:00', 150000.00, 0.00, 150000.00, 150000.00, 'PAID', 'CARD', '2026-10-20 09:12:00'),
(4, 7, '2026-10-25 11:30:00', 100000.00, 0.00, 100000.00, 100000.00, 'PAID', 'CASH', '2026-10-25 11:31:00');

INSERT INTO `invoice_items` (`id`, `invoice_id`, `description`, `item_type`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 'Khám lâm sàng tổng quát chuyên khoa', 'SERVICE', 1, 150000.00, 150000.00),
(2, 1, 'Amoxicillin 500mg (10 viên)', 'MEDICINE', 10, 12000.00, 120000.00),
(3, 1, 'Nutri-Plus Gel tuýp dinh dưỡng 120g', 'MEDICINE', 1, 210000.00, 210000.00),
(4, 2, 'Công tiêm chủng & khám sàng lọc vaccine', 'SERVICE', 1, 50000.00, 50000.00),
(5, 2, 'Vaccine Nobivac Tricat Trio phòng 3 bệnh mèo', 'MEDICINE', 1, 200000.00, 200000.00),
(6, 3, 'Khám lâm sàng tổng quát', 'SERVICE', 1, 150000.00, 150000.00),
(7, 4, 'Cắt móng, vệ sinh tai & vắt tuyến hôi', 'SERVICE', 1, 100000.00, 100000.00);

-- ------------------------------------------------------------------------------
-- 14. STOCK TRANSACTIONS (Module K)
-- ------------------------------------------------------------------------------
INSERT INTO `stock_transactions` (`id`, `medicine_id`, `transaction_type`, `quantity_change`, `quantity_after`, `reference_id`, `batch_number`, `expiry_date`, `supplier_name`, `unit_cost`, `notes`, `performed_by`) VALUES
(1, 1, 'STOCK_IN', 200, 200, NULL, 'LOT-AMX-2024', '2026-12-31', 'Dược Thú Y Vemedim', 9500.00, 'Nhập lô hàng kháng sinh quý 4', 1),
(2, 1, 'DISPENSED', -10, 190, 1, 'LOT-AMX-2024', '2026-12-31', NULL, NULL, 'Cấp phát theo đơn thuốc #1 cho pet Milo', 1);

-- ------------------------------------------------------------------------------
-- 15. NOTIFICATIONS
-- ------------------------------------------------------------------------------
INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `scheduled_at`, `is_sent`, `channel`, `sent_at`) VALUES
(1, 5, 'APPOINTMENT_REMINDER', 'Nhắc hẹn khám thú cưng Milo', 'Bạn có lịch hẹn khám cho bé Milo vào lúc 09:00 ngày 04/11/2026 tại VetCare Pro.', '2026-11-03 09:00:00', TRUE, 'EMAIL', '2026-11-03 09:00:05'),
(2, 5, 'VACCINATION_DUE', 'Nhắc lịch tiêm chủng vaccine Dại', 'Bé Milo sắp đến ngày tái chủng vaccine Dại (10/11/2026). Vui lòng đặt hẹn để bảo vệ bé yêu.', '2026-11-03 10:00:00', TRUE, 'IN_APP', '2026-11-03 10:00:02');

