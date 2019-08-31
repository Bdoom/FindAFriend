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

CS.update

CS.states(:us).each do |key, _value|
  convo = Conversation.new
  convo.topic = key
  convo.save
end
