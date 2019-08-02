class ChangeReligionReligionNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :religions, :religion_name, :name
  end
end
