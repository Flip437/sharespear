
require 'nokogiri'
require 'open-uri'
class BookcopyController < ApplicationController
    before_action :authenticate_user!

    def show
        puts params
        @book = BookCopy.find(params[:id])
        puts @book.title
    end

    def new

      @new_book_copy = BookCopy.new

    end

    def create

      @new_book_copy = BookCopy.new
      puts params.inspect
      @isbn = params[:book_copy][:isbn].gsub(/[.\s]/, '')
      puts @isbn
      

      #@isbn=9780753555200
      url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + @isbn.to_s
      doc=JSON.load(open(url))

      if doc["totalItems"]==0
        puts "AIE AIE AIE"
        redirect_to new_bookcopy_path
      else

        @book_infos=doc['items'][0]['volumeInfo']
        @new_book_copy = BookCopy.create(title: @book_infos['title'],
          title:  @book_infos['title'],
          author: @book_infos['authors'][0],
          description: @book_infos['description'],
          status: true,
          category: @book_infos['categories'],
          user_id: current_user.id,
          isbn: @isbn.to_s

        )



        puts @new_book_copy.inspect

        redirect_to new_bookcopy_path

      end

    end



end
