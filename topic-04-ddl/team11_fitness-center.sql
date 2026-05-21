BEGIN;

-- ==========================================
-- ENUMS (Custom Types)

CREATE TYPE membership_type AS ENUM ('monthly', 'yearly', 'premium');
CREATE TYPE weekday_enum AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
CREATE TYPE booking_status AS ENUM ('booked', 'cancelled', 'completed');
CREATE TYPE maintenance_status AS ENUM ('operational', 'in_maintenance', 'out_of_service');
CREATE TYPE location_area_type AS ENUM ('common_area', 'private_room', 'gym_floor');

-- ==========================================
-- MEMBERS MODULE

CREATE TABLE "members" (
  "member_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "phone_number" VARCHAR(30) UNIQUE,
  "birth_date" DATE,
  "join_date" DATE NOT NULL DEFAULT CURRENT_DATE,
  "membership_type" membership_type NOT NULL,
  "membership_start_date" DATE NOT NULL,
  "membership_end_date" DATE NOT NULL,
  CONSTRAINT check_membership_dates CHECK (membership_end_date > membership_start_date)
);

-- ==========================================
-- TRAINERS MODULE

CREATE TABLE "trainer_specializations" (
  "specialization_id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE "trainers" (
  "trainer_id" SERIAL PRIMARY KEY,
  "specialization_id" INT NOT NULL,
  "first_name" VARCHAR(30) NOT NULL,
  "last_name" VARCHAR(30) NOT NULL,
  "phone_number" VARCHAR(30) UNIQUE,
  "employed_date" DATE NOT NULL,
  "experience_years" INT NOT NULL, CHECK (experience_years >= 0),
  "is_active" BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE "trainer_schedules" (
  "trainer_schedule_id" SERIAL PRIMARY KEY,
  "trainer_id" INT NOT NULL,
  "weekday" weekday_enum NOT NULL,
  "shift_start" TIME NOT NULL,
  "shift_end" TIME NOT NULL,
  CONSTRAINT check_shift_times CHECK (shift_end > shift_start)
);

-- ==========================================
-- CLASSES AND PERSONAL TRAINING MODULE

CREATE TABLE "personal_training_sessions" (
  "session_id" SERIAL PRIMARY KEY,
  "member_id" INT NOT NULL,
  "trainer_id" INT NOT NULL,
  "location_id" INT,
  "start_time" TIMESTAMP NOT NULL,
  "duration_minutes" INT NOT NULL CHECK (duration_minutes > 0),
  "notes" TEXT
);

CREATE TABLE "class_types" (
  "class_type_id" SERIAL PRIMARY KEY,
  "type_name" VARCHAR(100) NOT NULL,
  "duration_minutes" INT NOT NULL CHECK (duration_minutes > 0)
);

CREATE TABLE "class_schedule" (
  "class_id" SERIAL PRIMARY KEY,
  "class_type_id" INT NOT NULL,
  "trainer_id" INT NOT NULL,
  "location_id" INT NOT NULL,
  "start_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL CHECK (end_time > start_time)
);

CREATE TABLE "class_bookings" (
  "booking_id" SERIAL PRIMARY KEY,
  "member_id" INT NOT NULL,
  "class_id" INT NOT NULL,
  "booking_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "status" booking_status NOT NULL DEFAULT 'booked'
);

-- ==========================================
-- EQUIPMENT MANAGEMENT MODULE

CREATE TABLE "equipment_inventory" (
  "equipment_id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50) NOT NULL,
  "stock" INT NOT NULL CHECK (stock >= 0),
  "purchase_date" DATE,
  "maintenance_status" maintenance_status NOT NULL DEFAULT 'operational'
);

CREATE TABLE "class_equipment" (
  "class_id" INT NOT NULL,
  "equipment_id" INT NOT NULL,
  "quantity" INT NOT NULL CHECK (quantity > 0),
  PRIMARY KEY ("class_id", "equipment_id")
);

-- ==========================================
-- LOCATIONS MODULE

CREATE TABLE "locations" (
  "location_id" SERIAL PRIMARY KEY,
  "name" VARCHAR(25) NOT NULL,
  "area_type" location_area_type NOT NULL
);

-- ==========================================
-- CLIENT PROGRESS TRACKING MODULE

CREATE TABLE "member_progress_tracking" (
  "progress_id" SERIAL PRIMARY KEY,
  "member_id" INT NOT NULL,
  "record_date" DATE NOT NULL DEFAULT CURRENT_DATE,
  "current_weight" NUMERIC(5,2),
  "current_body_fat" NUMERIC(5,2) CHECK (current_body_fat >= 0 AND current_body_fat <= 100),
  "body_type_id" INT,
  "strength_rating_id" INT,
  "attendance_score_id" INT,
  "personal_strength_rating" NUMERIC(5,2),
  "notes" TEXT,
  "created_at" TIMESTAMP DEFAULT now()
);

CREATE TABLE "body_physique_types" (
  "body_type_id" SERIAL PRIMARY KEY,
  "name" VARCHAR(100) NOT NULL,
  "body_fat_percentage_target" NUMERIC(5,2)
);

CREATE TABLE "strength_standard_levels" (
  "strength_rating_id" SERIAL PRIMARY KEY,
  "level_name" VARCHAR(50),
  "weight_to_lift_ratio" NUMERIC(5,2) NOT NULL
);

CREATE TABLE "attendance_achievement_scores" (
  "attendance_score_id" SERIAL PRIMARY KEY,
  "score_name" VARCHAR(10) NOT NULL,
  "min_days_in_row" INT NOT NULL CHECK (min_days_in_row >= 0)
);

-- ==========================================
-- RELATIONSHIPS (FOREIGN KEYS)

ALTER TABLE "trainers" ADD CONSTRAINT "fk_trainers_specialization" FOREIGN KEY ("specialization_id") REFERENCES "trainer_specializations" ("specialization_id");
ALTER TABLE "trainer_schedules" ADD CONSTRAINT "fk_trainer_schedule" FOREIGN KEY ("trainer_id") REFERENCES "trainers" ("trainer_id");
ALTER TABLE "personal_training_sessions" ADD CONSTRAINT "fk_personal_sessions_member" FOREIGN KEY ("member_id") REFERENCES "members" ("member_id");
ALTER TABLE "personal_training_sessions" ADD CONSTRAINT "fk_personal_sessions_trainer" FOREIGN KEY ("trainer_id") REFERENCES "trainers" ("trainer_id");
ALTER TABLE "personal_training_sessions" ADD CONSTRAINT "fk_personal_sessions_location" FOREIGN KEY ("location_id") REFERENCES "locations" ("location_id");
ALTER TABLE "class_schedule" ADD CONSTRAINT "fk_class_schedule_class_type" FOREIGN KEY ("class_type_id") REFERENCES "class_types" ("class_type_id");
ALTER TABLE "class_schedule" ADD CONSTRAINT "fk_class_schedule_trainer" FOREIGN KEY ("trainer_id") REFERENCES "trainers" ("trainer_id");
ALTER TABLE "class_schedule" ADD CONSTRAINT "fk_class_schedule_location" FOREIGN KEY ("location_id") REFERENCES "locations" ("location_id");
ALTER TABLE "class_bookings" ADD CONSTRAINT "fk_class_bookings_member" FOREIGN KEY ("member_id") REFERENCES "members" ("member_id");
ALTER TABLE "class_bookings" ADD CONSTRAINT "fk_class_bookings_class" FOREIGN KEY ("class_id") REFERENCES "class_schedule" ("class_id");
ALTER TABLE "class_equipment" ADD CONSTRAINT "fk_class_equipment_class" FOREIGN KEY ("class_id") REFERENCES "class_schedule" ("class_id");
ALTER TABLE "class_equipment" ADD CONSTRAINT "fk_class_equipment_equipment" FOREIGN KEY ("equipment_id") REFERENCES "equipment_inventory" ("equipment_id");
ALTER TABLE "member_progress_tracking" ADD CONSTRAINT "fk_progress_member" FOREIGN KEY ("member_id") REFERENCES "members" ("member_id");
ALTER TABLE "member_progress_tracking" ADD CONSTRAINT "fk_progress_body_type" FOREIGN KEY ("body_type_id") REFERENCES "body_physique_types" ("body_type_id");
ALTER TABLE "member_progress_tracking" ADD CONSTRAINT "fk_progress_strength_goal" FOREIGN KEY ("strength_rating_id") REFERENCES "strength_standard_levels" ("strength_rating_id");
ALTER TABLE "member_progress_tracking" ADD CONSTRAINT "fk_progress_attendance" FOREIGN KEY ("attendance_score_id") REFERENCES "attendance_achievement_scores" ("attendance_score_id");

-- ==========================================
-- INDEXES

-- Member Lookup Index (Last Name + Phone)
CREATE INDEX "idx_members_lookup" ON "members" ("last_name", "phone_number");

-- Equipment Lookup (Find all classes using specific equipment)
-- class_id is already indexed by the PK, so we only need equipment_id
CREATE INDEX "idx_fk_class_equipment_item" ON "class_equipment" ("equipment_id");

-- Progress Tracking FKs
CREATE INDEX "idx_fk_progress_member" ON "member_progress_tracking" ("member_id");
CREATE INDEX "idx_fk_progress_body_type" ON "member_progress_tracking" ("body_type_id");
CREATE INDEX "idx_fk_progress_strength" ON "member_progress_tracking" ("strength_rating_id");
CREATE INDEX "idx_fk_progress_attendance" ON "member_progress_tracking" ("attendance_score_id");

COMMIT;