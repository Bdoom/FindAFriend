class CreateActivityGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :activity, index: true

      t.timestamps
    end
  end
end
