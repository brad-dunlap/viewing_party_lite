require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  describe 'As a user' do
    describe 'When I visit the discover movies page' do
      before do
        top_movies = File.read('spec/fixtures/top_movies.json')
        search_results = File.read('spec/fixtures/search_results.json')
        movie_details = File.read('spec/fixtures/movie_details.json')

        stub_request(:get, 'https://api.themoviedb.org/3/search/movie?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458&query=%7B:params=%3E%22godfather%22%7D')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.4'
          }
        )
        .to_return(status: 200, body: top_movies, headers: {})
        
        stub_request(:get, 'https://api.themoviedb.org/3/movie/top_rated?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.4'
          }
        )
        .to_return(status: 200, body: search_results, headers: {})
        
        stub_request(:get, 'https://api.themoviedb.org/3/search/movie?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458&query=godfather')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'Faraday v2.7.4'
          }
        )
        .to_return(status: 200, body: search_results, headers: {})
        
        stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v2.7.4'
            }).
            to_return(status: 200, body: movie_details, headers: {})
            
            cast_details = File.read('spec/fixtures/cast_details.json')   
            stub_request(:get, "https://api.themoviedb.org/3/movie/238/credits?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
            with(
              headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v2.7.4'
                }).
                to_return(status: 200, body: cast_details, headers: {})
                
                @bob = User.create!(name: 'Bob', email: 'bob@bob.com')
                
                visit "/users/#{@bob.id}/discover"
              end
              
      describe 'and click on the Top Movies button' do
        it 'shows the top 20 search results' do
          click_button 'Top Rated Movies'

          expect(current_path). to eq "/users/#{@bob.id}/movies"

          expect(page).to have_content('Top Rated Movies')

          expect(page).to have_content('The Godfather')
          expect(page).to have_content('Vote Average 8.7')

          click_link('The Godfather')

          expect(current_path). to eq("/users/#{@bob.id}/movies/238")
        end
      end

      describe 'and click on the Search Movies button' do
        it 'shows the top 20 search results' do
          fill_in :search, with: 'godfather'
          click_button 'Search Movies'

          expect(current_path). to eq "/users/#{@bob.id}/movies"

          expect(page).to have_content('Search Movies')

          expect(page).to have_content('The Godfather')
          expect(page).to have_content('Vote Average 8.7')

          click_link('The Godfather')

          expect(current_path). to eq("/users/#{@bob.id}/movies/238")
        end
      end

      describe 'Shows a Discover Movies button' do
        it 'I see a button to Discover Movies page' do
          click_button 'Top Rated Movies'

          expect(page).to have_button('Discover Movies')

          click_button 'Discover Movies'

          expect(page).to have_current_path("/users/#{@bob.id}/discover")
        end
      end
    end
  end
end
