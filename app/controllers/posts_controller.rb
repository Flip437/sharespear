class PostsController < ApplicationController

  
  def new
    puts "in newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww of comments controller"
  end

  def create

  end

  private

  def comment_params
    params.require(:post).permit(:content)
  end
  
end