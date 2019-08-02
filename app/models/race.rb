# frozen_string_literal: true

class Race < ApplicationRecord
  validates_uniqueness_of :name

  has_many :race_groups
  has_many :users, through: :race_groups
end
