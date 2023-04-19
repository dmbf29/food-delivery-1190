class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # instance of a meal
    @customer = attributes[:customer] # instance of a customer
    @employee = attributes[:employee] # instance of a employee (rider)
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end

  def build_row
    [@id, @meal.id, @customer.id, @employee.id, delivered?]
  end

  def self.headers
    ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
  end

end
