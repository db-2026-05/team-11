-- ================================================================
-- DATABASE ADMINISTRATION TEMPLATE (TOPIC 11)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE ROLE statements for at least 2 distinct roles.
--    Example roles: read-only analyst, read-write editor.
--
-- 2) GRANT statements assigning appropriate permissions to each role:
--    - Read-only role: GRANT SELECT ON ALL TABLES IN SCHEMA ...
--    - Read-write role: GRANT SELECT, INSERT, UPDATE, DELETE ...
--
-- 3) CREATE USER statements for at least 2 users.
--    Each user must be assigned to one of the defined roles.
--
-- 4) Comments before each section explaining the rationale:
--    - Why this role exists
--    - What access it should and should not have
--
-- RECOMMENDED ORDER:
-- 1) Roles + their GRANTs
-- 2) Users + GRANT ROLE TO USER
-- 3) Optional: REVOKE statements for fine-grained restrictions
-- 4) Optional cleanup block (commented out by default):
--    -- DROP USER ...; DROP ROLE ...;
--
-- IMPORTANT:
-- - Use explicit GRANT / REVOKE statements — do not rely on defaults.
-- - Roles must have meaningfully different permission levels.
-- - Script must execute in PostgreSQL without errors.
-- ================================================================

-- Add your script below this line
-- Section 1: Revoke Default

-- Remove public access to the database and schema before granting explicit permissions
REVOKE CONNECT ON DATABASE fitness_club_db FROM PUBLIC;
REVOKE CREATE ON SCHEMA public FROM PUBLIC;


-- Section 2: Create Roles

-- Three roles with different access levels: read-only, read-write, and admin
CREATE ROLE app_readonly;
CREATE ROLE app_readwrite;
CREATE ROLE app_admin;

-- Section 3: Database Connection

-- Allow each role to connect to the database
GRANT CONNECT ON DATABASE fitness_club_db TO app_readonly;
GRANT CONNECT ON DATABASE fitness_club_db TO app_readwrite;
GRANT CONNECT ON DATABASE fitness_club_db TO app_admin;

-- Section 4: Scheme-level Permission

-- Usage allows roles to see obejcts inside the scheme
-- Create is only needed by admin to create new tables
GRANT USAGE ON SCHEMA public TO app_readonly;
GRANT USAGE ON SCHEMA public TO app_readwrite;
GRANT USAGE ON SCHEMA public TO app_admin;

GRANT CREATE ON SCHEMA public TO app_admin;

-- Section 5: Table-Level Permission

-- app_readonly: Select only on all tables

GRANT SELECT ON
    members,
    trainer_specializations,
    trainer_schedules,
    trainers,
    personal_training_sessions,
    class_bookings,
    class_types,
    class_schedule,
    equipment_inventory,
    class_equipment,
    locations,
    member_progress_tracking,
    body_physique_types,
    strength_standard_levels,
    attendance_achievement_scores
TO app_readonly;


-- Apply SELECT to any future tables as well
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO app_readonly;

-- app_readwrite: full DML on all tables
GRANT SELECT, INSERT, UPDATE, DELETE ON
    members,
    trainer_specializations,
    trainer_schedules,
    trainers,
    personal_training_sessions,
    class_bookings,
    class_types,
    class_schedule,
    equipment_inventory,
    class_equipment,
    locations,
    member_progress_tracking,
    body_physique_types,
    strength_standard_levels,
    attendance_achievement_scores
TO app_readwrite;

-- Apply DML to any future tables as well
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_readwrite;

-- Sequences are required for SERIAL primary keys to work
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT USAGE, SELECT ON SEQUENCES TO app_readwrite;

-- app_admin: full access to all tables and sequences
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO app_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO app_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL PRIVILEGES ON TABLES TO app_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT ALL PRIVILEGES ON SEQUENCES TO app_admin;


-- SECTION 6: Revokes

-- Explicitly block write access for app_readonly even if granted elsewhere by mistake
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON
    members,
    trainer_specializations,
    trainer_schedules,
    trainers,
    personal_training_sessions,
    class_bookings,
    class_types,
    class_schedule,
    equipment_inventory,
    class_equipment,
    locations,
    member_progress_tracking,
    body_physique_types,
    strength_standard_levels,
    attendance_achievement_scores
FROM app_readonly;

-- TRUNCATE deletes all rows instantly with no rollback — block it for app_readwrite
REVOKE TRUNCATE ON
    members,
    class_bookings,
    member_progress_tracking,
    equipment_inventory
FROM app_readwrite;


-- SECTION 7: Create Users

-- Reporting user: read-only access, limited to 10 connections
CREATE USER who_are_you WITH
    PASSWORD '123'
    CONNECTION LIMIT 10;

GRANT app_readonly TO who_are_you;

-- Backend user: read-write access, limited to 30 connections
CREATE USER who_are_youX2 WITH
    PASSWORD '321'
    CONNECTION LIMIT 30;

-- Admin user: full access, can create other roles
GRANT app_readwrite TO who_are_youX2;

CREATE USER idk WITH
    PASSWORD '231'
    CREATEROLE;

GRANT app_admin TO idk;


-- SECTION 8: Cleanpu

-- Uncomment to remove all users and roles (use in test environment only)
/*
DROP USER IF EXISTS who_are_you;
DROP USER IF EXISTS who_are_youX2;
DROP USER IF EXISTS idk;

DROP ROLE IF EXISTS app_readonly;
DROP ROLE IF EXISTS app_readwrite;
DROP ROLE IF EXISTS app_admin;
*/

