# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def batting_average
  rand(1..1000)
end

100.times do |count|
  Player.create(name: "Bob#{count+1}", batting_average: batting_average)
end
