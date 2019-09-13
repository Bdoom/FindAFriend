# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Activity.create!([
                   { name: 'Movies' },
                   { name: 'Walking' },
                   { name: 'Running' },
                   { name: 'Dancing' },
                   { name: 'Improv' },
                   { name: 'Soccer' },
                   { name: 'Hockey' },
                   { name: 'Basketball' },
                   { name: 'Kickboxing' },
                   { name: 'MMA' },
                   { name: 'Stand-up comedy' },
                   { name: 'Karaoke' },
                   { name: 'Concerts' }
                 ])

invite_codes = (0...1000).map { { invite_code: SecureRandom.hex(7) } }
invite_codes = invite_codes.uniq

invite_codes.each do |invite_code|
  InviteCode.find_or_create_by!(invite_code)
end

CS.states(:us).each do |key, _value|
  convo = Conversation.new
  convo.topic = key
  convo.save
end

invite = InviteCode.first.invite_code
invite2 = InviteCode.last.invite_code
user1 = User.create!(email: 'damianscape@gmail.com', first_name: 'Daniel', last_name: 'Gleason', password: 'travel', password_confirmation: 'travel', invite_code: invite, about_me: '3bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a39') if Rails.env.development?
user2 = User.create!(email: 'bdoom@playveritex.com', first_name: 'Brian', last_name: 'Pie', password: 'travel', password_confirmation: 'travel', invite_code: invite2, about_me: '3bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a393bde22b6897a39') if Rails.env.development?

unless Rails.env.production?
  @ip = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
end

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


random_posts = (0...1000).map { { user: User.first, body: SecureRandom.hex(7), post_visibility: 0 } }
random_posts.each do |post|
Post.find_or_create_by!(post)
end

board_names = ['general', 'anime', 'lgbt', 'politics', 'gaming']
board_names.each do |board_name|
  Board.create!(name: board_name)
end