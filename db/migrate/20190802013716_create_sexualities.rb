class CreateSexualities < ActiveRecord::Migration[5.2]
  def change
    create_table :sexualities do |t|
      t.string :sexuality_name

      t.timestamps
    end
  end
end
