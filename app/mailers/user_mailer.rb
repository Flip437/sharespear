class UserMailer < ApplicationMailer
  require 'mailjet'

  def welcome_email(user)
    @user = user 
    @url  = 'http://monsite.fr/login' 
    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def borrow_asking_email(borrow)
    @borrow = borrow
    @borrower = User.find(@borrow.user_id)
    @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
    mail(to: @owner.email, subject: "Nouvel demande d'emprunt")
  end

  def borrow_accepted_email(borrow)
    @borrow = borrow
    @borrower = User.find(@borrow.user_id)
    @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
    mail(to: @borrower.email, subject: "Emprunt accepté !")
  end

  def borrow_declined_email(borrow)
    @borrow = borrow
    @borrower = User.find(@borrow.user_id)
    @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
    mail(to: @borrower.email, subject: "Emprunt refusé") 
  end

  def borrow_remaining_time_email(borrow, timeremaining)
    @borrow = borrow
    @timeremaining = timeremaining
    @borrower = User.find(@borrow.user_id)
    @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
    mail(to: @borrower.email, subject: "Attention, tu vas bientôt rendre votre livre")
  end

  def borrow_book_rendered_email(borrow)
    @borrow = borrow
    @borrower = User.find(@borrow.user_id)
    @owner = User.find(BookCopy.find(@borrow.book_copy_id).user_id)
    mail(to: @borrower.email, subject: "Ton livre à bien été rendu !")
  end


end