# frozen_string_literal: true

class Post < ApplicationRecord
  include FafEnums

  belongs_to :user
  
  validates :body, presence: true

    def created_at_js
        created_at.strftime()
    end
end
