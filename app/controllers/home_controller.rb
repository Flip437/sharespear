class HomeController < ApplicationController

  def index

    if current_user

      puts "HOMEMEMEMMEMEME ICICICICIICICICICICICIICICICICICIICIC"

      @user_around_tab = User.where(zip_code: current_user.zip_code)
      @book_copy_array_all = []

      @user_around_tab.each { |n| @book_copy_array_all = (@book_copy_array_all << n.book_copies).flatten! }

      @book_copy_array = []

      @length_tab_book_copy_all = @book_copy_array_all.length

      #puts @length_tab_book_copy_all

      array = []
      20.times do |i|
        #puts "Iteration #{i} -------------------------"
        x = rand (@length_tab_book_copy_all)
        redo if array.include?(x)
        array[i] = x
      end

      puts @book_copy_array_all.length

      if @book_copy_array_all.length>20

        20.times do |i|
          @book_copy_array[i] = @book_copy_array_all[array[i]]
        end
      else
        @book_copy_array_all.length.times do |i|
          @book_copy_array[i] = @book_copy_array_all[array[i]]
        end
      end

      @length_tab_book_copy =  @book_copy_array.length

    end

  end

end
