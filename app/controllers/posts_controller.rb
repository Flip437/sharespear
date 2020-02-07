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
      @bookid = params[:bookcopy_id]
      @book = BookCopy.find(params[:bookcopy_id])
      @post.book_copy = @book
      @lastindex = Post.where("book_copy_id = 1").last.id


      puts "last indexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      puts @lastindex

      if @post.save
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

    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy

    @loopindex = params[:loopindex]
    @btn = ".postbtndel#{@loopindex}"
    @postdiv = ".post#{@loopindex}"


    if @post.destroy
      respond_to do |f|
        f.html { redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id])) }
        f.js 
      end
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