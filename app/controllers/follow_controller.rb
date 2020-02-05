class FollowController < ApplicationController

  def create

    puts params.inspect
    follow = Follow.new
    follow.user_id = current_user.id
    follow.follow_user_id = params["user_id"]
    follow.active = true

    if follow.follow_already_exist?
      flash[:error] = "Tu ne peux pas follow deux fois la même personne :("
      redirect_to user_path(params["user_id"])
    else

      if follow.save
        flash[:success] = "Follow ajouté :)"
        redirect_to user_path(params["user_id"])
      else
        flash[:error] = "Erreur d'ajout du Follow :("
        redirect_to user_path(params["user_id"])
      end

    end

  end

  def destroy

    puts params.inspect

    follow_destroy = Follow.find(params[:id])

    if follow_destroy.delete
      flash[:success] = "Tu ne le suis plus :) "
      redirect_to user_path(params["user_id"])
    else
      puts follow_destroy.delete
      flash[:error] = "Désolé, il y a eu une erreur"
      redirect_to user_path(params["user_id"])
    end



  end

  def show

  end

end
