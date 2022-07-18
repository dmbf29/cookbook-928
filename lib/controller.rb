require_relative 'view'
require_relative 'recipe'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def import
    # tell view to ask user for keyword store in variable (keyword)
    keyword = @view.ask_for('ingredient')
    # scrape all_recipes for the keyword, return instances of recipes
    recipes = ScrapeAllrecipesService.new(keyword).call
    # gives those instances to the view to display
    @view.display(recipes)
    # tell view to ask user for number (index)
    index = @view.ask_for_index
    # recipe = get the recipe from the recipes array that the user chose
    recipe = recipes[index]
    # give the recipe to the cookbook/repository
    @cookbook.add_recipe(recipe)
  end

  def list
    display_all_recipes
  end

  def create
    # 1. Ask the user for the name of the recipe
    name = @view.ask_for('name')
    # 2. Ask the user for the description of the recipe
    description = @view.ask_for('description')
    prep_time = @view.ask_for('prep time')
    rating = @view.ask_for('rating')
    # 3. Create the recipe instance
    recipe = Recipe.new(
      name: name,
      description: description,
      prep_time: prep_time,
      rating: rating
    )
    # 4. Add the recipe to the cookbook
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 0. Display the recipes
    display_all_recipes
    # 1. Ask the user for the index of the recipe to destroy
    index = @view.ask_for_index
    # 2. Destroy the recipe from the cookbook
    @cookbook.remove_recipe(index)
  end

  def mark_as_done
    display_all_recipes
    index = @view.ask_for_index
    @cookbook.mark_as_done(index)
  end

  private

  def display_all_recipes
    # 1. Get the recipes from the cookbook
    recipes = @cookbook.all
    # 2. Display the recipes (ask the view)
    @view.display(recipes)
  end
end
