# frozen_string_literal: true

class CreateUserViewingParties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_viewing_parties do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :viewing_party, foreign_key: true

      t.timestamps
    end
  end
end
