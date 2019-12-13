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
    @new_book_copy = BookCopy.new
    if params[:book_copy]
    session.delete(:book_info)
    session.delete(:isbn)
    @isbn = params[:book_copy]["isbn"].gsub(/[.\s]/, '')
    @book_infos = @new_book_copy.newbook(@isbn)

    session[:book_info] = @book_infos
    session[:isbn] = @isbn
    end

  end

  def create
    @book_infos = session[:book_info]
    @isbn = session[:isbn]
    bookcopy = BookCopy.new
    attributs = bookcopy.createif(@book_infos)

    new_book_copy = BookCopy.create(
      title:  attributs[0],
      author: attributs[1],
      description: attributs[2],
      status: true,
      category: attributs[3],
      user_id: current_user.id,
      photo_link: attributs[4],
      isbn: @isbn
    )

    if new_book_copy
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
