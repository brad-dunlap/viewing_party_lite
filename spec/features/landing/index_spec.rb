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
        user1 = User.create!(name: 'User 1', email: 'user1@email.com')
        user2 = User.create!(name: 'User 2', email: 'user2@email.com')
        user3 = User.create!(name: 'User 3', email: 'user3@email.com')

        visit root_path

        expect(page).to have_link('Landing Page', href: '/')
        expect(page).to have_link('User 1', href: "/users/#{user1.id}")
        expect(page).to have_link('User 2', href: "/users/#{user2.id}")
        expect(page).to have_link('User 3', href: "/users/#{user3.id}")

        click_on 'User 1'

        expect(page).to have_current_path("/users/#{user1.id}")
        expect(page).to have_link('Landing Page', href: '/')
      end
    end
  end
end
