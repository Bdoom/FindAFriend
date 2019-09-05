class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.belongs_to :photo_album

      t.timestamps
    end
  end
end
