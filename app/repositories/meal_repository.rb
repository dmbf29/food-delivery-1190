require_relative '../models/meal'
require 'csv'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  # meal_repo.all
  def all
    @meals
  end

  private

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # we need to fix any non-string values-> id, price
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      meal = Meal.new(row)
      @meals << meal
      # Meal.new({
      #   id: row[:id],
      #   name: row[:name],
      #   price: row[:price]
      # })
      # @next_id = meal.id + 1
    end
    @next_id = @meals.any? ? @meals.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      csv << Meal.headers
      @meals.each do |meal|
        # csv << [meal.id, meal.name, meal.price]
        csv << meal.build_row
      end
    end
  end
end
