class UserController < ApplicationController

  def edit

  end

  def show

    @user_library = BookCopy.where(user_id:current_user)

  end
end
