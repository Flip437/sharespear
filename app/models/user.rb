class User < ApplicationRecord
  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :book_copies
  has_many :borrows
  has_one_attached :avatar

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def book_copy_not_available_tab
    return BookCopy.where(["status = ? and user_id = ?", false, self.id])
  end

  def book_copy_available_tab
    return BookCopy.where(["status = ? and user_id = ?", true, self.id])
  end

  def book_I_borrow_tab
    return Borrow.where(["user_id = ? and borrow_status = ?",self.id, 2])
  end

  def book_I_borrow_recup_tab
    return  Borrow.where(["user_id = ? and borrow_status = ?",self.id, 3])
  end

  def book_asked_to_borrow
    return Borrow.where(["user_id = ? and borrow_status = ?",self.id, 0])
  end

end