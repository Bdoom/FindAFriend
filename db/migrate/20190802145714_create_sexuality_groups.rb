# frozen_string_literal: true

class CreateSexualityGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :sexuality_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :sexuality, index: true

      t.timestamps
    end
  end
end
