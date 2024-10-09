# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

puts "Removing all cafes from the database..."
Cafe.destroy_all
puts "Getting cafes from the JSON API..."
seed_url = 'https://gist.githubusercontent.com/yannklein/5d8f9acb1c22549a4ede848712ed651a/raw/dbbd31673a48993c120696f8bfc07a09f1835f7f/cafe.json'
# Making HTTP request to get back the JSON data
json_cafes = URI.open(seed_url).read
# The JSON data is then parsed/converted into a Ruby object
cafes = JSON.parse(json_cafes)
# Then, iterate over the cafes array
cafes.each do |cafe_hash|
  puts "Creating cafe #{cafe_hash['title']}..."
  Cafe.create!(
    title: cafe_hash['title'],
    address: cafe_hash['address'],
    picture: cafe_hash['picture'],
    criteria: cafe_hash['criteria'],
    hours: cafe_hash['hours']
  )
end
puts "Created #{Cafe.count} cafes!"
