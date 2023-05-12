require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  describe 'As a user', :vcr do
    before do
      @bob = User.create!(name: 'Bob', email: 'bob@bob.com', password: 'testing')

      visit '/login'
      fill_in 'email', with: @bob.email
      fill_in 'password', with: @bob.password
      click_on 'Log In'

      visit "/dashboard/movies/278"
    end

    it 'displays the movie details' do
      expect(page).to have_content('The Shawshank Redemption')
      expect(page).to have_content('Vote Average: 8.7')
      expect(page).to have_content('Runtime: 2h 22min')
      expect(page).to have_content('Genres:')
      expect(page).to have_content('Drama')
      expect(page).to have_content('Crime')
      expect(page).to have_content('Overview: Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.')
      expect(page).to have_button('Create Viewing Party')
    end

    it 'displays the cast members and their characters' do
      expect(page).to have_content('Tim Robbins as Andy Dufresne')
    end

    it 'displays the number of reviews' do
      expect(page).to have_content('Number of Reviews: 9')
    end

    it 'displays each review and its author' do
      expect(page).to have_content('Review by: John Chard')
      expect(page).to have_content("Some birds aren't meant to be caged.")
      expect(page).to have_content('Rating: 10.0')
    end

    it 'navigates to the new viewing party page' do
      click_button 'Create Viewing Party'
      expect(current_path).to eq('/dashboard/movies/278/viewing-party/new')
    end
  end
end
