# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Party New Page' do
  describe 'As a user', :vcr do
    describe 'When I visit the new viewing party page' do
      before do
        @bob = User.create!(name: 'Bob', email: 'bob@gmail.com', password: 'testing')
        @sally = User.create!(name: 'Sally', email: 'sally@gmail.com', password: 'testing')
        @brad = User.create!(name: 'Brad', email: 'brad@gmail.com', password: 'testing')

        visit login_path

        fill_in :email, with: @bob.email
        fill_in :password, with: @bob.password
        click_on 'Log In'
        visit '/dashboard/movies/238/viewing-party/new'
      end

      it 'I see a form to create a viewing party' do
        expect(page).to have_field('Duration')
        expect(page).to have_field(:party_date)
        expect(page).to have_field(:party_time)
        expect(page).not_to have_content(@bob.name)
        expect(page).to have_content(@sally.name)
        expect(page).to have_button('Create Party')
      end

      it 'creates a viewing party' do
        fill_in 'Duration', with: 180
        fill_in :party_date, with: '2021-10-10'
        fill_in :party_time, with: '12:00'
        check @sally.name
        check @brad.name
        click_button 'Create Party'

        expect(page).to have_current_path('/dashboard')
      end

      it 'shows an error message for invalid input' do
        click_button 'Create Party'

        expect(page).to have_content('Invalid Input')
      end
    end
  end
end
