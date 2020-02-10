class CommentsController < ApplicationController

  def new
  end

  def update
<<<<<<< HEAD
=======

>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
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

      @bookid = params[:bookcopy_id]
      @postid = params[:post_id]
      @ajaxindex = Comment.where("post_id = #{@postid}").count

      if @comment.save
<<<<<<< HEAD
          respond_to do |f|
            f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
            f.js 
          end
      else
          flash[:error] = "Désolé, il y a eu une erreur"
=======
          flash[:success] = "Ton commentaire a bien été posté :)"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      else

          flash[:error] = "Désolé, il y a eu une erreur :("
>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end


  def destroy
<<<<<<< HEAD
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

=======

    @comment = Comment.find(params[:id])
    @comment.content = "deleted"
    @comment.like = 0
    @comment.status = 0
    @comment.save

    if @comment.save
      flash[:success] = "Ton commentaire a bien été posté :)"
      redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      # respond_to do |f|
      #   f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
      #   f.js
      # end
>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
    else
      puts @comment.errors
      flash[:error] = "Désolé, il y a eu une erreur :("
      redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
