require_relative '../models/order'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  # order_repo.all
  def all
    @orders
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def find(id)
    @orders.find do |order|
      order.id == id
    end
  end

  def mark_as_delivered(order)
    # mark the order as delivered
    order.deliver!
    # save
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # we need to fix any non-string values-> id,\
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true'
      row[:meal_id] = row[:meal_id].to_i
      meal = @meal_repository.find(row[:meal_id])
      row[:meal] = meal

      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      # TODO
      order = Order.new(row)
      @orders << order
    end
    @next_id = @orders.any? ? @orders.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << Order.headers
      @orders.each do |order|
        # csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
        csv << order.build_row
      end
    end
  end
end
