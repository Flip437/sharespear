class SearchbarController < ApplicationController

    def index
        if params[:search1] == ""
          @book_copy_array =  []
        else
          @book_copy_array = BookCopy.search(params[:search1], 'Lyon')
        end

    end

end
