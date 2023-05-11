class PostsController < ApplicationController

  def new
  end

  def update
    @post = Post.find(params[:id])
    @post.like += 1
    @post.save
    redirect_to book_copy_path(BookCopy.find(params[:book_copy_id]))
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      @book = BookCopy.find(params[:book_copy_id])
      @post.book_copy = @book      
      
      @bookid = params[:book_copy_id]
      @ajaxindex = Post.where("book_copy_id = #{@bookid}").count

      if @post.save
          respond_to do |f|
            f.html { redirect_to book_copy_path(BookCopy.find(params[:book_copy_id])) }
            f.js 
          end
      else
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to book_copy_path(BookCopy.find(params[:book_copy_id]))
      end
  end

  def destroy

    @post = Post.find(params[:id])
    @post.comments.destroy_all

    @loopindex = params[:loopindex]
    @btn = ".postbtndel#{@loopindex}"
    @postdiv = ".post#{@loopindex}"

    if @post.destroy
      respond_to do |f|
        f.html { redirect_to book_copy_path(BookCopy.find(params[:book_copy_id])) }
        f.js 
      end
    else
      flash[:error] = "Désolé, il y a eu une erreur"
      redirect_to book_copy_path(BookCopy.find(params[:book_copy_id]))
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
