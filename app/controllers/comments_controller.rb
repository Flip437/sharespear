class CommentsController < ApplicationController

  def new
  end

  def update
    puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    puts params
    @comment = Comment.find(params[:id])
    @comment.like += 1
    @comment.save
    redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
  end

  def create
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @book = BookCopy.find(params[:bookcopy_id])
      @post = Post.find(params[:post_id])
      @comment.post = @post

      if @comment.save
          respond_to do |f|
            f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
            f.js 
          end
      else
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    @loopindex = params[:loopindex]
    @btn = ".combtndel#{@loopindex}"
    @comdiv = ".com#{@loopindex}"
  
    if @comment.destroy
      respond_to do |f|
        f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
        f.js 
      end

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