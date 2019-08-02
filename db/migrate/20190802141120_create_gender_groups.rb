# frozen_string_literal: true

class CreateGenderGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :gender_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :gender, index: true

      t.timestamps
    end
  end
end
