require 'rails_helper'

describe MovieService do
  context 'instance methods' do
    describe '#top_20_movies' do
      it 'returns the top 20 movies' do
        top_movies = File.read('spec/fixtures/top_movies.json')

        stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: top_movies, headers: {})

        movies = MovieService.new.top_twenty_movies

        expect(movies).to be_an(Array)
        expect(movies.count).to eq(20)
        expect(movies.first.title).to eq('The Godfather')
        expect(movies.first.vote_average).to eq(8.7)
      end
    end
  end
end
