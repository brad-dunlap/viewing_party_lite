require 'rails_helper'
RSpec.describe "Logging out" do
	before(:each) do
		@joe = User.create(name: "Joe", email: "joe@joe.com", password: "joeisthebest")
	
		visit login_path
	 
		fill_in :email, with: @joe.email
		fill_in :password, with: @joe.password
		click_on "Log In"
	end

	it "can recognize a session once logged in" do	
		expect(current_path).to eq("/users/#{@joe.id}")	

		visit root_path
		
		expect(page).to_not have_button("I already have an account")
		expect(page).to have_button("Log Out")		
	end
	
	it "can log out a user" do
		expect(current_path).to eq("/users/#{@joe.id}")	
		
		visit root_path
		click_on "Log Out"
	
		expect(current_path).to eq(root_path)
		expect(page).to have_button("I already have an account")
		expect(page).to_not have_button("Log Out")
  end
	
end