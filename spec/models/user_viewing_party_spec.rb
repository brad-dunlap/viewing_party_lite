# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserViewingParty, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :viewing_party }
  end
end
