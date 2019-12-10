class HomeController < ApplicationController
  def index

    if current_user
      @book_copy_array = BookCopy.all
    else
      @book_copy_array = BookCopy.all
    end

  end

  def recherche

  end
end
