class SetTopicNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :conversations, :topic, :string, null: true
  end
end
