# frozen_string_literal: true

class Activity < ApplicationRecord
  validates_uniqueness_of :name

  acts_as_likeable
  
end
