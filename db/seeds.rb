# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
DatabaseCleaner.allow_production = true
DatabaseCleaner.allow_remote_database_url = true
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

User.destroy_all
10.times.with_index do |user, index|
    user = User.create(
        email: Faker::Internet.email,
        password: "password#{index}",
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        sex: 0,
        description: Faker::Lorem.sentence,
        phone: Faker::PhoneNumber.phone_number_with_country_code,
        city: "Lyon",
        zip_code: "69001",
        street: Faker::Address.street_name,
        street_nb: Faker::Address.building_number

    )
    puts "User #{index} created"
end

BookCopy.destroy_all
10.times do |index|
  10.times do |book_copy|
      book_copy = BookCopy.create(
          title: Faker::Book.title,
          author: Faker::Book.author,
          description: Faker::Name.first_name,
          status: Faker::Name.last_name,
          category: Faker::Book.genre,
          user_id: index
      )
      puts "BookCopy user #{index} added"
  end
end
