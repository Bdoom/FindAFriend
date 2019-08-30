# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :timeoutable, :validatable, :lockable

  validates :invite_code, presence: true

  has_friendship
  acts_as_follower
  has_and_belongs_to_many :conversations

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :location, optional: true

  validates :about_me, length: { minimum: 150, maximum: 3000 }

  enum gender:
  {
    male: 'Male',
    female: 'Female',
    mtf: 'MtF',
    ftm: 'FtM',
    non_binary: 'Non-Binary'
  }

  enum sexuality:
  {
    heterosexual: 'Heterosexual',
    homosexual: 'Homosexual',
    bisexual: 'Bi-Sexual',
    pansexual: 'Pan-sexual',
    asexual: 'Asexual'
  }

  enum religion:
  {
    buddhism: 'Buddhism',
    hinduism: 'Hinduism',
    sikhism: 'Sikhism',
    christianity: 'Christianity',
    catholicism: 'Catholicism',
    eastern_and_oriential_orthodoxy: 'Eastern and Oriental Orthodoxy',
    protestantism: 'Protestantism',
    restorationism: 'Restorationism',
    gnosticism: 'Gnosticism',
    islam: 'Islam',
    judaism: 'Judaism',
    atheism: 'Atheism',
    agnostic: 'Agnostic'
  }

  enum race:
  {
    white: 'White',
    black_or_african_american: 'Black or African American',
    asian: 'Asian',
    native_hawaiian_or_other_pacific_islander: 'Native Hawaiian or Other Pacific Islander'
  }

  validate :validate_age

  private

  def validate_age
    if birthdate.present? && birthdate > 18.years.ago
      errors.add(:birthdate, 'You should be over 18 years old.')
    end
  end
end
