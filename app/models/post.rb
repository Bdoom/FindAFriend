# frozen_string_literal: true

class Post < ApplicationRecord
  include FafEnums

  belongs_to :user
  belongs_to :board_thread, optional: true
  
  validates :body, presence: true

    def created_at_js
        created_at.strftime()
    end
end
