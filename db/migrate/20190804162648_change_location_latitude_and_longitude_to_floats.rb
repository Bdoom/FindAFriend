class ChangeLocationLatitudeAndLongitudeToFloats < ActiveRecord::Migration[5.2]
  def change
    change_column :locations, :longitude, :float
    change_column :locations, :latitude, :float
  end
end
