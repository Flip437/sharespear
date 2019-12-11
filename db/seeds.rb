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

url_photo_link= "http://books.google.com/books/content?id=1IyauAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"

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
9.times do |index|

  #5 livre dispo
  5.times do |index2|
      book_copy = BookCopy.create(
          title: Faker::Book.title,
          author: Faker::Book.author,
          description: Faker::TvShows::SiliconValley.quote,
          status: true, # [true, false].sample,
          category: Faker::Book.genre,
          isbn: "102020200",
          photo_link: url_photo_link,
          user_id: index+1
      )
  end
  puts "User #{index+1} has 5 book_copy dispo"
  #5 livre dispo en demande d'emprunt par utilisateur par utilisateur +1
  5.times do |index2|
      book_copy = BookCopy.create(
          title: Faker::Book.title,
          author: Faker::Book.author,
          description: Faker::Quotes::Shakespeare.hamlet_quote,
          status: true, # [true, false].sample,
          category: Faker::Book.genre,
          isbn: "102020200",
          photo_link: url_photo_link,
          user_id: index+1
      )
      borrow = Borrow.create(
          start_date: Date.today,
          end_date: Date.today >> 2,
          message: Faker::Lorem.sentence,
          borrow_status: 0,
          user_id: index+2,
          book_copy_id: book_copy.id
      )
  end
  puts "User #{index+1} has 5 book_copy dispo avec 1 demande d'emprunt"

  #5 livre non dispo et accepte
  5.times do |book_copy_id_nb|
      book_copy = BookCopy.create(
          title: Faker::Book.title,
          author: Faker::Book.author,
          description: Faker::Quotes::Shakespeare.romeo_and_juliet_quote,
          status: true, # [true, false].sample,
          category: Faker::Book.genre,
          isbn: "102020200",
          photo_link: url_photo_link,
          user_id: index+1
      )
      borrow = Borrow.create(
          start_date: Date.today,
          end_date: Date.today >> 2,
          message: Faker::Lorem.sentence,
          borrow_status: 2,
          user_id: index+2,
          book_copy_id: book_copy.id
      )
      book_copy.update(status:false)
  end
  puts "User #{index+1} has 5 book_copy more emprunte par #{index+2} et accepte"

  #5 livre dispo et recup par preteur / termine
  5.times do |book_copy_id_nb|
      book_copy = BookCopy.create(
          title: Faker::Book.title,
          author: Faker::Book.author,
          description: Faker::Quotes::Shakespeare.king_richard_iii_quote,
          status: true, # [true, false].sample,
          category: Faker::Book.genre,
          isbn: 102020200,
          photo_link: url_photo_link,
          user_id: index+1
      )
      borrow = Borrow.create(
          start_date: Date.today,
          end_date: Date.today >> 2,
          message: Faker::Lorem.sentence,
          borrow_status: 3,
          user_id: index+2,
          book_copy_id: book_copy.id
      )
  end
  puts "User #{index+1} has 5 book_copy more emprunte par #{index+2} et recupere"


end
