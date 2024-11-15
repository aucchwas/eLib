# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

# Clear all data
BookGenre.destroy_all
Book.destroy_all
Genre.destroy_all

# Create Genres
11.times do
  Genre.find_or_create_by(name: Faker::Book.genre)
end

# Create Books
100.times do
  book = Book.find_or_create_by(
    title: Faker::Book.title,
    author: Faker::Book.author,
    price: Faker::Commerce.price,
    publisher: Faker::Book.publisher,
  )

  # Assign random genres to each book
  book.genres << Genre.order("RANDOM()").limit(1)
end

puts "Created #{Genre.count} genres"
puts "Created #{Book.count} books"
puts "Created #{BookGenre.count} book genres"
