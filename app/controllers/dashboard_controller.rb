class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    #Mes livres prêté
    @user=User.find(current_user.id)
    @book_copy_not_available_tab=@user.book_copy_not_available_tab

    #Demandes de prêt reçu
    book_copy_available_tab=@user.book_copy_available_tab
    @ask_book_tab=[]
    book_copy_available_tab.each do |n|
      tab=n.borrow_status_0?
      if(tab.empty?)
      else
        @ask_book_tab=tab+@ask_book_tab
      end
    end
    puts @ask_book_tab
    #Mes emprunts
    @book_I_borrow_tab=@user.book_I_borrow_tab
    @book_I_borrow_recup_tab=@user.book_I_borrow_recup_tab
    #Mes demandes d'emprunt envoyé :
    @book_asked_to_borrow = @user.book_asked_to_borrow

  end

  def update
    @borrow = Borrow.find_by(book_copy_id:params[:id])
    UserMailer.askbookback(@borrow).deliver_now
    #redirect_to user_dashboard_index_path(current_user)
  end

end