class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    movie_service = MovieService.new
    @movies = movie_service.top_twenty_movies
  end

  def show
    
  end
end
