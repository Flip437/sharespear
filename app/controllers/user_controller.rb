class UserController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.new
  end


  def edit
    @user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @user_library = BookCopy.where(user_id:@user.id)
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

      flash[:success] = "updated"

    else
      flash[:error] = "Sorry, you need to enter your password"
    end
    redirect_to edit_user_path(current_user.id)
  end
end
