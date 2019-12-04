class BorrowController < ApplicationController

    def new
        puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
        puts params
        puts "PARAMSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
        @borrow = Borrow.new
        @book = BookCopy.find(params[:bookcopy_id])
    end

    def create
puts "IN CREATEEEEEEEEEEEEEEEEEEEEE"
        @borrow = Borrow.new(borrow_params)
        @borrow.user_id = current_user.id
        @borrow.start_date = Date.today
        duree = params[:borrow][:duree]
        @borrow.end_date = Date.today >> duree.to_i
        @borrow.borrow_status = 1
        @borrow.book_copy_id = params[:bookcopy_id]
        
        puts "borow elementttttttttttttttttttttttttttttttttttttttttttt"
        puts @borrow.start_date
        puts @borrow.end_date
        puts @borrow.message
        puts @borrow.borrow_status
        puts @borrow.user_id
        puts @borrow.book_copy_id
        puts "borow elementttttttttttttttttttttttttttttttttttttttttttt"

        @borrow.save
        flash[:notice] = "Borrow successfully created"
        redirect_to root_path
    end

    def borrow_params
        params.require(:borrow).permit(:message)
    end

end