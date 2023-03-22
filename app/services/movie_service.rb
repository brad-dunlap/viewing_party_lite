class MovieService
  def top_twenty_movies
    response = conn.get('movie/top_rated')
    parsed = JSON.parse(response.body, symbolize_names: true)
    movies = parsed[:results].take(20)
		# x = []
		x= movies.map do |movie|
			new_movie = Movie.new(movie)
			# x << new_movie
		end
		# x
    # movies.each do |movie|
    #   array << Movie.new({
    #     title: movie[:title],
    #     vote_average: movie[:vote_average]
    #   })
    # end
	end

  private

  def conn
    Faraday.new(
      url: 'https://api.themoviedb.org/3/',
      params: { api_key: ENV['MOVIE_API_KEY'] }
    )
  end
end
