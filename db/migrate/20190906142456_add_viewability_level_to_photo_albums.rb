class AddViewabilityLevelToPhotoAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :photo_albums, :viewability_level, :integer
  end
end
