# frozen_string_literal: true

class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_uniqueness_of :name

  has_many :board_threads
end
