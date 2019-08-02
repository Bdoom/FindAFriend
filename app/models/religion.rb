class Religion < ApplicationRecord
    validates_uniqueness_of :name
end
