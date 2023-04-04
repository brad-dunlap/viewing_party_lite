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

      it "can see a list of user emails when logged in" do
        user4 = User.create!(name: 'User 4', email: 'user4@email.com', password: "password1")
        user5 = User.create!(name: 'User 5', email: 'user5@email.com', password: "password2")
        user6 = User.create!(name: 'User 6', email: 'user6@email.com', password: "password3")

        visit root_path

        click_link "Log In"

        expect(current_path).to eq(login_path)

        fill_in :name, with: user4.name
        fill_in :email, with: user4.email
        fill_in :password, with: user4.password
        fill_in :password_confirmation, with: user4.password
    
        click_on "Log In"
     
        expect(current_path).to eq("/users/#{user4.id}")

        click_on "Landing Page"

        expect(current_path).to eq(root_path)

        expect(page).to have_content(user4.email)
        expect(page).to have_content(user5.email)
        expect(page).to have_content(user6.email)
      end

      it "cannot route to /dashboard if logged out" do
        visit dashboard_path

        expect(page).to have_content("You must be logged in or registered to access my dashboard.")
      end
    end
  end
end
