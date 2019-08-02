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

Gender.create!([
                 { name: 'Cis Male' },
                 { name: 'Cis Female' },
                 { name: 'MtF' },
                 { name: 'FtM' },
                 { name: 'Non-binary' }
               ])

Sexuality.create!([
                    { name: 'Homosexual' },
                    { name: 'Hetereosexual' },
                    { name: 'Bi-sexual' },
                    { name: 'Pan-sexual' },
                    { name: 'Asexual' }
                  ])

Religion.create!([
                   { name: 'Buddhism' },
                   { name: 'Hinduism' },
                   { name: 'Sikhism' },
                   { name: 'Christianity' },
                   { name: 'Catholicism' },
                   { name: 'Eastern and Oriental Orthodoxy' },
                   { name: 'Protestantism' },
                   { name: 'Restorationism' },
                   { name: 'Gnosticism' },
                   { name: 'Islam' },
                   { name: 'Judaism' },
                   { name: 'Atheism' },
                   { name: 'Agnostic' }
                 ])
