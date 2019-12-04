class DashboardController < ApplicationController
  def index
    #Mes livres prêté
    @book_copy_not_available_tab=BookCopy.where(["status = ? and user_id = ?", false, 3])

    #Demandes de prêt reçu
    book_copy_available_tab=BookCopy.where(["status = ? and user_id = ?", true, 3])
    puts book_copy_available_tab
    @ask_book_tab=[]
    book_copy_available_tab.each do |n|

      tab=Borrow.where(["borrow_status = ? and book_copy_id = ?", 0, n.id])
      if(tab.empty?)
      else
        @ask_book_tab=tab+@ask_book_tab
      end
    end
    puts @ask_book_tab

    #Mes emprunts

    @book_I_borrow_tab=Borrow.where(["user_id = ? and borrow_status = ?",3, 2])
    @book_I_borrow_recup_tab=Borrow.where(["user_id = ? and borrow_status = ?",3, 3])

    #Mes demandes d'emprunt envoyé :

    @book_asked_to_borrow = Borrow.where(["user_id = ? and borrow_status = ?",3, 0])

  end
end
