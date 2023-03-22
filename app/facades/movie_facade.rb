class MovieFacade
 def self.top_movies 
   MovieService.top_twenty_movies[:results][0..19].map do |movie|
    Movie.new(movie)
   end
 end
end