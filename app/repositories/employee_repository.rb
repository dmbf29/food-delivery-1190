require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    load_csv if File.exist?(@csv_file)
  end

  # employee_repo.all
  def all
    @employees
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # we need to fix any non-string values-> id
      row[:id] = row[:id].to_i
      employee = Employee.new(row)
      @employees << employee
    end
  end
end
