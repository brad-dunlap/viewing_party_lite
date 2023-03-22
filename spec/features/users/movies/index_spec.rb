require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  describe 'As a user' do
    describe 'When I visit the discover movies page' do
      before do
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

        @bob = User.create!(name: 'Bob', email: 'bob@bob.com')

        visit "/users/#{@bob.id}/discover"
				click_button "Top Rated Movies"
				save_and_open_page
      end

      describe 'and click on either the Top Movies button or the Search button,' do
				it "shows the search results" do	
				
					expect(current_path).to eq "/users/#{@bob.id}/movies"

					expect(page).to have_content('Top Rated Movies')
					expect(page).to have_content('Search Movies')

					expect(page).to have_content('The Godfather')

					click_link('The Godfather')

					expect(page).to have_current_path("/users/#{@bob.id}/movies/238")
				end
      end
    end
  end
end
