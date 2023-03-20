require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_viewing_parties }
    it { should have_many(:users).through(:user_viewing_parties) }
  end

  describe "validations" do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :party_date }
    it { should validate_presence_of :party_time }
    it { should validate_presence_of :host_id }
    it { should validate_presence_of :movie_id }
  end
end