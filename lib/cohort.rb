class Cohort
    attr_accessor :id, :cohort_name, :start_date, :students

    def initialize
        @students = []
    end
end