class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable,
         :lockable,
         :timeoutable
        #  :trackable
        #  :omniauthable

  has_many :book_copies
  has_many :borrows
  has_many :borrows

  has_many :requesting_borrows, class_name: "Borrow", foreign_key: "borrower_user_id"
  has_many :requested_borrows, class_name: "Borrow", foreign_key: "borrowed_user_id"

  has_many :posts
  has_many :comments

  has_many :sent_comments, foreign_key: 'commenter_id', class_name: "Usercomment"
  has_many :received_comments, foreign_key: 'commented_id', class_name: "Usercomment"

  has_many :follows
  has_one_attached :avatar

  ZIP_CODES_NAMES = {
    '69001': "Lyon 1 - Terreaux",
    '69002': "Lyon 2 - Bellecour",
    '69003': "Lyon 3 - La Part-Dieu",
    '69004': "Lyon 4 - Croix-Rousse",
    '69005': "Lyon 5 - Vieux Lyon",
    '69006': "Lyon 1 - Terreaux",
    '69007': "Lyon 7 - Jean Macé",
    '69008': "Lyon 8 - Monplaisir",
    '69009': "Lyon 9 - Vaise",
    '69100': "Villeurbanne",
    '69100': "Villeurbanne",
    '69300': "Caluire-et-Cuire",
    '69142': "La Mulatière",
    '69160': "Tassin-la-Demi-Lune",
    '69130': "Écully",
    '69600': "Oullins",
    '69500': "Bron"
  }

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
    book_copies.where(status: BookCopy::NOT_AVAILABLE)
  end

  def book_copy_available_tab
    return BookCopy.where(["status = ? and user_id = ?", 1, self.id])
  end

  def book_I_borrow_tab
    return Borrow.where(borrower_user: self, borrow_status: Borrow::ACCEPTED)
  end

  def book_I_borrow_recup_tab
    return Borrow.where(borrower_user: self, borrow_status: Borrow::FINISHED)
  end

  def book_asked_to_borrow
    return Borrow.where(["user_id = ? and borrow_status = ?",self.id, Borrow::PENDING])
  end

  def self.search(search)
    if search
      @users = self.where('first_name ILIKE ?', "%#{search}%")
      return @users
    else
      return false
    end
  end

end
