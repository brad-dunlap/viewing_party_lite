# frozen_string_literal: true

class MovieService
  def top_twenty_movies
    response = conn.get('movie/top_rated')
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results].take(20)
  end

  def search_results(query)
    response = conn.get("search/movie?query=#{query}")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results].take(20)
  end

  def movie_details(id)
    response = conn.get("movie/#{id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def cast_details(id)
    response = conn.get("movie/#{id}/credits")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:cast].take(10)
  end

  def reviews(id)
    response = conn.get("movie/#{id}/reviews")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results]
  end

  private

  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org/3/',
      params: { api_key: ENV['MOVIE_API_KEY'] }
    )
  end
end
