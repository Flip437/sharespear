class User < ApplicationRecord
  # after_save :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :book_copies
  has_many :borrows
  has_many :posts
  has_one_attached :avatar

  # instead of deleting, indicate the user requested a delete & timestamp it
 def soft_delete
   update_attribute(:deleted_at, Time.current)
 end

 # ensure user account is active
 def active_for_authentication?
   super && !deleted_at
 end

 # provide a custom message for a deleted account
 def inactive_message
   !deleted_at ? super : :deleted_account
 end  

  # def confirmation_instructions
  #   UserMailer.confirmation_instructions(self).deliver_now
  # end
 
  def welcome_send
      UserMailer.welcome_email(self).deliver_now
  end

  def after_confirmation
    self.welcome_send
  end

  def book_copy_not_available_tab
    return BookCopy.where(["status = ? and user_id = ?", 0, self.id])
  end

  def book_copy_available_tab
    return BookCopy.where(["status = ? and user_id = ?", 1, self.id])
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