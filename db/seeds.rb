# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CS.states(:us).each do |key, _value|
  convo = Conversation.new
  convo.topic = key
  convo.save
end

user1 = User.create!(email: 'damianscape@gmail.com', first_name: 'Daniel', last_name: 'Gleason', password: 'travel', password_confirmation: 'travel')
user2 = User.create!(email: 'bdoom@playveritex.com', first_name: 'Brian', last_name: 'Pie', password: 'travel', password_confirmation: 'travel')

@ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish

result = Geocoder.search(@ip)
unless result.nil?
  @location = Location.new
  @location.latitude = result.first.latitude
  @location.longitude = result.first.longitude
  @location.country = result.first.country
  @location.city = result.first.city
  @location.state = result.first.region
  @location.zipcode = result.first.postal
  @location.user_id = user1.id
  @location.save!
  user1.location_id = @location.id
  user1.save!
end

unless result.nil?
  @location = Location.new
  @location.latitude = result.first.latitude
  @location.longitude = result.first.longitude
  @location.country = result.first.country
  @location.city = result.first.city
  @location.state = result.first.region
  @location.zipcode = result.first.postal
  @location.user_id = user2.id
  @location.save!
  user2.location_id = @location.id
  user2.save!
end

boards = {
  'general' => 'general discussion',
  'anime' => 'discussion of japanese animated videos',
  'lgbt' => 'discussion of lgbt topics',
  'politics' => 'discussion of political topics',
  'gaming' => 'discussion of video games'
}

boards.each do |name, description|
  Board.create!(name: name, description: description)
end
