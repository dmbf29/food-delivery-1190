class SessionsView
  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username} 👋"
  end
end
