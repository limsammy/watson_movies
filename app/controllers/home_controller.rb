class HomeController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
  end

  def search
    @query = params[:query]
    response = Tmdb::Search.movie(params[:query])
    @movies = response.results

    @movies.each do |movie|
      movie_id = movie.id
      api_key = 'c459015fc46ecb642c688063c8a6c14f'
      url = URI("https://api.themoviedb.org/3/movie/" + movie_id + "/reviews?page=1&language=en-US&api_key=" + api_key)

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request.body = "{}"

      @reviews = http.request(request)
      JSON.parse(@reviews.read_body)
      binding.pry
    end
  end
end
