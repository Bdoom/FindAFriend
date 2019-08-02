# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_one :user_info

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       confirmation: true,
                       length: { within: 6..40 },
                       on: :create
  validates :password, confirmation: true,
                       length: { within: 6..40 },
                       allow_blank: true,
                       on: :update

  validates :zipcode, zipcode: { country_code: :us }
  validates :about_me, length: { minimum: 150, maximum: 3000 }

  belongs_to :gender
  belongs_to :race
  belongs_to :sexuality
  belongs_to :religion
  has_many :activities

  validates :about_me, length: { minimum: 150, maximum: 3000 }
end
