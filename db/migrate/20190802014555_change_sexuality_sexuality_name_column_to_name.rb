# frozen_string_literal: true

class ChangeSexualitySexualityNameColumnToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :sexualities, :sexuality_name, :name
  end
end
