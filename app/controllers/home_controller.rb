class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  require 'open-uri'
  require 'net/http'

  def index
  end

  def search
    @movies = []
    @query = params[:query]
    response = get_movies_data(@query)
    response["results"].each do |item|
      hash = {}
      hash[:image] = item["multimedia"]["src"] unless item["multimedia"].nil?
      hash[:display_title] = item["display_title"]
      hash[:summary_short] = item["summary_short"]
      hash[:url] = item["link"]["url"]
      # hash[:review] = get_reviews(item["link"]["url"])
      @movies << hash
    end
    @movies
  end

  def get_movies_data(query)
    uri = URI("https://api.nytimes.com/svc/movies/v2/reviews/search.json")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    uri.query = URI.encode_www_form({
                                      "api-key" => "678f3e381fea4927b1adc2344f5c2631",
                                      "query" => query
    })
    request = Net::HTTP::Get.new(uri.request_uri)
    @result = JSON.parse(http.request(request).body)
  end

  # def get_reviews(url)
  #   reviews = []
  #   html_data = open(url).read
  #   page = Nokogiri::HTML(html_data, nil, 'utf-8')
  #   page.css('.story-body-text').each do |link|
  #     reviews << link.content
  #   end
  #   result = reviews.join("")
  # end
  def reviews
    reviews = []
    html_data = open(params[:url]).read
    page = Nokogiri::HTML(html_data, nil, 'utf-8')
    page.css('.story-body-text').each do |link|
      reviews << link.content
    end
    @result = reviews.join("")
    @analysis = Watson.new.get_data(reviews.join(""))
  end
end
