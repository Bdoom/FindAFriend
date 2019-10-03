# frozen_string_literal: true

class User < ApplicationRecord
  include FafEnums

  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :rememberable,
         :trackable,
         :timeoutable,
         :validatable,
         :lockable,
         :recoverable,
         :omniauthable, omniauth_providers: %i[discord]

  def self.from_omniauth(auth)
    puts "Auth: #{auth.to_s}"

    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|

      user.provider = auth.provider
      user.email = auth.info.email unless auth.info.nil?
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      user.skip_confirmation!
      user.save!
    end
  end

  def self.email_required?
    super && provider.blank?
  end

  def self.password_required?
    super && provider.blank?
  end

  has_one_attached :profile_picture

  # validates :first_name, presence: true
  # validates :last_name, presence: true

  has_friendship
  acts_as_follower
  acts_as_liker

  has_and_belongs_to_many :conversations

  has_many :posts
  has_many :photo_albums

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  belongs_to :location, optional: true

  # validates :about_me, length: { minimum: 150, maximum: 3000 }

  enum gender:
  {
    male: 0,
    female: 1,
    mtf: 2,
    ftm: 3,
    non_binary: 4
  }

  enum sexuality:
  {
    heterosexual: 0,
    homosexual: 1,
    bisexual: 2,
    pansexual: 3,
    asexual: 4
  }

  enum religion:
  {
    buddhism: 0,
    hinduism: 1,
    christianity: 2,
    catholicism: 3,
    islam: 4,
    judaism: 5,
    atheism: 6,
    agnostic: 7
  }

  enum race:
  {
    white: 0,
    black_or_african_american: 1,
    asian: 2
  }

  validate :validate_age

  private

  def validate_age
    if birthdate.present? && birthdate > 18.years.ago
      errors.add(:birthdate, 'You should be over 18 years old.')
    end
  end
end
