class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :conversation, index: true
      t.text :message_body

      t.timestamps
    end
  end
end
