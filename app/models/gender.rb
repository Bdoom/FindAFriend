# frozen_string_literal: true

class Gender < ApplicationRecord
  validates_uniqueness_of :name
end
