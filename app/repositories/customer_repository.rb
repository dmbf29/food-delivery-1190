require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  # customer_repo.all
  def all
    @customers
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # we need to fix any non-string values-> id, price
      row[:id] = row[:id].to_i
      customer = Customer.new(row)
      @customers << customer
      # Customer.new({
      #   id: row[:id],
      #   name: row[:name],
      #   address: row[:address]
      # })
      # @next_id = customer.id + 1
    end
    @next_id = @customers.any? ? @customers.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << Customer.headers
      @customers.each do |customer|
        # csv << [customer.id, customer.name, customer.address]
        csv << customer.build_row
      end
    end
  end
end
