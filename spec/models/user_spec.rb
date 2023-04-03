# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:user_viewing_parties) }
    it { is_expected.to have_many(:viewing_parties).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end
end
