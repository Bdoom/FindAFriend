class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :author, index: true, foreign_key: {to_table: :users}
      t.references :sent_to, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
