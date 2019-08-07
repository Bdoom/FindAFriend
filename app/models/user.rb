# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :timeoutable, :validatable, :lockable


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

  has_many :activity_group
  has_many :activities, through: :activity_group

  belongs_to :location, optional: true

  belongs_to :ip_address, optional: true

  validates :about_me, length: { minimum: 150, maximum: 3000 }

  enum gender: { cis_male: 'Cis Male', cis_female: 'Cis Female', mtf: 'MtF', ftm: 'FtM', non_binary: 'Non-Binary' }
  enum sexuality: { homosexual: 'Homosexual', heterosexual: 'Heterosexual', bisexual: 'Bi-Sexual', pansexual: 'Pan-sexual', asexual: 'Asexual' }
  enum religion: { buddhism: 'Buddhism', hinduism: 'Hinduism', sikhism: 'Sikhism', christianity: 'Christianity', catholicism: 'Catholicism', eastern_and_oriential_orthodoxy: 'Eastern and Oriental Orthodoxy', protestantism: 'Protestantism', restorationism: 'Restorationism', gnosticism: 'Gnosticism', islam: 'Islam', judaism: 'Judaism', atheism: 'Atheism', agnostic: 'Agnostic' }
  enum race: { white: 'White', black_or_african_american: 'Black or African American', asian: 'Asian', native_hawaiian_or_other_pacific_islander: 'Native Hawaiian or Other Pacific Islander' }

  validate :validate_age

  private
  def validate_age
      if birthdate.present? && birthdate > 18.years.ago
          errors.add(:birthdate, 'You should be over 18 years old.')
      end
  end

end
