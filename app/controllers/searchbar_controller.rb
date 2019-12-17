class SearchbarController < ApplicationController

    def index
        @book_copy_array = BookCopy.search(params[:search1],'Lyon')
    end

end
