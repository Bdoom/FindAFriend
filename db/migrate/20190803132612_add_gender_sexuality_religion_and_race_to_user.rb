# frozen_string_literal: true

class AddGenderSexualityReligionAndRaceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer
    add_column :users, :sexuality, :integer
    add_column :users, :religion, :integer
    add_column :users, :race, :integer
  end
end
