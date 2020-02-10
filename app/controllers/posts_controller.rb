class PostsController < ApplicationController

  def new
  end

  def update
    @post = Post.find(params[:id])
    @post.like += 1
    @post.save
    redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @book = BookCopy.find(params[:bookcopy_id])
      @post.book_copy = @book      
      
      @bookid = params[:bookcopy_id]
      @ajaxindex = Post.where("book_copy_id = #{@bookid}").count

      if @post.save
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
          puts @post.errors
          flash[:error] = "Désolé, il y a eu une erreur :("
>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end

  def destroy

    @post = Post.find(params[:id])
<<<<<<< HEAD
    @post.comments.destroy_all

    @loopindex = params[:loopindex]
    @btn = ".postbtndel#{@loopindex}"
    @postdiv = ".post#{@loopindex}"

    if @post.destroy
=======
    @post.content = "deleted"
    @post.like = 0
    @post.status = 0
    @post.save

    if @post.save
      flash[:success] = "Ton commentaire a bien été posté :)"
      #redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
      respond_to do |f|
        f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
        f.js 
      end
    else
<<<<<<< HEAD
      flash[:error] = "Désolé, il y a eu une erreur"
=======
      puts @post.errors
      flash[:error] = "Désolé, il y a eu une erreur :("
>>>>>>> 890c1777df6ea11e4c0491d7219c4b2ca53337e2
      redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
