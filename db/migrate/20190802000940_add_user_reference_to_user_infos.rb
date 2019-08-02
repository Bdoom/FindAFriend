class AddUserReferenceToUserInfos < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_infos, :user, foreign_key: true
  end
end
