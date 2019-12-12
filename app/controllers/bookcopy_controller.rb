require 'nokogiri'
require 'open-uri'
class BookcopyController < ApplicationController
before_action :authenticate_user!

  def show
      puts params
      @book = BookCopy.find(params[:id])
      @url = 'http://covers.openlibrary.org/b/isbn/#{@book.isbn}.jpg'
  end

  def new
    puts "SESSIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
    puts session[:book_infos]
    puts params[:book_copy]
    puts "SESSIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
    @new_book_copy = BookCopy.new
    @book_infos = @new_book_copy.newbook(params[:book_copy])[0]
    @isbn = @new_book_copy.newbook(params[:book_copy])[1]
  end

      end

    end

    def create

      @book_infos = session[:book_infos]
      @isbn = session[:isbn]
      puts "$$$$$$$$$$$$"
      puts @book_infos
      puts "$$$$$$$$$$$$"

      if @book_infos['imageLinks']
        photo = @book_infos['imageLinks']['thumbnail']
      else
        photo= "http://books.google.com/books/content?id=1IyauAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
      end

      if  @book_infos["categories"]==nil
        category = "other"
      else
        category = @book_infos["categories"][0]
      end

      if  @book_infos["description"]==nil
        description = "laisse toi tenter"
      else
        description = @book_infos["description"]
      end

      @new_book_copy = BookCopy.create(
        title:  @book_infos["title"],
        author: @book_infos["authors"][0],
        description: description,
        status: true,
        category: category,
        user_id: current_user.id,
        photo_link: photo,
        isbn: @isbn
      )

      if @new_book_copy
        flash[:success] = "Livre ajouté :)"
        redirect_to new_bookcopy_path
      else
        flash[:error] = "Erreur d'ajout :("
        redirect_to new_bookcopy_path
      end

    end


  def destroy
    book = BookCopy.find(params[:id])
    if book.delete
      flash[:success] = "Livre supprimé :)"
        redirect_to user_path(current_user.id)
    else
      flash[:error] = "Erreur :("
        redirect_to user_path(current_user.id)
    end
  end

end
