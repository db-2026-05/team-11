-- ================================================================
-- SQL DML TEMPLATE (TOPIC 09)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) INSERT scripts for all required tables in your database.
-- 2) At least 10 records per table with meaningful, realistic values.
-- 3) UPDATE / DELETE scripts where they are relevant to business logic.
-- 4) If UPDATE / DELETE are not relevant for a table, add a short note
--    in documentation explaining why.
-- 5) Comments by section so the script is easy to read and run.
--
-- SCRIPT GOALS:
-- - Populate the database with usable test data.
-- - Validate constraints through realistic DML scenarios.
-- - Support the core functionality of your application.
--
-- RECOMMENDED ORDER:
-- 1) Reference data (lookups/dictionaries)
-- 2) Core entities
-- 3) Transactional data
-- 4) Optional UPDATE / DELETE checks
--
-- IMPORTANT:
-- - Use anonymized or privacy-safe sample data where possible.
-- - The script must execute in PostgreSQL.
-- - Submit this as one SQL file.
-- ================================================================

-- Add your DML below this line


BEGIN;

-- =====================================================
-- Insertion scripts
-- =====================================================

-- trainer_specializations
INSERT INTO trainer_specializations (name) VALUES
('Strength Training'),('CrossFit'),('Yoga'),('Pilates'),('Bodybuilding'),
('Rehabilitation'),('Cardio Fitness'),('Powerlifting'),('Functional Training'),('Nutrition Coach');

-- body_physique_types
INSERT INTO body_physique_types (name, body_fat_percentage_target) VALUES
('Overweight',24),('Fit',20),('Athletic',15),('Shredded',10),('Extremely lean',5);

-- strength_standard_levels
INSERT INTO strength_standard_levels (level_name, weight_to_lift_ratio) VALUES
('50%',0.5),('75%',0.75),('100%',1.0),('125%',1.25),('150%',1.5),
('175%',1.75),('200%',2.0);

-- attendance_achievement_scores
INSERT INTO attendance_achievement_scores (score_name,min_days_in_row) VALUES
('Newbee',0),('Strong-starter',3),('Athlete in making',12),('Unstoppable force',24),('The Machine',48),
('The Loyalist',60),('Diamond biceps',72),('G.O.A.T.',90);

-- locations
INSERT INTO locations (name,area_type) VALUES
('Gym Floor A','gym_floor'),
('Gym Floor B','gym_floor'),
('Yoga Room','private_room'),
('Pilates Room','private_room'),
('Cardio Zone','gym_floor'),
('Stretch Area','common_area'),
('Studio 1','private_room'),
('Studio 2','private_room'),
('Studio 3','private_room'),
('Open sky terrasse','common_area');

-- class_types
INSERT INTO class_types (type_name,duration_minutes) VALUES
('Yoga Basics',60),('HIIT Blast',45),('Pilates Core',50),('Strength 101',60),('CrossFit Intro',45),
('Cardio Burn',30),('Functional Fitness',60),('Powerlifting',75),('Mobility Flow',45),('Advanced Yoga',75);

-- members
INSERT INTO members
(first_name,last_name,phone_number,birth_date,join_date,membership_type,membership_start_date,membership_end_date)
VALUES
('John','Miller','+380500000001','1990-01-01','2025-01-01','monthly','2025-01-01','2025-02-01'),
('Emma','Brown','+380500000002','1991-02-02','2025-01-02','premium','2025-01-02','2026-01-02'),
('Liam','Wilson','+380500000003','1992-03-03','2025-01-03','yearly','2025-01-03','2026-01-03'),
('Olivia','Taylor','+380500000004','1993-04-04','2025-01-04','monthly','2025-01-04','2025-02-04'),
('Noah','Davis','+380500000005','1994-05-05','2025-01-05','premium','2025-01-05','2026-01-05'),
('Sophia','Moore','+380500000006','1995-06-06','2025-01-06','yearly','2025-01-06','2026-01-06'),
('James','Clark','+380500000007','1996-07-07','2025-01-07','monthly','2025-01-07','2025-02-07'),
('Ava','Hall','+380500000008','1997-08-08','2025-01-08','premium','2025-01-08','2026-01-08'),
('Lucas','Allen','+380500000009','1998-09-09','2025-01-09','yearly','2025-01-09','2026-01-09'),
('Mia','Young','+380500000010','1999-10-10','2025-01-10','monthly','2025-01-10','2025-02-10');

