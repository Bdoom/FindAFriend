# frozen_string_literal: true

class AddFirstNameToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :first_name, :string
  end
end
