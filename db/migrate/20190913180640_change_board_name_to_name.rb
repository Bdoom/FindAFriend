class ChangeBoardNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :boards, :board_name, :name
  end
end
