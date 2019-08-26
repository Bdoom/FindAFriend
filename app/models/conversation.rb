# frozen_string_literal: true

class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :between, lambda { |sender_id, recipient_id|
    where(
        "(conversations.sender_id = :s AND conversations.recipient_id = :r ) OR (conversations.sender_id = :r AND conversations.recipient_id = :s)", 
        s: sender_id, r: recipient_id
      )
    }
end
