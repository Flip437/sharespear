class BookcopyController < ApplicationController

    def show
        puts params
        @book = BookCopy.find(params[:id])
        puts @book.title
    end

end