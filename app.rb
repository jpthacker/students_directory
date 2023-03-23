require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'

DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new
cohort = repo.find_with_students(2)
students = ""
cohort.students.each {|student| students << "#{student.id}. #{student.student_name} "}

puts "Cohort: #{cohort.cohort_name}, start date: #{cohort.start_date}, students: #{students}."
