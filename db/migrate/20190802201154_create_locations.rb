# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :country
      t.string :address
      t.string :state

      t.timestamps
    end
  end
end
