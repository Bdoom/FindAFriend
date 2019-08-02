# frozen_string_literal: true

class CreateReligionGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :religion_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :religion, index: true

      t.timestamps
    end
  end
end
