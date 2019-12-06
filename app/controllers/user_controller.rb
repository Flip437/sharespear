class UserController < ApplicationController

  def edit

    @user = User.find(current_user.id)

  end

  def show

    @user_library = BookCopy.where(user_id:current_user)

  end

  def update

    puts "ICICIICICIiiiiiiiiiiiiiiiiI"

    puts params.inspect
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

      flash[:success] = "updated"

    else

      flash[:error] = "Sorry, you need to enter your password"


    end



    redirect_to edit_user_path(current_user.id)

  end
end
