class HomeController < ApplicationController

  def index
  end

  def search
    @query = params[:query]
    response = Tmdb::Search.movie(params[:query])
    @movies = response.results
  end
end
