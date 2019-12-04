class HomeController < ApplicationController
  def index
    @book_copy_array = BookCopy.all
  end
end