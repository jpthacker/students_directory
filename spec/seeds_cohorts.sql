TRUNCATE TABLE students, cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (cohort_name, start_date) VALUES ('February Coders', TO_DATE('2023-2-20', 'yyyy-mm-dd'));
INSERT INTO cohorts (cohort_name, start_date) VALUES ('March Coders', TO_DATE('2023-3-13', 'yyyy-mm-dd'));

INSERT INTO students (student_name, cohort_id) VALUES ('David', '1');
INSERT INTO students (student_name, cohort_id) VALUES ('Anna', '2');
INSERT INTO students (student_name, cohort_id) VALUES ('Josh', '2');