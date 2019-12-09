class BookcopyController < ApplicationController
    before_action :authenticate_user!

    def show
        puts params
        @book = BookCopy.find(params[:id])
        puts @book.title
    end



end
