# frozen_string_literal: true

class Sexuality < ApplicationRecord
  validates_uniqueness_of :name

  has_many :sexuality_groups
  has_many :users, through: :sexuality_groups
end
