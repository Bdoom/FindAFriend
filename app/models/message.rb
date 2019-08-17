class Message < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id' 
end
