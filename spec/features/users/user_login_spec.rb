# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Logging In' do
  it 'can log in with valid credentials' do
    @joe = User.create(name: 'Joe', email: 'joe@joe.com', password: 'joeisthebest')

    visit login_path

    fill_in :email, with: @joe.email
    fill_in :password, with: @joe.password
    click_on 'Log In'

    expect(page).to have_current_path('/dashboard')
    expect(page).to have_content("Welcome back, #{@joe.name}!")
    expect(page).to have_content("#{@joe.name}'s Dashboard")
  end

  it 'returns an error when credentials are incorrect' do
    @joe = User.create(name: 'Joe', email: 'joe@joe.com', password: 'joeisthebest')

    visit login_path

    fill_in :email, with: @joe.email
    fill_in :password, with: 'wrongpassword'
    click_on 'Log In'

    expect(page).to have_current_path(login_path, ignore_query: true)
    expect(page).to have_content('Incorrect email or password')

    fill_in :email, with: 'bob@bob.com'
    fill_in :password, with: @joe.password
    click_on 'Log In'

    expect(page).to have_current_path(login_path, ignore_query: true)
    expect(page).to have_content('Incorrect email or password')
  end
end
