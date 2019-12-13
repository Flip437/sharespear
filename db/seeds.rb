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

@isbn1=['2212563833','9782864973423','9782870972816','9791027607747','9782266305501','9782075093866','9782203172678','9782266229487','9782290020203','9782266278362','9782266258968']

def create_book(isbn, index)

  new_book_copy = BookCopy.new

  isbn = isbn.gsub(/[.\s]/, '')
  puts isbn

  url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn.to_s
  puts url
  doc=JSON.load(open(url, 'User-Agent' => 'ruby'))
  puts doc

  if doc["totalItems"]==0
    puts "ICICIC"
      book_infos = -1
  else

      book_infos = doc['items'][0]['volumeInfo']

      if book_infos["description"]
        if book_infos["description"].length > 400
            book_infos["description"]=book_infos["description"].slice(1..300)
        end
      end

      if book_infos['imageLinks']
        photo = book_infos['imageLinks']['thumbnail']
      else
        photo="http://books.google.com/books/content?id=1IyauAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
      end
  
      if  book_infos["categories"]==nil
        category = "other"
      else
        category = book_infos["categories"][0]
      end
      if  book_infos["description"]==nil
        description = "laisse toi tenter"
      else
        description = book_infos["description"]
      end
      if  book_infos["authors"]==nil
        author = "no info"
      else
        author = book_infos["authors"][0]
      end
      if  book_infos["title"]==nil
        title = "no title"
      else
        title = book_infos["title"]
      end

      new_book_copy = BookCopy.create(
        title:  title,
        author: author,
        description: description,
        status: true,
        category: category,
        user_id: index,
        photo_link: photo,
        isbn: isbn
      )

      puts new_book_copy.inspect

      return new_book_copy

    end

end


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
    a =rand(5)
    if a == 1
        user.avatar.attach(io: File.open('vendor/img/olivia.jpg'), filename: 'emilyz.jpg')
    end
    if a == 2
      user.avatar.attach(io: File.open('vendor/img/emily.jpg'), filename: 'emilyz.jpg')
    end
    if a == 3
      user.avatar.attach(io: File.open('vendor/img/james.jpg'), filename: 'emilyz.jpg')
    end
    if a == 4
      user.avatar.attach(io: File.open('vendor/img/marie.jpg'), filename: 'emilyz.jpg')
    end
    if a == 5
      user.avatar.attach(io: File.open('vendor/img/usher.jpg'), filename: 'emilyz.jpg')
    end


    puts "User #{index} created"
end



BookCopy.destroy_all
9.times do |index|

  #5 livre dispo
  create_book(@isbn1[index], index+1)
  2.times do |index2|
      #create_book(@isbn1[index2], index+1)
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
