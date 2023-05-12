# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Index Page' do
  describe 'As a user' do
    before do
      @bob = User.create!(name: 'Bob', email: 'bob@bob.com', password: 'password')
      visit login_path
      fill_in :email, with: @bob.email
      fill_in :password, with: @bob.password
      click_on "Log In"
      visit '/dashboard/discover'
    end

    describe 'When I visit the /users/:id/discover path' do
      it 'I see a button for top rated movies' do
        VCR.use_cassette('top_rated_movies') do
          expect(page).to have_button('Top Rated Movies')

          click_button 'Top Rated Movies'

          expect(current_path).to eq("/dashboard/movies")
        end
      end

      it 'I see a text field to enter keyword(s) to search by movie title' do
        expect(page).to have_field(:search)
      end

      it 'I see a button to search by movie title' do
        VCR.use_cassette('search_movies') do
          expect(page).to have_button('Search Movies')

          click_button 'Search Movies'

          expect(current_path).to eq("/dashboard/movies")
        end
      end
    end
  end
end
