
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

        puts params.inspect
        @isbn = params[:book_copy][:isbn].gsub(/[.\s]/, '')
        puts @isbn

        url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + @isbn.to_s
        doc=JSON.load(open(url))


        if doc["totalItems"]==0
          @book_infos = -1
        else

          @book_infos = JSON.load(open(url))['items'][0]['volumeInfo']

        end

      end

    end

    def create

      @new_book_copy = BookCopy.create(
        title:  params[:title],
        author: params[:authors][0],
        description: params[:description],
        status: true,
        category: params[:categories][0],
        user_id: current_user.id,
        isbn: params[:industryIdentifiers][0][:identifier]
      )

      if @new_book_copy
        flash[:success] = "Livre ajouté :)"
        redirect_to new_bookcopy_path
      else
        flash[:error] = "Erreur d'ajout :("
        redirect_to new_bookcopy_path
      end

    end



end
