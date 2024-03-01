# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    return flash[:error] = "Tu n'as pas de compte utilisateur, merci d'en créer un :)" unless user
    return flash[:error] = "Merci de confirmer ton email avant de te connecter :D" unless user.confirmed?

    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
