require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: 'Bob', email: 'bob@bob.com', password: "password1")

    visit root_path

    click_on "I already have an account"

    expect(current_path).to eq(login_path)

    fill_in :name, with: user.name
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create!(name: 'Bob', email: 'bob@bob.com', password: "password1")

    visit login_path
    
    fill_in :name, with: user.name
    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"
    fill_in :password_confirmation, with: user.password_confirmation
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end