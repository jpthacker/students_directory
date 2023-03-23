require "cohort_repository"

def reset_cohorts_table
    seed_sql = File.read("spec/seeds_cohorts.sql")
    connection =
        PG.connect({ host: "127.0.0.1", dbname: "student_directory_2_test" })
    connection.exec(seed_sql)
end

RSpec.describe CohortRepository do
    before(:each) { reset_cohorts_table }

    it "returns a specific cohort with its students" do
        repo = CohortRepository.new
        cohort = repo.find_with_students(2)
        expect(cohort.id).to eq '2'
        expect(cohort.students.size).to eq 2
        expect(cohort.students.last.id).to eq '3'
    end
end