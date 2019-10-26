class BoardThread < ApplicationRecord
    belongs_to :board
    belongs_to :user

    has_many :posts

    validates :title, presence: true
    validates :body, presence: true
end
