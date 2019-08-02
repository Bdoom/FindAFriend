class AddAboutMeToUserInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :user_infos, :about_me, :string
  end
end
