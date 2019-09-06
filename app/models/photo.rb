class Photo < ApplicationRecord
    include FafEnums

    has_one_attached :image
    belongs_to :photo_album

    validates :title, presence: true
    validates :description, presence: true
end
