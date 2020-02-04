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

      if @post.save
          flash[:success] = "Ton commentaire a bien été posté"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      else
          puts @post.errors
          flash[:error] = "Désolé, il y a eu une erreur"
          redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
      end
  end

  def destroy
    puts params
    @post = Post.find(params[:id])
    @post.content = "deleted"
    @post.like = 0
    @post.status = 0
    @post.save
    
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