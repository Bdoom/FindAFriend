# frozen_string_literal: true

class Gender < ApplicationRecord
  validates_uniqueness_of :name

  has_many :user_infos, through: :gender_group
end
