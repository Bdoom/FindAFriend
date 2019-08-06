class AddLocationToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :location, foreign_key: {on_delete: :cascade}
  end
end
