class BookCopy < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1 }
  validates :author, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :status, inclusion: { in: [ true, false ] }
  validates :category, presence: true
  validates :user_id, presence: true
  validates :isbn, presence: true
  validates :photo_link, presence: true

  def borrow_status_0?
    return Borrow.where(["borrow_status = ? and book_copy_id = ?", 0, self.id])
  end

  def borrow_status_2?
    return Borrow.where(["borrow_status = ? and book_copy_id = ?", 2, self.id])
  end

  def self.search(search, bsearch)
    if search
      @booktitles = self.where('title ILIKE ?', "%#{search}%")
      @booksearched = []
      @booktitles.each do |book|
        if book.user.city.downcase == bsearch.downcase
          @booksearched << book
        end
      end
      return @booksearched
    else
      all
    end
  end



  def newbook(book)
    if book
      @isbn = book[:isbn].gsub(/[.\s]/, '')
      url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + @isbn.to_s
      doc=JSON.load(open(url))

      if doc["totalItems"]==0
        @book_infos = -1
      else
        @book_infos = JSON.load(open(url))['items'][0]['volumeInfo']
        if @book_infos["description"]
          if @book_infos["description"].length > 400
              @book_infos["description"]=@book_infos["description"].slice(1..300)
          end
        end
        sessiona = @book_infos
        sessionb = @isbn
      end
    end
    return sessiona, sessionb
  end

  def createbook(bookinfos, isbn)

    @book_infos = bookinfos
    @isbn = isbn
    puts "$$$$$$$$$$$$"
    puts @book_infos
    puts "$$$$$$$$$$$$"

    if @book_infos['imageLinks']
      photo = @book_infos['imageLinks']['thumbnail']
    else
      photo= "http://books.google.com/books/content?id=1IyauAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    end

    if  @book_infos["categories"]==nil
      @book_infos["categories"] = "other"
    else
      @book_infos["categories"] = @book_infos["categories"][0]
    end

    if  @book_infos["description"]==nil
      @book_infos["description"] = "laisse toi tenter"
    end

    return @book_infos, photo, @isbn
  
  end


end