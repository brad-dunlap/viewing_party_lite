# frozen_string_literal: true

class MovieService
  def top_twenty_movies
    response = conn.get('movie/top_rated')
    parsed = JSON.parse(response.body, symbolize_names: true)
    movies = parsed[:results].take(20)
    movies.map do |movie|
      new_movie = Movie.new(movie)
    end
  end

  def search_results(query)
    response = conn.get("search/movie?query=#{query}")
    parsed = JSON.parse(response.body, symbolize_names: true)
    movies = parsed[:results].take(20)
    movies.map do |movie|
      new_movie = Movie.new(movie)
    end
  end

  private

  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org/3/',
      params: { api_key: ENV['MOVIE_API_KEY'] }
    )
  end
end
