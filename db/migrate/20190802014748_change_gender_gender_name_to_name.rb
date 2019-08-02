# frozen_string_literal: true

class ChangeGenderGenderNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :genders, :gender_name, :name
  end
end
