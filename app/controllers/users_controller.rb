class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: %i[show update edit]
  #PROVISOIRE, à supprimer quand !authenticate user sera rétabli
  # before_action :set_current_user_as_params_user

  def create
    @user = User.new
    @quartiers = ["aa", "bb"]
  end


  def edit
    @user = User.find(current_user.id)
  end

  def dashboard
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

  def show
    @user_follow = Follow.where(user_id: @user.id, active: true)
    @user_follow_query = Follow.where(user_id: current_user.id, follow_user_id: @user.id, active: true).first
    @usercomment_array = @user.received_comments

    @zip_name = ""
    zip = @user.zip_code

    if zip=="69001"
      @zip_name = "Lyon 1 - Terreaux"
    end
    if zip=="69002"
      @zip_name = "Lyon 2 - Bellecour"
    end
    if zip=="69003"
      @zip_name = "Lyon 3 - La Part-Dieu"
    end
    if zip=="69004"
      @zip_name = "Lyon 4 - Croix-Rousse"
    end
    if zip=="69005"
      @zip_name = "Lyon 5 - Vieux Lyon"
    end
    if zip=="69006"
      @zip_name = "Lyon 1 - Terreaux"
    end
    if zip=="69007"
      @zip_name = "Lyon 7 - Jean Macé"
    end
    if zip=="69008"
      @zip_name = "Lyon 8 - Monplaisir"
    end
    if zip=="69009"
      @zip_name = "Lyon 9 - Vaise"
    end
    if zip=="69100"
      @zip_name = "Villeurbanne"
    end
    if zip=="69100"
      @zip_name = "Villeurbanne"
    end
    if zip=="69300"
      @zip_name = "Caluire-et-Cuire"
    end
    if zip=="69142"
      @zip_name = "La Mulatière"
    end
    if zip=="69160"
      @zip_name = "Tassin-la-Demi-Lune"
    end
    if zip=="69130"
      @zip_name = "Écully"
    end
    if zip=="69600"
      @zip_name = "Oullins"
    end
    if zip=="69500"
      @zip_name = "Bron"
    end
  end

  def update
    unless @user.valid_password?(user_params.to_h[:password])
      flash[:error] = "Erreur, peux tu entrer ton mot de passe svp :|"
      redirect_to edit_user_path(current_user.id)
    end

    if @user.update(user_params.to_h)
      flash[:success] = "Tes informations ont été mises à jour ! :)"
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de tes données"
    end
    redirect_to edit_user_path(current_user.id)
  end

  private

  def set_current_user_as_params_user
    current_user = User.find(params[:id])
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email, #when passing email to params, user gets unlogged
      :description,
      :city,
      :zip_code,
      :street,
      :street_nb,
      :phone,
      :password
    )
  end
end
