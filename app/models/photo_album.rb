class PhotoAlbum < ApplicationRecord
    include FafEnums

    has_many :photos
    belongs_to :user

    validates :title, presence: true
end
