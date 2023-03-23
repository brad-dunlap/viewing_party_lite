require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  describe 'As a user' do

    before :each do
      movie_details = File.read('spec/fixtures/movie_details.json')
      cast_details = File.read('spec/fixtures/cast_details.json')
			reviews = File.read('spec/fixtures/reviews.json')
        
      stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: movie_details, headers: {})

        stub_request(:get, "https://api.themoviedb.org/3/movie/278/credits?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: cast_details, headers: {})

				 stub_request(:get, "https://api.themoviedb.org/3/movie/278/reviews?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: reviews, headers: {})

      @bob = User.create!(name: 'Bob', email: 'bob@bob.com')

      visit "/users/#{@bob.id}/movies/278"
    end

    describe 'When I visit a movie show page' do
      it 'I see the movie title' do
        expect(page).to have_content('The Shawshank Redemption')
      end

      it 'I see the vote average for the movie' do
        expect(page).to have_content('Vote Average: 8.7')
      end

      it 'I see the movies runtime in hours and minutes' do
        expect(page).to have_content("Runtime: 2h 22min")
      end
      
      it 'I see the genres associated with the movie' do
        expect(page).to have_content("Genres:")
        expect(page).to have_content("Drama")
        expect(page).to have_content("Crime")
      end

      it 'I see an overview of the movie' do
        expect(page).to have_content("Overview: Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
      end

      it 'I see a button to create a viewing party for this movie' do
        expect(page).to have_button("Create Viewing Party")
      end

      it 'Lists cast members' do
        expect(page).to have_content("Tim Robbins")
      end

			it 'Counts the total number of reviews' do
				expect(page).to have_content("Number of Reviews: 8")
			end

			it 'Shows each review and its author' do		
				expect(page).to have_content("Review by: John Chard")
				expect(page).to have_content("Some birds aren't meant to be caged.")
				expect(page).to have_content("Rating: 10.0")
			end
    end
  end
end