-- trainers
INSERT INTO trainers
(specialization_id,first_name,last_name,phone_number,employed_date,experience_years,is_active)
VALUES
(1,'Mike','Johnson','+380670000001','2020-01-01',5,true),
(2,'Sarah','Lee','+380670000002','2019-01-01',6,true),
(3,'David','King','+380670000003','2018-01-01',7,true),
(4,'Anna','White','+380670000004','2021-01-01',4,true),
(5,'Chris','Green','+380670000005','2017-01-01',8,true),
(6,'Kate','Black','+380670000006','2022-01-01',3,true),
(7,'Mark','Stone','+380670000007','2016-01-01',9,true),
(8,'Julia','Hill','+380670000008','2015-01-01',10,true),
(9,'Peter','Wood','+380670000009','2020-06-01',5,true),
(10,'Linda','Scott','+380670000010','2021-06-01',4,true);

-- trainer_schedules
INSERT INTO trainer_schedules (trainer_id,weekday,shift_start,shift_end) VALUES
(1,'monday','08:00','16:00'),(2,'tuesday','08:00','16:00'),(3,'wednesday','08:00','16:00'),
(4,'thursday','08:00','16:00'),(5,'friday','08:00','16:00'),(6,'saturday','08:00','16:00'),
(7,'sunday','08:00','16:00'),(8,'monday','10:00','18:00'),(9,'tuesday','10:00','18:00'),
(10,'wednesday','10:00','18:00');

-- equipment_inventory
INSERT INTO equipment_inventory (name,stock,purchase_date,maintenance_status) VALUES
('Treadmill',5,'2024-01-01','operational'),
('Bike',8,'2024-01-02','operational'),
('Row Machine',4,'2024-01-03','operational'),
('Barbell',20,'2024-01-04','operational'),
('Dumbbell Set',15,'2024-01-05','operational'),
('Yoga Mat',30,'2024-01-06','operational'),
('Kettlebell',20,'2024-01-07','operational'),
('Bench',10,'2024-01-08','operational'),
('Resistance Band',40,'2024-01-09','operational'),
('Medicine Ball',12,'2024-01-10','operational');

-- class_schedule
INSERT INTO class_schedule (class_type_id,trainer_id,location_id,start_time,end_time) VALUES
(1,1,3,'2025-07-01 09:00','2025-07-01 10:00'),
(2,2,5,'2025-07-01 10:00','2025-07-01 10:45'),
(3,3,4,'2025-07-01 11:00','2025-07-01 11:50'),
(4,4,1,'2025-07-01 12:00','2025-07-01 13:00'),
(5,5,2,'2025-07-01 13:00','2025-07-01 13:45'),
(6,6,5,'2025-07-02 09:00','2025-07-02 09:30'),
(7,7,7,'2025-07-02 10:00','2025-07-02 11:00'),
(8,8,2,'2025-07-02 12:00','2025-07-02 13:15'),
(9,9,6,'2025-07-02 14:00','2025-07-02 14:45'),
(10,10,3,'2025-07-02 15:00','2025-07-02 16:15');

-- class_bookings
INSERT INTO class_bookings (member_id,class_id,status) VALUES
(1,1,'booked'),(2,1,'completed'),(3,1,'booked'),(4,1,'cancelled'),
(2,2,'booked'),(3,2,'completed'),(5,2,'booked'),(6,2,'booked'),
(1,3,'completed'),(4,3,'booked'),(7,3,'booked'),(8,3,'cancelled'),
(2,4,'booked'),(5,4,'completed'),(8,4,'booked'),(9,4,'booked'),
(1,5,'booked'),(3,5,'booked'),(6,5,'completed'),(10,5,'cancelled'),
(2,6,'booked'),(4,6,'booked'),(7,6,'completed'),(10,6,'booked'),
(1,7,'completed'),(5,7,'booked'),(8,7,'booked'),(9,7,'booked'),
(2,8,'booked'),(3,8,'completed'),(6,8,'booked'),(10,8,'booked'),
(1,9,'booked'),(4,9,'completed'),(7,9,'booked'),(8,9,'cancelled'),
(3,10,'booked'),(5,10,'completed'),(9,10,'booked'),(10,10,'booked');


-- personal_training_sessions
INSERT INTO personal_training_sessions
(member_id,trainer_id,location_id,start_time,duration_minutes,notes) VALUES
(1,1,1,'2025-07-03 09:00',60,'Strength'),
(2,2,2,'2025-07-03 10:00',60,'CrossFit'),
(3,3,3,'2025-07-03 11:00',60,'Yoga'),
(4,4,4,'2025-07-03 12:00',60,'Pilates'),
(5,5,5,'2025-07-03 13:00',60,'Bodybuilding'),
(6,6,6,'2025-07-03 14:00',60,'Rehab'),
(7,7,7,'2025-07-03 15:00',60,'Cardio'),
(8,8,8,'2025-07-03 16:00',60,'Powerlifting'),
(9,9,9,'2025-07-03 17:00',60,'Functional'),
(10,10,10,'2025-07-03 18:00',60,'Nutrition');

