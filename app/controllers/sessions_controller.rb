require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # username = tell the view to ask for username
    username = @sessions_view.ask_for('username')
    # password = tell the view to ask for password
    password = @sessions_view.ask_for('password')
    # employee = ask the employee repository for an employee with the username
    employee = @employee_repository.find_by_username(username)
    # check to see if the password of the employee matches the one given from the user
    # if employee&.password == password
    if employee && employee.password == password
      #  if it matches... have the view welcome them
      @sessions_view.welcome(employee)
      return employee
    else
      #  if it doesnt match... make them login again
      login
    end
  end
end
