class Recipe
  attr_reader :name, :description, :prep_time, :rating

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @rating = attributes[:rating]
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end

# p Recipe.new
# p Recipe.new(done: true)
# p Recipe.new(done: false)

# p Recipe.new(
#   description: 'dough with sauce',
#   name: 'pizza'
# )

# p Recipe.new('name', 'desc', 'rating', true, 'prep')
# User.new()
