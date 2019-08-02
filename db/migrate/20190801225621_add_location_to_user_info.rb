class AddLocationToUserInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :user_infos, :zipcode, :string
  end
end
