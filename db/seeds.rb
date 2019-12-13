
require 'faker'
DatabaseCleaner.allow_production = true
DatabaseCleaner.allow_remote_database_url = true
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

url_photo_link= "http://books.google.com/books/content?id=1IyauAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"

@isbn1=['9782740435816','9782081620391','9791092429213','9782072728952','9782897330217','9782953634808','9782203042025','9782253158769','9782820526373','9782017058922','9782377644131','9782013233422','9781909053359','9782711616374','9782081484948','9782755501773','9782756418384','9782020133197','9782215123569','9781234567897','9782253158653','9782070328277','9781781101544','9782253134176','9788499470719','9782743431839','9781512202489','9788420644738','9782266192415','9782369813033','9781548460075','0582535719','9780316015844','9791035807115','9782246813095','9781843544500','9780141014081','9782259277310','9782258162334','9782505054337','9782331017544','9782331011405','9782302026803','9782377842544','9782296283886','9782011171818','9782747094658','9782402134149','9791032908334']


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

  5.times do |index2|
    isbn = @isbn1[index2+5*index]
    puts isbn

    new_book_copy = BookCopy.new
    book_infos = new_book_copy.newbook(isbn)

    attributs = new_book_copy.createif(book_infos)

    new_book_copy = BookCopy.create(
      title:  attributs[0],
      author: attributs[1],
      description: attributs[2],
      status: true,
      category: attributs[3],
      user_id: index+1,
      photo_link: attributs[4],
      isbn: isbn
    )
  sleep(2)
  end

  puts "User #{index+1} has 5 book_copy dispo"
  #5 livre dispo en demande d'emprunt par utilisateur par utilisateur +1
  5.times do |index2|
    isbn = @isbn1[index2+5*index]
    puts isbn

    new_book_copy = BookCopy.new
    book_infos = new_book_copy.newbook(isbn)

    attributs = new_book_copy.createif(book_infos)

    book_copy = BookCopy.create(
      title:  attributs[0],
      author: attributs[1],
      description: attributs[2],
      status: true,
      category: attributs[3],
      user_id: index+1,
      photo_link: attributs[4],
      isbn: isbn
    )
    borrow = Borrow.create(
          start_date: Date.today,
          end_date: Date.today >> 2,
          message: Faker::Lorem.sentence,
          borrow_status: 0,
          user_id: index+2,
          book_copy_id: book_copy.id
      )
    sleep(2)
  end

  puts "User #{index+1} has 5 book_copy dispo avec 1 demande d'emprunt"


  #5 livre non dispo et accepte
  5.times do |book_copy_id_nb|
      isbn = @isbn1[book_copy_id_nb+5*index]
      puts isbn

      new_book_copy = BookCopy.new
      book_infos = new_book_copy.newbook(isbn)

      attributs = new_book_copy.createif(book_infos)

      book_copy = BookCopy.create(
        title:  attributs[0],
        author: attributs[1],
        description: attributs[2],
        status: true,
        category: attributs[3],
        user_id: index+1,
        photo_link: attributs[4],
        isbn: isbn
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
      sleep(2)
  end
  puts "User #{index+1} has 5 book_copy more emprunte par #{index+2} et accepte"


  #5 livre dispo et recup par preteur / termine
  5.times do |book_copy_id_nb|
      isbn = @isbn1[book_copy_id_nb+5*index]
      puts isbn

      new_book_copy = BookCopy.new
      book_infos = new_book_copy.newbook(isbn)

      attributs = new_book_copy.createif(book_infos)

      book_copy = BookCopy.create(
        title:  attributs[0],
        author: attributs[1],
        description: attributs[2],
        status: true,
        category: attributs[3],
        user_id: index+1,
        photo_link: attributs[4],
        isbn: isbn
      )
      borrow = Borrow.create(
          start_date: Date.today,
          end_date: Date.today >> 2,
          message: Faker::Lorem.sentence,
          borrow_status: 3,
          user_id: index+2,
          book_copy_id: book_copy.id
      )
      sleep(2)
  end
  puts "User #{index+1} has 5 book_copy more emprunte par #{index+2} et recupere"



end
