require 'rails_helper'

describe MovieService do

  context 'instance methods' do
    context '#top_20_movies' do
      it 'returns the top 20 movies', :vcr do
        movies = MovieService.top_twenty_movies

        expect(movies).to be_an(Array)
        expect(movies.count).to eq(20)
        expect(movies.first).to have_key(:title)
        expect(movies.first).to have_key(:vote_average)
      end
    end
  end 
end