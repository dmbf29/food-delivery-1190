require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get all the customers from the repository
    customers = @customer_repository.all
    # give the customers to the view for display
    @customers_view.display(customers)
  end

  def add
    # tell the view to ask for the name
    name = @customers_view.ask_for('name')
    # tell the view to ask for the address
    address = @customers_view.ask_for('address')
    # create the instance of the customer
    customer = Customer.new(name: name, address: address)
    # give the instance to the customer_repository
    @customer_repository.create(customer)
  end
end
