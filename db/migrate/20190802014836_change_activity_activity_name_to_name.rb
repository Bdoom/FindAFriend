# frozen_string_literal: true

class ChangeActivityActivityNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :activity_name, :name
  end
end
