class BoardThread < ApplicationRecord
    belongs_to :board
    belongs_to :user

    has_many :posts
end
