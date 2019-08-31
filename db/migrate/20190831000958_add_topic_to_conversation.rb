class AddTopicToConversation < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :topic, :string
  end
end
