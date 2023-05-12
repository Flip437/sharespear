class DashboardController < ApplicationController
  # before_action :authenticate_user!
  def index
    #Mes livres prêté
    @book_copy_not_available_tab=current_user.book_copy_not_available_tab

    #Demandes de prêt reçu
    @ask_book_tab = Borrow.where(borrowed_user: current_user)
    #Mes emprunts
    @book_I_borrow_tab = current_user.book_I_borrow_tab
    @book_I_borrow_recup_tab = current_user.book_I_borrow_recup_tab
    # @book_asked_to_borrow = Borrow.where(borrower_user: current_user, borrow_status: Borrow::ACCEPTED)
    #Mes demandes d'emprunt envoyé :
    # @book_asked_to_borrow = @user.book_asked_to_borrow
    @pending_borrows = Borrow.where(borrower_user: current_user, borrow_status: Borrow::PENDING)
  end

  def update
    @borrow = Borrow.find_by(book_copy_id:params[:id])
    UserMailer.askbookback(@borrow).deliver_now
    redirect_to user_dashboard_index_path(current_user.id)
  end

end