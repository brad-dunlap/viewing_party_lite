require 'rails_helper'

RSpec.describe 'Register New User' do
  describe 'As a visitor' do
    describe 'When I visit the user registration path (/register)' do
      it 'I should see a form to register.' do
        visit register_path
				save_and_open_page
				expect(page).to have_field('Name')
				expect(page).to have_field('Email')
			end
		end
	end
end