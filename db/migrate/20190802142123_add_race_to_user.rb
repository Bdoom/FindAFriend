# frozen_string_literal: true

class AddRaceToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :race, foreign_key: true
  end
end
