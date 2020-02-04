class CommentsController < ApplicationController

  def new
  end

  def show
  end

  def create
    puts "IN CREATEEEEEEEEEEEEEEEEEEEEEEEEEEEEE Of comment controller"
    puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    puts params
    puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @book = BookCopy.find(params[:bookcopy_id])
      @post = Post.find(params[:post_id])
      @comment.post = @post

      if @comment.save
          flash[:success] = "Ton commentaire a bien été posté"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      else
          puts @comment.errors
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
end