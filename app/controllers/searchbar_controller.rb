class SearchbarController < ApplicationController
    
    def index
        @book_copy_array = BookCopy.search(params[:search1], params[:search2])
        puts @book_copy_array
    end

end