-- class_equipment
INSERT INTO class_equipment (class_id,equipment_id,quantity) VALUES
(1,6,10),(2,1,2),(3,6,8),(4,4,5),(5,7,5),
(6,2,3),(7,9,10),(8,4,8),(9,10,4),(10,6,12);

-- member_progress_tracking
INSERT INTO member_progress_tracking
(member_id,record_date,current_weight,current_body_fat,body_type_id,strength_rating_id,attendance_score_id,personal_strength_rating,notes)
VALUES
(1,'2025-07-01',80,24,1,2,2,0.75,'Started weight loss program'),
(2,'2025-07-01',75,20,2,3,4,1.00,'Consistent attendance'),
(3,'2025-07-01',82,15,3,4,5,1.25,'Improved deadlift technique'),
(4,'2025-07-01',68,10,4,5,3,1.40,'Preparing for competition'),
(5,'2025-07-01',71,5,5,7,8,2.50,'Advanced athlete'),
(6,'2025-07-01',92,24,1,1,1,0.50,'New member'),
(7,'2025-07-01',88,20,2,3,2,1.00,'Regular gym visits'),
(8,'2025-07-01',77,15,3,4,4,1.30,'Strength gains observed'),
(9,'2025-07-01',73,10,4,6,6,1.90,'Excellent progress'),
(10,'2025-07-01',69,20,2,2,5,0.90,'Improving consistency');

-- =====================================================
-- Update scripts
-- =====================================================

-- Member renews membership
UPDATE members
SET membership_end_date='2027-01-02'
WHERE member_id=2;

-- Trainer gains experience
UPDATE trainers
SET experience_years=experience_years+1
WHERE trainer_id=3;

-- Equipment maintenance lifecycle
UPDATE equipment_inventory
SET maintenance_status='in_maintenance'
WHERE equipment_id=2;

UPDATE equipment_inventory
SET maintenance_status='operational'
WHERE equipment_id=3;

-- Booking completed
UPDATE class_bookings
SET status='completed'
WHERE booking_id=12;

-- Schedule adjustment
UPDATE trainer_schedules
SET shift_start='09:00', shift_end='17:00'
WHERE trainer_schedule_id=4;

-- Progress reassessment
UPDATE member_progress_tracking
SET current_weight=78.5,
    current_body_fat=17.0
WHERE progress_id=1;

-- =====================================================
-- Deletion scripts
-- =====================================================

-- Delete a class booking
DELETE FROM class_bookings
WHERE booking_id=40;

-- Delete a personal training session
DELETE FROM personal_training_sessions
WHERE session_id=10;

-- Delete an equipment reservation from class
DELETE FROM class_equipment
WHERE class_id=5 AND equipment_id=7;

-- =========================================================
-- Constraint validations; Commented out - use when testing
-- =========================================================

-- INSERT INTO equipment_inventory(name,stock) VALUES ('Invalid Equipment',-1);
-- INSERT INTO class_bookings(member_id,class_id) VALUES (999,1);
-- INSERT INTO locations(name,area_type) VALUES ('Gym Floor A','gym_floor');
-- INSERT INTO members(first_name,last_name,membership_type,membership_start_date,membership_end_date)
-- VALUES ('Bad','Dates','monthly','2025-02-01','2025-01-01');

COMMIT;


-- =====================================================
-- FULL DATABASE CLEANUP (COMMENTED OUT)
-- =====================================================
-- DROP TABLE IF EXISTS member_progress_tracking CASCADE;
-- DROP TABLE IF EXISTS class_equipment CASCADE;
-- DROP TABLE IF EXISTS class_bookings CASCADE;
-- DROP TABLE IF EXISTS personal_training_sessions CASCADE;
-- DROP TABLE IF EXISTS class_schedule CASCADE;
-- DROP TABLE IF EXISTS class_types CASCADE;
-- DROP TABLE IF EXISTS equipment_inventory CASCADE;
-- DROP TABLE IF EXISTS trainer_schedules CASCADE;
-- DROP TABLE IF EXISTS trainers CASCADE;
-- DROP TABLE IF EXISTS trainer_specializations CASCADE;
-- DROP TABLE IF EXISTS members CASCADE;
-- DROP TABLE IF EXISTS attendance_achievement_scores CASCADE;
-- DROP TABLE IF EXISTS strength_standard_levels CASCADE;
-- DROP TABLE IF EXISTS body_physique_types CASCADE;
-- DROP TABLE IF EXISTS locations CASCADE;

-- DROP TYPE IF EXISTS membership_type CASCADE;
-- DROP TYPE IF EXISTS weekday_enum CASCADE;
-- DROP TYPE IF EXISTS booking_status CASCADE;
-- DROP TYPE IF EXISTS maintenance_status CASCADE;
-- DROP TYPE IF EXISTS location_area_type CASCADE;
