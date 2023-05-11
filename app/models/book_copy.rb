class BookCopy < ApplicationRecord
  belongs_to :user
  has_many :posts
  has_many :borrows, dependent: :destroy

  validates :title, presence: true, length: { minimum: 1 }
  validates :author, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :photo_link, presence: true
  validates :isbn, presence: true
  validates :status, inclusion: { in: [ 0, 1,2 ] }
  validates :user_id, presence: true

  def borrow_status_accepted?
    return Borrow.where(["borrow_status = ? and book_copy_id = ?", Borrow::ACCEPTED, self.id])
  end

  def borrow_status_2?
    return Borrow.where(["borrow_status = ? and book_copy_id = ?", 2, self.id])
  end

  def self.search(search, bsearch)
    if search
      booktitles = self.where('title ILIKE ?', "%#{search}%")
      booksearched = []
      booktitles.each do |book|
        if book.user.city.downcase == bsearch.downcase
          booksearched << book
        end
        #end
      end
      return booksearched
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
              book_infos["description"]=book_infos["description"].slice(0..300)
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
              book_infos["description"]=book_infos["description"].slice(0..300)
          end
        end
        sessiona = book_infos
      end
    return sessiona
  end

  def already_borrowed(user)
    if Borrow.where(["user_id = ? and book_copy_id = ? and borrow_status = ?", user.id, self.id, Borrow::BOOK_GIVED_BACK]).count != 0
      return true
    else
      return false
    end
  end

end
