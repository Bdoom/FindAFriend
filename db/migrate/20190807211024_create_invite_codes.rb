class CreateInviteCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_codes do |t|
      t.string :invite_code
      t.boolean :used, default: false
      
      t.timestamps
    end
  end
end
