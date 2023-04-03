require 'rails_helper'
RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    @joe = User.create(name: "Joe", email: "joe@joe.com", password: "joeisthebest")

    visit login_path
   
    fill_in :email, with: @joe.email
    fill_in :password, with: @joe.password
    click_on "Log In"

    expect(current_path).to eq("/users/#{@joe.id}")
    expect(page).to have_content("Welcome back, #{@joe.name}!")
    expect(page).to have_content("#{@joe.name}'s Dashboard")
  end

  it "returns an error when credentials are incorrect" do
    @joe = User.create(name: "Joe", email: "joe@joe.com", password: "joeisthebest")

    visit login_path
   
    fill_in :email, with: @joe.email
    fill_in :password, with: "wrongpassword"
    click_on "Log In"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Incorrect email or password")
  end
end