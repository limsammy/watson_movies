class HomeController < ApplicationController
  require 'open-uri'
  require 'net/http'
  # require 'nokogiri'

  def index
  end

  def search
    @movies = []
    @query = params[:query]
    response = get_movies_data(@query)
    # @movies = response["results"]
    response["results"].each do |item|
      hash = {}
      hash[:image] = item["multimedia"]["src"]
      hash[:display_title] = item["display_title"]
      hash[:summary_short] = item["summary_short"]
      hash[:review] = get_reviews(item["link"]["url"])
      @movies << hash
    end
    @movies
    binding.pry
  end

  def get_movies_data(query)
    api_key = '678f3e381fea4927b1adc2344f5c2631'
    uri = URI("https://api.nytimes.com/svc/movies/v2/reviews/search.json?q=" + query + "&&api-key=#{api_key}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    @result = JSON.parse(http.request(request).body)
  end

  def get_reviews(url)
    reviews = []
    html_data = open(url).read
    page = Nokogiri::HTML(html_data, nil, 'utf-8')
    page.css('.story-body-text').each do |link|
      reviews << link.content
    end
    result = reviews.join("")
  end
end
