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

        @bob = User.create!(name: 'Bob', email: 'bob@gmail.com', password: 'test')
        @sally = User.create!(name: 'Sally', email: 'sally@gmail.com', password: 'test')
				@brad = User.create!(name: 'Brad', email: 'brad@gmail.com', password: 'test')
        
				visit login_path
				
				fill_in :email, with: @bob.email
				fill_in :password, with: @bob.password
				click_on "Log In"
        visit "/users/#{@bob.id}/movies/238/viewing-party/new"
      end

      it 'I see a form to create a viewing party' do
        expect(page).to have_field('Duration')
        expect(page).to have_field(:party_date)
        expect(page).to have_field(:party_time)
        expect(page).to have_content(@bob.name)
        expect(page).to have_content(@sally.name)
        expect(page).to have_button('Create Party')
      end

      it 'I see a form to create a viewing party' do
        fill_in 'Duration', with: 180
        fill_in :party_date, with: '2021-10-10'
        fill_in :party_time, with: '12:00'
				check @sally.name
				check @brad.name
        click_button 'Create Party'

        expect(current_path).to eq("/users/#{@bob.id}")
      end

      it 'sad path for create form' do
        click_button 'Create Party'

        expect(page).to have_content("Invalid Input")
      end
    end
  end
end