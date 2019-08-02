# frozen_string_literal: true

class ReligionGroup < ApplicationRecord
  belongs_to :user
  belongs_to :religion
end
