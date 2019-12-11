class HomeController < ApplicationController
  def index
    @book_copy_array = BookCopy.search(params[:search])
    puts params[:search1]
    puts params[:search2]
  end

  def search
    @book_copy_array = BookCopy.search(params[:search1])
    @bookcopytab = []
  
    @userlyon = User.where(city:"Lyon")
    @userlyon.each do |user|
      @bookcopytab = @bookcopytab << user.book_copies
    end
    puts "BOOKCOPYTABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
puts @bookcopytab
    puts "BOOKCOPYTABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
  end
end