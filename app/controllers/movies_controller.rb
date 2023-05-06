# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = current_user

    if params[:top_rated]
      @movies = MoviesFacade.new.top_twenty
    elsif params[:search]
      @movies = MoviesFacade.new.search(params[:search])
    end
  end

  def show
    @user = current_user
    @movie = MoviesFacade.new.movie_details(params[:id])
    @cast = MoviesFacade.new.cast_details(params[:id])
    @reviews = MoviesFacade.new.reviews(params[:id])
  end
end
