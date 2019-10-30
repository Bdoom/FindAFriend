# frozen_string_literal: true

class AddBannableToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ban_reason, :string
    add_column :users, :banned, :boolean, default: false
  end
end
