# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Show Page' do
  before do
    @bob = User.create!(name: 'Bob', email: 'bob@bob.com', password: 'testing')
    @sally = User.create!(name: 'Sally', email: 'sally@sally.com', password: 'testing')
    @joe = User.create!(name: 'Joe', email: 'joe@joe.com', password: 'testing')

    visit login_path
    fill_in :email, with: @bob.email
    fill_in :password, with: @bob.password
    click_on 'Log In'
  end

  describe 'As a visitor when I visit a user show page' do
    it 'I see the name of the user\'s dashboard' do
      expect(page).to have_content("#{@bob.name}'s Dashboard")
    end

    it 'I see a button to Discover Movies' do
      click_on 'Discover Movies'

      expect(page).to have_current_path('/dashboard/discover')
    end

    it 'has a section that lists viewing parties' do
      expect(page).to have_content('Viewing Parties')
    end

    it 'shows the viewing parties the user has created' do
      VCR.use_cassette('movie_details') do
        movie_details = File.read('spec/fixtures/movie_details.json')
        @movie = Movie.new(JSON.parse(movie_details, symbolize_names: true))
        @viewing_party = @bob.viewing_parties.create!(movie_id: @movie.id, host_id: @bob.id, party_date: '2023-06-01',
                                                      party_time: '12:00', duration: 120)
        @viewing_party.users << @sally
        @viewing_party.users << @joe

        visit user_path(@bob)

        expect(page).to have_link('The Shawshank Redemption')
        expect(page).to have_content('June 01, 2023')
        expect(page).to have_content('12:00')
        expect(page).to have_content('120')
        expect(page).to have_content('I am hosting this party.')
        expect(page).to have_content("Attendees:\nBob\nSally\nJoe")
      end
    end
  end
end
