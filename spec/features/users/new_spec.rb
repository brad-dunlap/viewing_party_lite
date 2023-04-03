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
        # authentication challenge
        fill_in 'Password', with: 'password1'
        fill_in 'Confirmation', with: 'password1'

        click_on 'Register'

        expect(page).to have_current_path("/users/#{User.last.id}")
        expect(page).to have_content('User successfully created')
      end

      it 'sad path for creates a new user' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: ''
        fill_in 'Password', with: 'password1'
        fill_in 'Confirmation', with: 'password1'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content('Unable to add user')
      end

      it 'cannot create a new user if password and password confirmation is empty' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'Jimbob@bobjim.com'
        fill_in 'Password', with: ''
        fill_in 'Confirmation', with: ''

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content('Unable to add user')
      end

      it 'cannot create a new user if password confirmation is empty' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'Jimbob@bobjim.com'
        fill_in 'Password', with: 'password1'
        fill_in 'Confirmation', with: ''

        click_on 'Register'
        
        expect(page).to have_current_path('/register')
        expect(page).to have_content('Unable to add user')
      end

      it 'cannot create a new user if password is empty' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'Jimbob@bobjim.com'
        fill_in 'Password', with: ''
        fill_in 'Confirmation', with: 'password1'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content('Unable to add user')
      end

      it 'cannot create a new user if password and password confirmation dont match' do
        visit register_path

        fill_in 'Name', with: 'Jimbob'
        fill_in 'Email', with: 'Jimbob@bobjim.com'
        fill_in 'Password', with: 'password1'
        fill_in 'Confirmation', with: 'password2'

        click_on 'Register'

        expect(page).to have_current_path('/register')
        expect(page).to have_content('Unable to add user')
      end
    end
  end
end
