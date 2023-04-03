# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  describe 'As a user' do
    before do
      @bob = User.create!(name: 'Bob', email: 'bob@bob.com', password: "gsdhshf")

      visit user_discover_index_path(@bob)

      top_movies = File.read('spec/fixtures/top_movies.json')
    end

    describe 'When I visit the /users/:id/discover path' do
      it 'I see a button for top rated movies' do
        top_movies = File.read('spec/fixtures/top_movies.json')
        stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated')
          .with(query: hash_including(api_key: ENV['MOVIE_API_KEY']))
          .to_return(status: 200, body: top_movies, headers: {})
        expect(page).to have_button('Top Rated Movies')

        click_button 'Top Rated Movies'

        expect(current_path).to eq("/users/#{@bob.id}/movies")
      end

      it 'I see a text field to enter keyword(s) to search by movie title' do
        expect(page).to have_field(:search)
      end

      it 'I see a button to search by movie title' do
        expect(page).to have_button('Search Movies')

        search_results = File.read('spec/fixtures/search_results.json')
        stub_request(:get, 'https://api.themoviedb.org/3/search/movie?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458&query=')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Faraday v2.7.4'
            }
          )
          .to_return(status: 200, body: search_results, headers: {})

        click_button 'Search Movies'

        expect(current_path).to eq("/users/#{@bob.id}/movies")
      end
    end
  end
end
