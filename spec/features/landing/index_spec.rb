# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'As a visitor' do
    describe 'When I visit the root path (/)' do
      it 'I see a welcome message, a button to create a new user' do
        visit root_path

        expect(page).to have_content('Welcome to Viewing Party')
        expect(page).to have_button('Register as a User')
        expect(page).to have_button('I already have an account')

        click_on 'Register as a User'

        expect(page).to have_current_path('/register')
      end
    end
  end
end
