class Router
  def initialize(meals_controller)
    @meals_controller = meals_controller
    @running = true
  end

  def run
    puts "Welcome to the Food Delivery!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    # when 1 then @controller.list
    # when 2 then @controller.add
    # when 3 then @controller.list
    # when 4 then @controller.add
    when 0 then stop
    else
      puts "Please press a correct number"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Add a new recipe"
    puts "3 - List all customers"
    puts "4 - Add a new customer"
    puts "0 - Stop and exit the program"
  end
end
