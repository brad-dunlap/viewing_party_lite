class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
   

    if params[:top_rated]
      movie_service = MovieService.new
      @movies = movie_service.top_twenty_movies
    elsif params[:search]
      movie_service = MovieService.new
      @movies = movie_service.search_results(params[:search])
    end
  end

  def show
  
  end
end
