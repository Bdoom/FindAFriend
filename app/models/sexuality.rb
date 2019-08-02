# frozen_string_literal: true

class Sexuality < ApplicationRecord
  validates_uniqueness_of :name
end
