class BorrowController < ApplicationController
    before_action :authenticate_user!
    def new
        @borrow = Borrow.new
        @book = BookCopy.find(params[:bookcopy_id])
    end

    def create
        @borrow = Borrow.new(borrow_params)
        @borrow.user_id = current_user.id
        @borrow.start_date = Date.today
        duree = params[:borrow][:duree]
        @borrow.end_date = Date.today >> duree.to_i
        @borrow.borrow_status = 0
        @borrow.book_copy_id = params[:bookcopy_id]

        puts "borow elementttttttttttttttttttttttttttttttttttttttttttt"
        puts @borrow.start_date
        puts @borrow.end_date
        puts @borrow.message
        puts @borrow.borrow_status
        puts @borrow.user_id
        puts @borrow.book_copy_id
        puts "borow elementttttttttttttttttttttttttttttttttttttttttttt"

        if @borrow.save
            flash[:success] = "Borrow successfully created"
            redirect_to root_path
        else
            puts @borrow.errors
            flash[:error] = "Sorry, you're borrow didn't work"
            redirect_to root_path
        end

    end


    def update

      puts "UPDATE"
      puts params.inspect
      bouton_value= params[:bouton_value]
      puts bouton_value

      # Demande de pret refuse
      if bouton_value=='0'
        borrow_to_update = Borrow.find(params[:id])
        borrow_to_update.update(borrow_status:1)
        #UserMailer.borrow_declined_email(borrow_to_update).deliver_now

      # Demande de pret accepte
      elsif bouton_value=='1'

        borrow_to_update = Borrow.find(params[:id])
        borrow_to_update.update(borrow_status:2)
        #UserMailer.borrow_accepted_email(borrow_to_update).deliver_now
        book_copy_status_update = BookCopy.find(params[:bookcopy_id])
        book_copy_status_update.update(status: false)

        #passe à refusé tous les autres
        book_copy = BookCopy.find(borrow_to_update.book_copy_id)
        book_borrow_tab = book_copy.borrow_status_0?
        book_borrow_tab.each do |n|
          n.update(borrow_status:1)
        end




      # Livre recupere
      elsif bouton_value=='2'
        borrow_to_update = Borrow.find(params[:id])
        book_copy_status_update = BookCopy.find(params[:bookcopy_id])
        borrow_to_update.update(borrow_status:3)
        book_copy_status_update.update(status: true)
        #UserMailer.borrow_book_rendered_email(borrow_to_update).deliver_now
      end

      redirect_to user_dashboard_index_path(current_user)

    end

    def show
      @borrow_to_show = Borrow.find(params[:id])
      @book_to_show = BookCopy.find(params[:bookcopy_id])
      @user_preteur = User.find(@book_to_show.user_id)
      @user_emprunteur = User.find(@borrow_to_show.user_id)
    end

    def borrow_params
        params.require(:borrow).permit(:message)
    end

end
