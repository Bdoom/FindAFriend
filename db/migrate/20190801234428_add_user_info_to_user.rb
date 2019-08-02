class AddUserInfoToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user_info, foreign_key: true
  end
end
