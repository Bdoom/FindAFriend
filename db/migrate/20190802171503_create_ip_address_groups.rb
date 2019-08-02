# frozen_string_literal: true

class CreateIpAddressGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :ip_address_groups do |t|
      t.belongs_to :user, index: true
      t.belongs_to :ip_address, index: true

      t.timestamps
    end
  end
end
