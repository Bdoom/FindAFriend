class AddViewabilityLevelToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :viewability_level, :integer
  end
end
