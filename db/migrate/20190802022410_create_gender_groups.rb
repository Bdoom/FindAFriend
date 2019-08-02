class CreateGenderGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :gender_groups do |t|
      t.belongs_to :user_info, index: true

      t.timestamps
    end
  end
end
