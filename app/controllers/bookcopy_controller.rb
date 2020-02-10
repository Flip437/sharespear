require 'nokogiri'
require 'open-uri'
class BookcopyController < ApplicationController
before_action :authenticate_user!

  def show
      @book = BookCopy.find(params[:id])
      @url = 'http://covers.openlibrary.org/b/isbn/#{@book.isbn}.jpg'
      @post_array = @book.posts



  end

  def new
    @new_book_copy = BookCopy.new
    #if params[:book_copy]
    #session.delete(:book_info)
    #session.delete(:isbn)
    #@isbn = params[:book_copy]["isbn"].gsub(/[.\s]/, '')
    #@book_infos = @new_book_copy.newbook(@isbn)

    #session[:book_info] = @book_infos
    #session[:isbn] = @isbn
    #end
    if params[:book_copy]
      session.delete(:book_info)

      @title = params[:book_copy]["title"].gsub(/[.\s]/, '')




      @book_infos_table=[]
      book_infos1 = @new_book_copy.newbook_title(@title,0)

      if book_infos1 != "0"

          attributs1 = @new_book_copy.createif(book_infos1)
          @book_infos_table << attributs1



          book_infos2 = @new_book_copy.newbook_title(@title,1)
          if book_infos2 != "0"

              attributs2 = @new_book_copy.createif(book_infos2)
              @book_infos_table << attributs2


              book_infos3 = @new_book_copy.newbook_title(@title,2)
              if book_infos3 != "0"

                  attributs3 = @new_book_copy.createif(book_infos3)
                  @book_infos_table << attributs3
              end

          end

    

      else

        @book_infos_table=0

      end

      session[:book_info] =  @book_infos_table

    end
  end

  def create
    numero_selected = params[:numero_selected]
    book_information = session[:book_info][numero_selected.to_i]


    new_book_copy = BookCopy.create(
      title:  book_information[0],
      author: book_information[1],
      description: book_information[2],
      status: 1,
      category: book_information[3],
      user_id: current_user.id,
      photo_link: book_information[4],
      isbn: book_information[5]
    )

    if new_book_copy
      flash[:success] = "Livre ajouté à votre bibliothèque:)"
      redirect_to new_bookcopy_path
    else
      flash[:error] = "Erreur d'ajout du livre :("
      redirect_to new_bookcopy_path
    end

  end

  def destroy

    book = BookCopy.find(params[:id])
    book.status=2
    borrows_book = Borrow.where({ book_copy_id: book.id })
    borrows_book.each do |book|
      book.borrow_status=2
      book.save
    end
    book.save

    if book.status==2
      flash[:success] = "Livre supprimé :)"
        redirect_to user_path(current_user.id)
    else
      flash[:error] = "Erreur de suppression :("
        redirect_to user_path(current_user.id)
    end
  end

end
