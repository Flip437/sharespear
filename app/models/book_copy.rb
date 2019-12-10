class BookCopy < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1 }
  validates :author, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :status, inclusion: { in: [ true, false ] }
  validates :category, presence: true
  validates :user_id, presence: true
  validates :isbn, presence: true



def borrow_status_0?

  return Borrow.where(["borrow_status = ? and book_copy_id = ?", 0, self.id])

end



end
