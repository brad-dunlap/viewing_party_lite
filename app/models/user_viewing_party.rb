# frozen_string_literal: true

class UserViewingParty < ApplicationRecord
  belongs_to :user
  belongs_to :viewing_party
	has_one :movie, through: :viewing_party
end
