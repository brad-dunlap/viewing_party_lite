# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  describe 'As a user', :vcr do
    describe 'When I visit the discover movies page' do
      before do
        File.read('spec/fixtures/top_movies.json')
        File.read('spec/fixtures/search_results.json')
        File.read('spec/fixtures/movie_details.json')
        File.read('spec/fixtures/cast_details.json')
        File.read('spec/fixtures/reviews.json')

        @bob = User.create!(name: 'Bob', email: 'bob@bob.com', password: 'testing')

        visit '/dashboard/discover'
      end

      describe 'and click on the Top Movies button' do
        it 'shows the top 20 search results' do
          click_button 'Top Rated Movies'

          expect(page).to have_current_path('/dashboard/movies', ignore_query: true)

          expect(page).to have_content('Top Rated Movies')

          expect(page).to have_content('Vote Average 8.7')

          click_link('', href: '/dashboard/movies/238')

          expect(page).to have_current_path('/dashboard/movies/238', ignore_query: true)
        end
      end

      describe 'and click on the Search Movies button' do
        it 'shows the top 20 search results' do
          fill_in :search, with: 'godfather'
          click_button 'Search Movies'

          expect(page).to have_current_path('/dashboard/movies', ignore_query: true)

          expect(page).to have_content('Search Movies')

          expect(page).to have_content('Vote Average 8.7')

          click_link('', href: '/dashboard/movies/238')

          expect(page).to have_current_path('/dashboard/movies/238')
        end
      end

      describe 'Shows a Discover Movies button' do
        it 'I see a button to Discover Movies page' do
          click_button 'Top Rated Movies'

          expect(page).to have_button('Discover Movies')

          click_button 'Discover Movies'

          expect(page).to have_current_path('/dashboard/discover')
        end
      end
    end
  end
end
