require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # get all the meals from the repository
    meals = @meal_repository.all
    # give the meals to the view for display
    @meals_view.display(meals)
  end

  def add
    # tell the view to ask for the name
    name = @meals_view.ask_for('name')
    # tell the view to ask for the price
    price = @meals_view.ask_for('price').to_i
    # create the instance of the meal
    meal = Meal.new(name: name, price: price)
    # give the instance to the meal_repository
    @meal_repository.create(meal)
  end
end
