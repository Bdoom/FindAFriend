class ChangeAboutMeFromStringToText < ActiveRecord::Migration[5.2]
  def change
    change_column :user_infos, :about_me, :text
  end
end
