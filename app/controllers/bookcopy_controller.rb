
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
      else
        @book_infos=doc['items'][0]['volumeInfo']
        @new_book_copy = BookCopy.new
        @new_book_copy.title=@book_infos['title']
        @new_book_copy.author=@book_infos['authors'][0]
        @new_book_copy.description=@book_infos['description']
        @new_book_copy.status=true
        @new_book_copy.category=@book_infos['categories']
        @new_book_copy.user_id= current_user.id
        @new_book_copy.isbn= @isbn
        @new_book_copy.save

        puts @new_book_copy.inspect

      end

    end



end
