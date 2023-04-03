# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register New User' do
  describe 'As a visitor' do
    describe 'When I visit the user registration path (/register)' do
      it 'I should see a form to register.' do
        visit register_path

        expect(page).to have_field('Name')
        expect(page).to have_field('Email')
      end

      it 'creates a new user' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'Jimbob@bobjim.com'
				fill_in 'Password', with: 'test'
				fill_in 'Confirm', with: 'test'

        click_on 'Register'
        expect(page).to have_current_path("/users/#{User.last.id}")
        expect(page).to have_content("Welcome #{User.last.name}!")
      end

      it 'sad path for creates a new user' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: ''
				fill_in 'Password', with: 'test'
				fill_in 'Confirm', with: 'test'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content("Email can't be blank")
      end

      it 'passwords do not match' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'jimbob@jimbob.com'
				fill_in 'Password', with: 'jimbob'
				fill_in 'Confirm', with: 'bobjim.'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content("Password confirmation doesn't match")
      end

      it 'is not a unique email' do
				@Jimbob = User.create(name: "Jimbob", email: "jimbob@jimbob.com", password: "jimbob")
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'jimbob@jimbob.com'
				fill_in 'Password', with: 'jimbob'
				fill_in 'Confirm', with: 'jimbob'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content("Email has already been taken")
      end
    end
  end
end
