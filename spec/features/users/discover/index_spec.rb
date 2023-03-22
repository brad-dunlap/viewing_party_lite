# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  describe 'As a user' do
    before do
      stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated')
        .with(query: hash_including(api_key: ENV['MOVIE_API_KEY']))
        .to_return(status: 200, body: '{"results":[]}', headers: {})

      @bob = User.create!(name: 'Bob', email: 'bob@bob.com')

      visit user_discover_index_path(@bob)

      top_movies = File.read('spec/fixtures/top_movies.json')
    end

    describe 'When I visit the /users/:id/discover path' do
      it 'I see a button for top rated movies' do
        expect(page).to have_button('Top Rated Movies')

        click_button 'Top Rated Movies'

        expect(current_path).to eq("/users/#{@bob.id}/movies")
      end

      it 'I see a text field to enter keyword(s) to search by movie title' do
        expect(page).to have_field(:search)
      end

      it 'I see a button to search by movie title' do
        expect(page).to have_button('Find Movies')

        click_button 'Find Movies'

        expect(current_path).to eq("/users/#{@bob.id}/movies")
      end
    end
  end
end
