# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many :user_viewing_parties }
    it { is_expected.to have_many(:users).through(:user_viewing_parties) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :party_date }
    it { is_expected.to validate_presence_of :party_time }
    it { is_expected.to validate_presence_of :host_id }
    it { is_expected.to validate_presence_of :movie_id }
  end
end
