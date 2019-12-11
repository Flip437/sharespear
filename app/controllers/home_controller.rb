class HomeController < ApplicationController
  def index

    if current_user

      @user_around_tab = User.where(zip_code: current_user.zip_code)
      @book_copy_array_all = []

      @user_around_tab.each { |n| @book_copy_array_all = (@book_copy_array_all << n.book_copies).flatten! }

      @book_copy_array = []

      @length_tab_book_copy_all = @book_copy_array_all.length

      array = []
      9.times do |i|
        puts "Iteration #{i} -------------------------"
        x = rand @length_tab_book_copy_all
        redo if array.include?(x).tap{ |type| puts "does array include #{x}? #{type ? "yes" : "no"}" }
        puts "x=#{x}, i=#{i}"
        array[i] = x
        puts "#{array[i]} is in the array"
      end



      @book_copy_array[0] = @book_copy_array_all[array[0]]
      @book_copy_array[1] = @book_copy_array_all[array[1]]
      @book_copy_array[2] = @book_copy_array_all[array[2]]
      @book_copy_array[3]= @book_copy_array_all[array[3]]
      @book_copy_array[4]= @book_copy_array_all[array[4]]
      @book_copy_array[5] = @book_copy_array_all[array[5]]
      @book_copy_array[6] = @book_copy_array_all[array[6]]
      @book_copy_array[7]= @book_copy_array_all[array[7]]
      @book_copy_array[8] = @book_copy_array_all[array[8]]

      @length_tab_book_copy =  @book_copy_array.length

      puts @book_copy_array

    else
      @book_copy_array = BookCopy.all
    end

  end

  def recherche

  end
end
