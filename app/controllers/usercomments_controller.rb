class UsercommentsController < ApplicationController

  def create
      @usercomment = Usercomment.new(usercomment_params)
      @user = current_user
      @usercomment.user = @user

      @userid = params[:user_id]
      @ajaxindex = Usercomment.where("user_id = #{@userid}").count

      if @usercomment.save
          respond_to do |f|
            f.html { redirect_to user_path(User.find(params[:user_id])) }
            f.js 
          end
      else
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to user_path(User.find(params[:user_id]))
      end
  end


  def destroy
    @usercomment = Usercomment.find(params[:id])
    @usercomment.destroy

    @loopindex = params[:loopindex]
    @btn = ".postbtndel#{@loopindex}"
    @postdiv = ".post#{@loopindex}"
  
    if @usercomment.destroy
      respond_to do |f|
        f.html { redirect_to user_path(User.find(params[:user_id])) }
        f.js 
      end

    else
      puts @usercomment.errors
      flash[:error] = "Désolé, il y a eu une erreur :("
      redirect_to user_path(User.find(params[:user_id]))
    end
  end

  private

  def usercomment_params
    params.require(:post).permit(:content)
  end

end
