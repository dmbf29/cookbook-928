require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @recipes = [] # stores instances of Recipe
    @csv_file_path = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    # get a recipe with the index
    recipe = @recipes[index]
    # mark that instance as done
    recipe.mark_as_done!
    # save the csv
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row
      # row is now acting like a hash
      # row is an array with the name and description of the recipe
      # hash[key] = new_value
      row[:done] = row[:done] == 'true'
      # row[:rating] = row[:rating].to_f
      @recipes << Recipe.new(row)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['name', 'description', 'rating', 'prep_time', 'done']
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
