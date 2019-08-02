# frozen_string_literal: true

class IpAddressGroup < ApplicationRecord
  belongs_to :user
  belongs_to :ip_address
end
