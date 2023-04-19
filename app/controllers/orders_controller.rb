require_relative '../views/employees_view'
require_relative '../views/orders_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
    @orders_view = OrdersView.new
  end

  def add
    # meals = get the meals from the meal repo
    # tell the meals view to display the meals
    # have the user choose the index of that meal
    # meal = get the meal from the meals array with the index
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meal = meals[index]

    # customers = get the customers from the customer repo
    # tell the customers view to display the customers
    # have the user choose the index of that customer
    # customer = get the customer from the customers array with the index
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customer = customers[index]


    # employees = get the riders from the employee repo
    # tell the employees view to display the employees
    # have the user choose the index of that employee
    # employee = get the employee from the employees array with the index
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    rider = employees[index]

    # we need create an instance of an order -> meal, customer, employee
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: rider
    )

    # give the order to the order repository
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # orders = ask the repository for our undelivered orders
    orders = @order_repository.undelivered_orders
    # display the orders
    @orders_view.display(orders)
  end

  def list_my_undelivered_orders(employee)
    # orders = ask the repository for undelivered orders
    orders = @order_repository.my_undelivered_orders(employee)
    # display the orders
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    # get the undelivered orders
    orders = @order_repository.my_undelivered_orders(employee)
    # diplay the orders
    @orders_view.display(orders)
    # index = ask the rider to choose one
    index = @orders_view.ask_for('number').to_i - 1
    # order = use the index to get one order from the orders
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
