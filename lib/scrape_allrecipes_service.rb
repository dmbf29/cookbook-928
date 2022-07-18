require 'nokogiri'
require 'open-uri'

class ScrapeAllrecipesService
  attr_reader :keyword

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{keyword}"
    html = URI.open(url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    # TODO: return a list of `Recipe` built from scraping the web.
    doc.search('.card__detailsContainer').first(5).map do |recipe_card|
      name = recipe_card.search('.card__title').text.strip
      description = recipe_card.search('.card__summary').text.strip
      rating = recipe_card.search('.review-star-text').text.strip.split[1]
      url = recipe_card.search('a').attribute('href').value
      prep_time = fetch_prep_time(url)
      # CREATE AN INSTANCE of a RECIPE
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
  end

  def fetch_prep_time(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML(html, nil, "utf-8")
    return doc.search('.recipe-meta-item-body').first.text.strip
  end
end

# we will call this method in the controller
# it should return an array of recipe instances
# ScrapeAllrecipesService.new('strawberry').call
