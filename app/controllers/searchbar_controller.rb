class SearchbarController < ApplicationController
  autocomplete :book_copy, :title

    def index

        @book_copy_array = BookCopy.search(params[:search1], 'Lyon')
    end

end
