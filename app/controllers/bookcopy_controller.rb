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
    puts params
    puts "SESSIONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
    @new_book_copy = BookCopy.new
    @book_infos = @new_book_copy.newbook(params[:book_copy])[0]
    @isbn = @new_book_copy.newbook(params[:book_copy])[1]
  end

    def create
      @new_book_copy = BookCopy.new
      puts 'IN CONTROLEERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'
      puts session
      puts session
      puts 'IN CONTROLEERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'
      @book_infos = @new_book_copy.createbook(session[:book_infos], session[:isbn])
      puts @book_infos


      @new_book_copy = BookCopy.create(
        title:  @book_infos[0]["title"],
        author: @book_infos[0]["authors"][0],
        description: @book_infos[0]["description"],
        status: true,
        category: @book_infos[0]["categories"],
        user_id: current_user.id,
        photo_link: @book_infos[1],
        isbn: @book_infos[2]
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
