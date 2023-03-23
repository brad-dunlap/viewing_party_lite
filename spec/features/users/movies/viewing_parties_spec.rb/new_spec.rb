require 'rails_helper'

RSpec.describe 'Viewing Party New Page' do
  describe 'As a user' do
    describe 'When I visit the new viewing party page' do
      before do
        movie_details = File.read('spec/fixtures/movie_details.json')
        stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: movie_details, headers: {})

         stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=0ec9f3b92d1ab9c1631a6787b9aa3458").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: movie_details, headers: {})

        @bob = User.create!(name: 'Bob', email: 'bob@gmail.com')
        
        visit "/users/#{@bob.id}/movies/238/viewing-party/new"
      end

      it 'I see a form to create a viewing party' do
        expect(page).to have_field('Duration')
        expect(page).to have_field(:party_date)
        expect(page).to have_field(:party_time)
        expect(page).to have_field('Users')
        expect(page).to have_button('Create Party')

        click_button 'Create Party'

        expect(current_path).to eq("/users/#{@bob.id}/movies/278/viewing-party/new")
      end
    end
  end
end