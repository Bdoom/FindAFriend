# frozen_string_literal: true

class Location < ApplicationRecord

    extend Geocoder::Model::ActiveRecord
    geocoded_by :address

    #validates :zipcode, zipcode: { country_code: :us }

    has_one :user

    def address
        address + city + country
    end
    
end
