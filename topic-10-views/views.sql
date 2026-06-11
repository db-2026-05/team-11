-- ================================================================
-- SQL VIEWS TEMPLATE (TOPIC 10)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE VIEW scripts for required view types:
--    - Horizontal view (select specific columns)
--    - Vertical view (filter specific rows)
--    - Mixed view (columns + row filters)
--    - Join-based view (multiple tables)
--    - Subquery-based view
--    - UNION-based view
--    - View based on another view
--    - Updatable view with WITH CHECK OPTION
--
-- 2) Comments before each view explaining:
--    - Purpose of the view
--    - How it supports your project design
--
-- 3) Optional demo SELECT statements to show view output.
--
-- RECOMMENDED ORDER:
-- 1) Simple views (horizontal / vertical / mixed)
-- 2) Join and subquery views
-- 3) UNION and layered views
-- 4) CHECK OPTION view
--
-- IMPORTANT:
-- - Script must execute in PostgreSQL without errors.
-- - Keep naming consistent and readable.
-- - Submit all views in this single SQL file.
-- ================================================================

-- Add your CREATE VIEW statements below this line


-- TASK 1: HORIZONTAL VIEW
-- Author: Ihor Tsiupka
-- Shows only member names (hides sensitive data)

CREATE OR REPLACE VIEW view_members_names AS
SELECT
    first_name,
    last_name
FROM members;

-- SELECT * FROM view_members_names;


-- TASK 2: VERTICAL VIEW
-- Author: Ihor Tsiupka
-- Shows only members with active membership

CREATE OR REPLACE VIEW view_active_members AS
SELECT *
FROM members
WHERE membership_end_date >= CURRENT_DATE;

-- SELECT * FROM view_active_members;


-- TASK 3: MIXED VIEW
-- Author: Lisovyk Anastasia
-- Shows only premium members, only name and type columns

CREATE OR REPLACE VIEW view_premium_members AS
SELECT
    first_name,
    last_name,
    membership_type
FROM members
WHERE membership_type = 'premium';

-- SELECT * FROM view_premium_members;


-- TASK 4: JOIN-BASED VIEW
-- Author: Heiko Mykola
-- Shows class name, trainer name and start time

CREATE OR REPLACE VIEW view_class_timetable AS
SELECT
    ct.type_name                        AS class_name,
    t.first_name || ' ' || t.last_name  AS trainer_name,
    cs.start_time
FROM class_schedule cs
JOIN class_types ct ON ct.class_type_id = cs.class_type_id
JOIN trainers    t  ON t.trainer_id     = cs.trainer_id;

-- SELECT * FROM view_class_timetable;


-- TASK 5: SUBQUERY-BASED VIEW
-- Author: Heiko Mykola
-- Shows members who attended at least one completed class

CREATE OR REPLACE VIEW view_members_with_completed_classes AS
SELECT
    first_name,
    last_name
FROM members
WHERE member_id IN (
    SELECT member_id
    FROM class_bookings
    WHERE status = 'completed'
);

-- SELECT * FROM view_members_with_completed_classes;


-- TASK 6: UNION-BASED VIEW
-- Author: Mykhailo Lukianiuk
-- Combines group classes and personal training in one list

CREATE OR REPLACE VIEW view_all_activities AS
SELECT
    'Group Class'   AS activity_type,
    ct.type_name    AS title,
    cs.start_time,
    cs.class_id     AS resource_id
FROM class_schedule cs
JOIN class_types ct ON ct.class_type_id = cs.class_type_id

UNION ALL

SELECT
    'Personal Training'                                 AS activity_type,
    COALESCE(pts.notes, 'Personal Training Session')    AS title,
    pts.start_time,
    pts.session_id                                      AS resource_id
FROM personal_training_sessions pts;

-- SELECT * FROM view_all_activities ORDER BY start_time;


-- TASK 7: LAYERED VIEW (based on view_class_timetable)
-- Author: Mykhailo Lukianiuk
-- Shows only morning classes (before 12:00)

CREATE OR REPLACE VIEW view_morning_classes AS
SELECT *
FROM view_class_timetable
WHERE EXTRACT(HOUR FROM start_time AT TIME ZONE 'UTC') < 12;

-- SELECT * FROM view_morning_classes;


-- TASK 8: CHECK OPTION VIEW
-- Author: Lisovyk Anastasia
-- Only monthly members; blocks insert/update of other types

CREATE OR REPLACE VIEW view_monthly_members AS
SELECT
    member_id,
    first_name,
    last_name,
    membership_type,
    membership_end_date
FROM members
WHERE membership_type = 'monthly'
WITH CHECK OPTION;

-- SELECT * FROM view_monthly_members;

-- This UPDATE should FAIL (violates check option):
-- UPDATE view_monthly_members SET membership_type = 'yearly' WHERE member_id = 1;

-- This INSERT should FAIL (membership_type != 'monthly'):
-- INSERT INTO view_monthly_members (member_id, first_name, last_name, membership_type, membership_end_date)
-- VALUES (999, 'Test', 'User', 'yearly', '2026-06-10');