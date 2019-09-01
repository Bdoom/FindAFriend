# frozen_string_literal: true

class AddPermissionsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile_viewability_level, :integer, default: 0
    add_column :users, :post_default_viewability_level, :integer, default: 0
  end
end
