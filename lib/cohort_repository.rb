require_relative "cohort"
require_relative "student"

class CohortRepository
    def find_with_students(id)
        sql = '
        SELECT 
            cohorts.id,
            cohort_name,
            cohorts.start_date,
            students.id AS student_id,
            student_name
        FROM cohorts
        JOIN students ON students.cohort_id = cohorts.id
        WHERE cohorts.id = $1;'
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        cohort = Cohort.new
        cohort.id = result.first['id']
        cohort.cohort_name = result.first['cohort_name']
        cohort.start_date = result.first['start_date']

        result.each do |record|
            student = Student.new
            student.id = record['student_id']
            student.student_name = record['student_name']
            cohort.students << student
        end
        return cohort
    end
end