# frozen_string_literal: true

class Religion < ApplicationRecord
  validates_uniqueness_of :name

  has_many :religion_groups
  has_many :users, through: :religion_groups
end
