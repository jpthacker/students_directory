# Students Directory Design Recipe Template

## 1. User Stories

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

## 2. Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
| student                 | student_name, cohort_id
| cohort                | cohort_name, start_date

1. The first table (always plural): `students` 

    Column names: `student_name`, `cohort_id`

2. The second table (always plural): `cohorts` 

    Column names: `cohort_name`, `start_date`

## 3. The column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: students
id: SERIAL
student_name: text
cohort_id: int

Table: cohort
id: SERIAL
cohort_name: text
start_date: date
```

## 4. The SQL.

```sql
-- file: cohorts_table.sql

CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  cohort_name text,
  start_date date
);

-- file: students_table.sql
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  student_name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

```