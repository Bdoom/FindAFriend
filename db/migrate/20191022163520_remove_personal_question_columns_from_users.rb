class RemovePersonalQuestionColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :about_me
    remove_column :users, :race
    remove_column :users, :sexuality
    remove_column :users, :religion
  end
end
