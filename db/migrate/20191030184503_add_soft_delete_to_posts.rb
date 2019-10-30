class AddSoftDeleteToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :soft_deleted, :boolean, default: false
  end
end
