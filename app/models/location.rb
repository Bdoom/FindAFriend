# frozen_string_literal: true

class Location < ApplicationRecord

    validates :zipcode, zipcode: { country_code: :us }
    
end
