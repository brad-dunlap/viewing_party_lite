# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Show Page' do
  before do
		movie_details = File.read('spec/fixtures/movie_details.json')

    @bob = User.create!(name: 'Bob', email: 'bob@bob.com')
    @sally = User.create!(name: 'Sally', email: 'sally@sally.com')
    @joe = User.create!(name: 'Joe', email: 'joe@joe.com')

		@movie = Movie.new(JSON.parse(movie_details, symbolize_names: true))

		@viewing_party = @bob.viewing_parties.create!(movie_id: @movie.id, host_id: @bob.id, party_date: '2023-06-01', party_time: '12:00',duration: 120)
		@viewing_party.users << @sally
    @viewing_party.users << @joe

		stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: movie_details, headers: {})
	
	visit user_path(@bob)
  end

  describe 'As a visitor when I visit a user show page' do
    it 'I see the name of the users dashboard' do
      expect(page).to have_content("#{@bob.name}'s Dashboard")
    end

    it 'I see a button to Discover Movies' do
      click_on 'Discover Movies'

      expect(page).to have_current_path("/users/#{@bob.id}/discover")
    end

    it 'has a section that lists viewing parties' do
			expect(page).to have_content('Viewing Parties')     
    end

		it 'shows the viewing parties the user has created' do
			expect(page).to have_content("Shawshank Redemption")
			expect(page).to have_content("2023-06-01")
			expect(page).to have_content("12:00")
			expect(page).to have_content("120")
      expect(page).to have_content("I am hosting this party.")

      expect(page).to have_content("Attendees:\nSally\nJoe")
		end
  end
end
