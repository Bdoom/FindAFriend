# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  
  validates_presence_of :message_body, :conversation_id, :user_id

end
