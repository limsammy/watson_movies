class HomeController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
  end

  def search
    @query = params[:query]
    response = Tmdb::Search.movie(params[:query])
    @movies = response.results
  end
end
