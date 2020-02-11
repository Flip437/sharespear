class UserController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.new
    @quartiers = ["aa", "bb"]
  end


  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @user_library = BookCopy.where(user_id: @user.id, status: [0,1] )
    @user_follow = Follow.where(user_id: @user.id, active: true)
    @user_follow_query = Follow.where(user_id: current_user.id, follow_user_id: @user.id, active: true).first
    @usercomment_array = @user.usercomments

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
    user = User.find_by_email(params[:user][:email])

    if user.valid_password?(params[:user][:password])
      user_to_change = User.find(current_user.id)
      user_to_change.update(first_name: params[:user][:first_name])
      user_to_change.update(last_name: params[:user][:last_name])
      user_to_change.update(description: params[:user][:description])
      user_to_change.update(city: params[:user][:city])
      user_to_change.update(zip_code: params[:user][:zip_code])
      user_to_change.update(street: params[:user][:street])
      user_to_change.update(street_nb: params[:user][:street_nb])
      user_to_change.update(phone: params[:user][:phone])

      flash[:success] = "Tes informations ont été mises à jour ! :)"

    else
      flash[:error] = "Erreur, peux tu entrer ton mot de passe svp :|"
    end
    redirect_to edit_user_path(current_user.id)
  end
end
