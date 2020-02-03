# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    @email = params[:user][:email]
    if User.find_by(email: @email) == nil
      flash[:error] = "Tu n'as pas de compte utilisateur, merci d'en créer un :)"
    elsif User.find_by(email: @email).confirmed? == false
      flash[:error] = "Merci de confirmer ton email avant de te connecter"
    end
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
