class UserMailer < ApplicationMailer
  require 'mailjet'

  def welcome_email(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    #mail(to: @user.email, subject: 'Bienvenue chez nous !')
    mail(to: @user.email, subject: "Demande d'inscription") do |format|
      format.html
    end
  end

  # def borrow_asking_email(borrow)
  #   @borrow = borrow
  #   @borrower = User.find(@borrow.user_id)
  #   @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
  #   mail(to: @owner.email, subject: "Nouvel demande d'emprunt")
  # end

  # def borrow_accepted_email(borrow)
  #   @borrow = borrow
  #   @borrower = User.find(@borrow.user_id)
  #   @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
  #   mail(to: @borrower.email, subject: "Emprunt accepté !")
  # end

  # def borrow_declined_email(borrow)
  #   @borrow = borrow
  #   @borrower = User.find(@borrow.user_id)
  #   @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
  #   mail(to: @borrower.email, subject: "Emprunt refusé") 
  # end

end