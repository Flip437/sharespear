class PostsController < ApplicationController

  def new
  end

  def show
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @post.book_copy = BookCopy.find(params[:bookcopy_id])

      if @post.save
          flash[:success] = "Ton commentaire a bien été posté"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      else
          puts @post.errors
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
  
end