class UserMailer < ApplicationMailer

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !')

    # mail(to: @to, from: @from, subject: "Demande d'inscription") do |format|
    #   format.html
    # end

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