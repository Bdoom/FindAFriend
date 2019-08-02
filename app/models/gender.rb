# frozen_string_literal: true

class Gender < ApplicationRecord
  validates_uniqueness_of :name

  has_many :gender_groups
  has_many :users, through: :gender_groups
end
