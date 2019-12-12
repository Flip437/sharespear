class HomeController < ApplicationController

  def new
  end
  
  def create
    # Amount in cents
    @amount = params[:montant].to_i * 100
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end




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

      @dropD = []
      d = 0
      @book_copy_array.length.times do |i|
        if @dropD.include?(@book_copy_array[i].category)
        else
           @dropD[d] = @book_copy_array[i].category
           d=d+1
        end

      end

    end

    if params[:category_selected]

      cate = params[:category_selected]
      if cate == "All"

        @book_copy_filteredv2 = @book_copy_array

      else
        @book_copy_filteredv2 = @book_copy_array_all.select { |book| book.category == cate }
      end

    end

    respond_to do |format|
      format.html{}
      format.js{}
    end



  end

end