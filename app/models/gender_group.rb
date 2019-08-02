# frozen_string_literal: true

class GenderGroup < ApplicationRecord
  belongs_to :user
  belongs_to :gender
end
