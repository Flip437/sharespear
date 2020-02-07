class BookCopy < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :title, presence: true, length: { minimum: 1 }
  validates :author, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :status, inclusion: { in: [ 0, 1,2 ] }
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

  def newbook(book_isbn)
      isbn = book_isbn.gsub(/[.\s]/, '')
      url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn.to_s
      doc=JSON.load(open(url, 'User-Agent' => 'ruby'))
      if doc["totalItems"]==0
        sessiona = "0"
      else
        book_infos = doc['items'][0]['volumeInfo']
        if book_infos["description"]
          if book_infos["description"].length > 400
              book_infos["description"]=book_infos["description"].slice(1..300)
          end
        end
        sessiona = book_infos
      end
    return sessiona
  end


  def newbook_title(book_title,index)
      isbn = book_title.gsub(/[.\s]/, '')
      url = "https://www.googleapis.com/books/v1/volumes?q=" + book_title.to_s
      doc=JSON.load(open(url, 'User-Agent' => 'ruby'))
      if doc["totalItems"]==0
        sessiona = "0"
      else
        book_infos = doc['items'][index]['volumeInfo']
        if book_infos["description"]
          if book_infos["description"].length > 400
              book_infos["description"]=book_infos["description"].slice(1..300)
          end
        end
        sessiona = book_infos
      end
    return sessiona
  end




  def createif(bookinfos)
    if bookinfos["description"]
      if bookinfos["description"].length > 400
          description=bookinfos["description"].slice(1..300)
      end
    end
    if bookinfos['imageLinks']
      photo = bookinfos['imageLinks']['thumbnail']
    else
      photo="no_picture_found_sk.png"
    end

    if  bookinfos["categories"]==nil
      category = "other"
    else
      category = bookinfos["categories"][0]
    end
    if  bookinfos["description"]==nil
      description = "..."
    else
      description = bookinfos["description"]
    end
    if  bookinfos["authors"]==nil
      author = "~"
    else
      author = bookinfos["authors"][0]
    end
    if  bookinfos["title"]==nil
      title = "~"
    else
      title = bookinfos["title"]
    end
    if  bookinfos["industryIdentifiers"]==nil
      isbn = "~"
    else
      isbn = bookinfos['industryIdentifiers'][0]['identifier']
    end
    if  bookinfos["publishedDate"]==nil
      date = "~"
    else
      date = bookinfos['publishedDate']
    end
    return title, author, description, category, photo, isbn, date
  end


  def already_borrowed(user)
    if Borrow.where(["user_id = ? and book_copy_id = ? and borrow_status = ?", user.id, self.id, 3]).count != 0
      return true
    else
      return false
    end
  end

end
