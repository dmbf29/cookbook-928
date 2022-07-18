require 'nokogiri'

class ScrapeAllrecipesService
  attr_reader :keyword

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    file = "lib/strawberry.html"
    # url = "https://www.allrecipes.com/search/results/?search=#{keyword}"
    doc = Nokogiri::HTML(File.open(file), nil, "utf-8")
    # TODO: return a list of `Recipe` built from scraping the web.
    doc.search('.card__detailsContainer').each do |recipe_card|
      p name = recipe_card.search('.card__title').text.strip
      # description =
      # CREATE AN INSTANCE of a RECIPE
    end
  end
end

# we will call this method in the controller
# it should return an array of recipe instances
ScrapeAllrecipesService.new('strawberry').call
