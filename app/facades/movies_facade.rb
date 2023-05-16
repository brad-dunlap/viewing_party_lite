# frozen_string_literal: true

class MoviesFacade
  def initialize(movie_service = MovieService.new)
    @movie_service = movie_service
  end

  def top_twenty
    @movie_service.top_twenty_movies.map do |movie|
      Movie.new(movie)
    end
  end

  def search(query)
    @movie_service.search_results(query).map do |movie|
      Movie.new(movie)
    end
  end

  def movie_details(id)
    movie = @movie_service.movie_details(id)
    Movie.new(movie)
  end

  def cast_details(id)
    @movie_service.cast_details(id)
  end

  def reviews(id)
    @movie_service.reviews(id)
  end
end
