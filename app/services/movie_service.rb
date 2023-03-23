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

  def movie_details(id)
    response = conn.get("movie/#{id}")
    parsed = JSON.parse(response.body, symbolize_names: true)
    x = Movie.new(parsed)
  end

  def cast_details(id)
    response = conn.get("movie/#{id}/credits")
    parsed = JSON.parse(response.body, symbolize_names: true)
    cast = parsed[:cast].take(10)
  end

	def reviews(id)
    response = conn.get("movie/#{id}/reviews")
    parsed = JSON.parse(response.body, symbolize_names: true)
    reviews = parsed[:results]
  end

  private

  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org/3/',
      params: { api_key: ENV['MOVIE_API_KEY'] }
    )
  end
end
