class View
  def display(recipes) # an array of instances
    # puts '*' * 30
    puts 'Here are your recipes:'
    recipes.each_with_index do |recipe, index|
      x_mark = recipe.done? ? "X" : " "
      puts "#{index + 1}. [#{x_mark}] #{recipe.name} | #{recipe.description} | Rating: #{recipe.rating} | Prep: #{recipe.prep_time}"
    end
    # puts '*' * 30
  end

  def ask_for(attribute)
    puts "What is the #{attribute} of your recipe?"
    print '> '
    gets.chomp
  end

  def ask_for_index
    puts "Which recipe?"
    print '> '
    gets.chomp.to_i - 1
  end
end
