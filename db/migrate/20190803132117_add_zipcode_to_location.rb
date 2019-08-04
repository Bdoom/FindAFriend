class AddZipcodeToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :zipcode, :string
  end
end
