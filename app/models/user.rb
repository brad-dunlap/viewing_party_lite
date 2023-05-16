# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_viewing_parties, dependent: :destroy
  has_many :viewing_parties, through: :user_viewing_parties, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_secure_password
end
