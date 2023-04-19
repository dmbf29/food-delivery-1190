class OrdersView

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def display(orders)
    if orders.any?
      orders.each_with_index do |order, index|
        puts "#{index + 1}.)
        Meal:
        #{order.meal.name} -
        Customer:
        #{order.customer.name} - #{order.customer.address} -
        Employee:
        #{order.employee.username}"
        puts '-------'
      end
    else
      puts "No orders yet 🍽"
    end
  end
end


# view.ask_for('name')
# view.ask_for('price')
