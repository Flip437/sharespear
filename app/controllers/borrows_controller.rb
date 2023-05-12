class BorrowsController < ApplicationController
  # before_action :authenticate_user!
  before_action :find_book_copy, only: %i[new create show update]
  before_action :find_borrow, only: %i[show update]
  def new
    @borrow = Borrow.new
    @user = User.find(current_user.id)
  end

  def create
    borrow = Borrow.new(borrow_params)
    # borrow.user = current_user
    borrow.borrower_user = current_user
    borrow.borrowed_user = @book_copy.user
    borrow.book_copy = @book_copy
    borrow.start_date = Date.today
    borrow.end_date = Date.today >> params[:borrow][:duree].to_i
    borrow.borrow_status = Borrow::PENDING

    if borrow.save
      flash[:success] = "Votre demande d'emprunt a été transmise :)"
      redirect_to root_path
    else
      flash[:error] = "Désolé, votre demande d'emprunt n'a pas fonctionné :("
      redirect_to root_path
    end
  end

  def show
    @user_preteur = @borrow.borrowed_user
    @user_emprunteur = @borrow.borrower_user
  end

  def update
    # debugger
    # brrow status 1 refusé
    # brrow status 2 accepté
    # brrow status 3 livre récupéré

    # book_copy status 0
    # book_copy status 1 livre récupéré

    if @borrow.update(borrow_params)
      flash[:success] = "Vos modifications ont bien été enregistrées"
      redirect_to user_dashboard_index_path(current_user)
    else
      flash[:error] = "Désolé, une erreur s'est produite"
      render :show
    end

    bouton_value= params[:bouton_value]
    # Demande de pret refuse
    if bouton_value=='0'
      @borrow = Borrow.find(params[:id])
      @borrow.update(borrow_status:1)
      # UserMailer.borrow_declined_email(@borrow).deliver_now
    # Demande de pret accepte
    elsif bouton_value=='1'
      @borrow = Borrow.find(params[:id])
      @borrow.update(borrow_status:2)
      # UserMailer.borrow_accepted_email(@borrow).deliver_now
      book_copy_status_update = BookCopy.find(params[:book_copy_id])
      book_copy_status_update.update(status: 0)
    # Livre recupere
    elsif bouton_value=='2'
      @borrow = Borrow.find(params[:id])
      book_copy_status_update = BookCopy.find(params[:book_copy_id])
      @borrow.update(borrow_status:3)
      book_copy_status_update.update(status: 1)
      # UserMailer.borrow_book_rendered_email(@borrow).deliver_now
      #passe à refusé tous les autres
      book_copy = BookCopy.find(@borrow.book_copy_id)
      book_borrow_tab = book_copy.borrow_status_accepted?
      book_borrow_tab.each do |n|
        n.update(borrow_status:1)
      end

    # Livre recupere
    elsif bouton_value=='2'
      @borrow = Borrow.find(params[:id])
      book_copy_status_update = BookCopy.find(params[:book_copy_id])
      @borrow.update(borrow_status:3)
      book_copy_status_update.update(status: 1)
      # UserMailer.borrow_book_rendered_email(@borrow).deliver_now
    end
  end

  private

  def find_borrow
    @borrow = Borrow.find(params[:id])
  end

  def borrow_params
    params.require(:borrow).permit(
      :message,
      :borrow_status
    )
  end

  def find_book_copy
    @book_copy = BookCopy.find(params[:book_copy_id])
  end
end
