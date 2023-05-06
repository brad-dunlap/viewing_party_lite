require 'rails_helper'

describe MoviesFacade do
  let(:movie_service) { instance_double(MovieService) }
  let(:movies_facade) { MoviesFacade.new }

  describe '#top_twenty' do
    it 'returns an array of top twenty movies' do
      top_twenty_movies = [
        { id: 1, title: 'Movie 1', vote_average: 8.0, runtime: 120, genres: ['Action', 'Adventure'], overview: 'A great movie', poster_path: 'https://image.tmdb.org/t/p/w500/abc.jpg' },
        { id: 2, title: 'Movie 2', vote_average: 7.5, runtime: 110, genres: ['Comedy', 'Drama'], overview: 'A funny movie', poster_path: 'https://image.tmdb.org/t/p/w500/def.jpg' }
      ]
      allow(movie_service).to receive(:top_twenty_movies).and_return(top_twenty_movies)
      allow(MovieService).to receive(:new).and_return(movie_service)

      result = movies_facade.top_twenty

      expect(result.length).to eq(2)

      expect(result[0].title).to eq('Movie 1')
      expect(result[0].vote_average).to eq(8.0)
      expect(result[0].runtime).to eq(120)
      expect(result[0].genres).to eq(['Action', 'Adventure'])
      expect(result[0].overview).to eq('A great movie')
      expect(result[0].poster_path).to eq('https://image.tmdb.org/t/p/w500/abc.jpg')

      expect(result[1].title).to eq('Movie 2')
      expect(result[1].vote_average).to eq(7.5)
      expect(result[1].runtime).to eq(110)
      expect(result[1].genres).to eq(['Comedy', 'Drama'])
      expect(result[1].overview).to eq('A funny movie')
      expect(result[1].poster_path).to eq('https://image.tmdb.org/t/p/w500/def.jpg')
    end
  end

	describe '#search' do
		let(:query) { 'Star Wars' }

		it 'returns an array of movies matching the search query' do
			search_results = [
				{ id: 1, title: 'Star Wars: Episode IV - A New Hope', vote_average: 8.7, runtime: 121, genres: ['Action', 'Adventure', 'Fantasy', 'Science Fiction'], overview: 'The classic adventure of Luke Skywalker', poster_path: '/starwars1.jpg' },
				{ id: 2, title: 'Star Wars: Episode V - The Empire Strikes Back', vote_average: 8.8, runtime: 124, genres: ['Action', 'Adventure', 'Fantasy', 'Science Fiction'], overview: 'The rebels fight back against the empire', poster_path: '/starwars2.jpg' }
			]
			allow(movie_service).to receive(:search_results).with(query).and_return(search_results)
			allow(MovieService).to receive(:new).and_return(movie_service)

			movies = movies_facade.search(query)

			expect(movies.size).to eq(2)
			expect(movies.first).to be_a(Movie)
			expect(movies.first.id).to eq(1)
			expect(movies.first.title).to eq('Star Wars: Episode IV - A New Hope')
			expect(movies.first.vote_average).to eq(8.7)
			expect(movies.first.runtime).to eq(121)
			expect(movies.first.genres).to eq(['Action', 'Adventure', 'Fantasy', 'Science Fiction'])
			expect(movies.first.overview).to eq('The classic adventure of Luke Skywalker')
			expect(movies.first.poster_path).to eq('/starwars1.jpg')
		end
	end

	describe '#cast_details' do
		it 'returns cast details' do
			cast_data = [{ id: 1, name: 'Actor 1', character: 'Character 1' }, { id: 2, name: 'Actor 2', character: 'Character 2' }]
			expected_cast = cast_data

			allow(movie_service).to receive(:cast_details).with(1).and_return(cast_data)
			allow(MovieService).to receive(:new).and_return(movie_service)

			expect(movies_facade.cast_details(1)).to eq(expected_cast)
		end
	end

	describe '#reviews' do
		it 'returns reviews' do
			review_data = [{ author: 'Reviewer 1', content: 'Review 1' }, { author: 'Reviewer 2', content: 'Review 2' }]
			expected_reviews = review_data

			allow(movie_service).to receive(:reviews).with(1).and_return(review_data)
			allow(MovieService).to receive(:new).and_return(movie_service)

			expect(movies_facade.reviews(1)).to eq(expected_reviews)
		end
	end
end

  