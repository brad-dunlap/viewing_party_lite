class MoviesFacade
	def top_twenty
		MovieService.new.top_twenty_movies.map do |movie|
			Movie.new(movie)
    end
	end

	def search(query)
		MovieService.new.search_results(query).map do |movie|
			Movie.new(movie)
		end
	end

	def movie_details(id)
		movie = MovieService.new.movie_details(id)
		Movie.new(movie)
	end

	def cast_details(id)
		MovieService.new.cast_details(id)
	end

	def reviews(id)
		MovieService.new.reviews(id)
	end
end