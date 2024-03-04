# frozen_string_literal: true

# class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   user = User.find_by(email: params[:user][:email])
  #   redirect_to new_user_session_path, alert: "Utilisateur inconnu" unless user

  #   if user && user.valid_password?(params[:user][:password])
  #     sign_in(user)
  #     redirect_to root_path, notice: "Vous êtes maintenant connecté!"
  #   elsif user && !user.valid_password?(params[:user][:password])
  #     redirect_to new_user_session_path, alert: "Mauvais mot de passe"
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
# end
