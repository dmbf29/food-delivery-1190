class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    puts "Welcome to the Food Delivery!"
    puts "           --           "

    while @running
      @employee = @sessions_controller.login
      while @employee
        if @employee.manager?
          # manager actions
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          # rider actions
          display_rider_tasks
          action = gets.chomp.to_i
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 9 then logout
    when 0 then stop
    else
      puts "Please press a correct number"
    end
  end

  def route_rider_action(action)
    case action
    when 1 then @orders_controller.list_my_undelivered_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 9 then logout
    when 0 then stop
    else
      puts "Please press a correct number"
    end
  end

  def logout
    @employee = nil
  end

  def stop
    logout
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Add a new meal"
    puts "3 - List all customers"
    puts "4 - Add a new customer"
    puts "5 - Add a new order"
    puts "6 - List all undelivered orders"
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end

  def display_rider_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List my undelivered orders"
    puts "2 - Mark an order as delivered"
    puts "9 - Sign out"
    puts "0 - Stop and exit the program"
  end
end
