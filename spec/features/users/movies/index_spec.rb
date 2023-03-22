require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  describe 'As a user' do
    describe 'When I visit the discover movies page' do

      before do

				stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
				with(query: hash_including(api_key: ENV['MOVIE_API_KEY'])).
				to_return(status: 200, body: '{"results":[]}', headers: {})


        @bob = User.create!(name: 'Bob', email: 'bob@bob.com')

        visit "/users/#{@bob.id}/movies"
      end

      describe 'and click on either the Top Movies button or the Search button,' do
        it 'I should be taken to the movies results page (users/:user_id/movies) where I see: title and vote' do
          expect(page).to have_content('Top Rated Movies')
          expect(page).to have_content('Search Movies')

          expect(page).to have_link("The Godfather")

          click_link("The Godfather")

          expect(current_path).to eq("/users/#{@bob.id}/movies/238")
        end
      end
    end
  end
end