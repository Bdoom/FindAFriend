# frozen_string_literal: true

class CreateRaceGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :race_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :race, index: true

      t.timestamps
    end
  end
end
