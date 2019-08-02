# frozen_string_literal: true

class UserInfo < ApplicationRecord
  validates :zipcode, zipcode: { country_code: :us }

  belongs_to :user
end
