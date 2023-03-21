# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Show Page' do
  before do
    @bob = User.create!(name: 'Bob', email: 'bob@bob.com')
    visit user_path(@bob)
  end

  describe 'As a visitor when I visit a user show page' do
    it 'I see the name of the users dashboard' do
      expect(page).to have_content("#{@bob.name}'s Dashboard")
    end

    it 'I see a button to Discover Movies' do
      click_on 'Discover Movies'

      expect(current_path).to eq("/users/#{@bob.id}/discover")
    end

    # it "has a section that lists viewing parties" do

    # end
  end
end
