# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Logging out' do
  before do
    @joe = User.create!(name: 'Joe', email: 'joe@joe.com', password: 'joeisthebest')

    visit login_path

    fill_in :email, with: @joe.email
    fill_in :password, with: @joe.password
    click_on 'Log In'
  end

  it 'can recognize a session once logged in' do
    expect(page).to have_current_path('/dashboard')

    visit root_path

    expect(page).not_to have_button('I already have an account')
    expect(page).to have_button('Log Out')
  end

  it 'can log out a user' do
    expect(page).to have_current_path('/dashboard')

    visit root_path

    within '#logout' do
      click_on 'Log Out'
    end

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_button('I already have an account')
    expect(page).not_to have_button('Log Out')
  end
end
