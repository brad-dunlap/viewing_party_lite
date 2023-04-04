# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'As a visitor' do
    describe 'When I visit the root path (/)' do
      it 'I see a welcome message, a button to create a new user' do
        visit root_path

        expect(page).to have_content('Welcome to Viewing Party')
        expect(page).to have_button('New User')

        click_on 'New User'

        expect(page).to have_current_path('/register')
      end

      it 'I see a list of existing users which links to the users dashboard' do
        user4 = User.create!(name: 'User 4', email: 'user4@email.com', password: "password1")
        user5 = User.create!(name: 'User 5', email: 'user5@email.com', password: "password2")
        user6 = User.create!(name: 'User 6', email: 'user6@email.com', password: "password3")

        visit root_path

        expect(page).to have_link('Landing Page', href: '/')
      end
    end
  end
end
