# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: cohorts

Columns:
id | cohort_name | start_date
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE students, cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (cohort_name, start_date) VALUES ('February Coders', TO_DATE('2023-2-20', 'yyyy-mm-dd'));
INSERT INTO cohorts (cohort_name, start_date) VALUES ('March Coders', TO_DATE('2023-3-13', 'yyyy-mm-dd'));

INSERT INTO students (student_name, cohort_id) VALUES ('David', '1');
INSERT INTO students (student_name, cohort_id) VALUES ('Anna', '2');
INSERT INTO students (student_name, cohort_id) VALUES ('Josh', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. The Classes

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: students

# (in lib/student.rb)
class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_name
end

# Table name: cohorts

# (in lib/cohort.rb)
class Cohort
    attr_accessor :id, :name, :cohort_name

    def initialize
        @students = []
    end
end

# Repository class
# (in lib/cohort_repository.rb)

class CohortRepository

  # Gets a single record and associated records by its ID
  # One argument: the id (number)
  def find_with_students(id)
    # Executes the SQL query:
    #   SELECT 
    #     cohorts.id,
    #     cohort_name,
    #     cohorts.start_date,
    #     students.id AS student_id,
    #     student_name, 
    #   FROM cohorts WHERE id = $1;
    #   JOIN students ON students.cohort_id = cohorts.id
    #   WHERE cohorts.id = $1;

    # Returns a single Cohort object containing an array of Student objects.
  end
end
```

## 4. Test Example

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
repo = CohortRepository.new

# Perfoms a SELECT with a JOIN and returns an Artist object.
# This object also has an attribute .albums, which is an array
# of Album objects.
cohort = repository.find_with_students(2)

cohort.id # => 2

cohort.students.size # => 2
cohort.students.last.id # 3
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_cohorts_table
  seed_sql = File.read('spec/seeds_cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

RSpec.describe CohortRepository do
  before(:each) do 
    reset_cohorts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour
