# frozen_string_literal: true

class UserInfo < ApplicationRecord
  validates :zipcode, zipcode: { country_code: :us }
  validates :about_me, length: { minimum: 150, maximum: 3000 }

  belongs_to :user
end
