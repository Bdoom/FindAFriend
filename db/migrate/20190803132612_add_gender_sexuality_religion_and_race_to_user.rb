class AddGenderSexualityReligionAndRaceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :string
    add_column :users, :sexuality, :string
    add_column :users, :religion, :string
    add_column :users, :race, :string
  end
end
