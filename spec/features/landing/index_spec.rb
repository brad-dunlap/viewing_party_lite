require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'As a visitor' do
    describe 'When I visit the root path (/)' do
      it 'I see a welcome message, a button to create a new user' do
        visit root_path
  
        expect(page).to have_content("Welcome to Viewing Party")
        expect(page).to have_button("New User")

        click_on "New User"
        
        expect(current_path).to eq('/register')
      end

      it "I see a list of existing users which links to the users dashboard" do
        visit root_path

        user1 = User.create!(name: "User 1", email: "user1@email.com")
        user2 = User.create!(name: "User 2", email: "user2@email.com")
        user3 = User.create!(name: "User 3", email: "user3@email.com")

        save_and_open_page

        expect(page).to have_link("User 1", href: "/users/#{user1.id}")
        expect(page).to have_link("User 2", href: "/users/#{user2.id}")
        expect(page).to have_link("User 3", href: "/users/#{user3.id}")

        click_on "User 1"

        expect(current_path).to eq("/users/#{user1.id}")
      end
    end
  end
end

# When a user visits the root path they should be on the landing page ('/') which includes:

#  Title of Application
#  Button to Create a New User
#  List of Existing Users which links to the users dashboard
#  Link to go back to the landing page (this link will be present at the top of all pages)