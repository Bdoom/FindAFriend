class RemoveInviteCodeColumnFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :invite_code
  end
end
