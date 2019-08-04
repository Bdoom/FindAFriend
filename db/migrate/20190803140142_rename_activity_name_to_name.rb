class RenameActivityNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :activity_name, :name
  end
end
