class Race < ApplicationRecord
    validates_uniqueness_of :name
end
