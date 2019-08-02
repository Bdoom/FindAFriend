# frozen_string_literal: true

class IpAddress < ApplicationRecord
  validates_uniqueness_of :ip_address

  has_many :ip_address_group
  has_many :users, through: :ip_address_group
end
