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
    puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    puts params
    puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    puts "POSTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
    puts params[:loopindex]
    puts "POSTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
    @loopindex = params[:loopindex]

    @post = Post.find(params[:id])
    @post.content = "deleted"
    @post.like = 0
    @post.status = 1
    @post.save
    
    @btn = ".postbtndel#{@loopindex}"
    @postdiv = ".post#{@loopindex}"
    puts "BTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
    puts @btn
    puts "BTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
    if @post.save
      flash[:success] = "Ton commentaire a bien été posté"
      #redirect_to bookcopy_path(BookCopy.find(params[:bookcopy_id]))
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