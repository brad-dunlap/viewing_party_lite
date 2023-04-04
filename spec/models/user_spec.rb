require 'rails_helper'

RSpec.describe User, type: :model do
	before :each do
		@user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')

	end
  describe 'relationships' do
    it { is_expected.to have_many(:user_viewing_parties) }
    it { is_expected.to have_many(:viewing_parties).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
		it { is_expected.to have_secure_password}
	  
    it 'does not store password in plain text' do
      expect(@user).to_not have_attribute(:password)
      expect(@user.password_digest).to_not eq('password123')
    end
  end
end
