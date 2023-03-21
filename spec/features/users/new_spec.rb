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

				click_on 'Register'

				expect(current_path).to eq("/users/#{User.last.id}")
			end
		end
	end
end