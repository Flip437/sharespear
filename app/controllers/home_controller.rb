class HomeController < ApplicationController
  before_action :authenticate_user!

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
        @avatar_array = ['sharespeare1.png', 'sharespeare2.png','sharespeare3.png','sharespeare4.png','sharespeare5.png','sharespeare6.png','sharespeare7.png','sharespeare8.png']


        if current_user
          @zip_name = User::ZIP_CODES_NAMES[current_user.zip_code]
          user_around_tab = User.where(zip_code: current_user.zip_code.to_sym, deleted_at: nil)
          book_copy_array_all = []

          if user_around_tab.first.book_copies
            user_around_tab.each { |n| book_copy_array_all = (book_copy_array_all << n.book_copies).flatten! }
            @near_availabled_book_copies = []

            book_copy_array_all.reject! {|book| book.status == 2}

            @length_tab_book_copy_all = book_copy_array_all.length


            @near_availabled_book_copies = BookCopy.where.not(status: '2')
                                       .joins(:user)
                                       .where(users: {zip_code: current_user.zip_code})
                                       .order("RANDOM()").limit(20)

            @length_tab_book_copy =  @near_availabled_book_copies.length


            @dropD = []
            d = 0
            book_copy_array_all=book_copy_array_all.shuffle
            @length_tab_book_copy_all.times do |i|
              if @dropD.include?(book_copy_array_all[i].category)
              else
                @dropD[d] = book_copy_array_all[i].category
                d=d+1
              end
              @dropD = @dropD.sort

            end

          end
          @user = User.find(current_user.id)

          if params[:category_selected]
            @ami =0

            cate = params[:category_selected]
            if cate == "All"

              @book_copy_filteredv2 = @near_availabled_book_copies
            elsif cate == "Amis"
              @ami =1
              @book_copy_filteredv2=[]

              if @user.follows.first


                @friends_around_tab = []
                @user.follows.each do |n|
                  a = User.find(n.follow_user_id)
                  if a.deleted_at == nil
                    @friends_around_tab = (@friends_around_tab << a)
                  end
                end
                if @friends_around_tab.first.book_copies
                  book_copy_array_all = []
                  @friends_around_tab.each { |n| book_copy_array_all = (book_copy_array_all << n.book_copies).flatten! }
        
                  @near_availabled_book_copies = []
                  book_copy_array_all.reject! {|book| book.status == 2}
                  @length_tab_book_copy_all = book_copy_array_all.length
                  if @length_tab_book_copy_all >20

                    array = []
                    20.times do |i|
                      array[i] = i
                    end
                    array = array.shuffle

                    20.times do |i|
                      @near_availabled_book_copies[i] = book_copy_array_all[array[i]]
                    end
                    @book_copy_filteredv2 = @near_availabled_book_copies

                  else
                    array = []

                    @length_tab_book_copy_all.times do |i|
                      array[i] = i
                    end
                    array = array.shuffle
                    @length_tab_book_copy_all.times do |i|
                      @near_availabled_book_copies[i] = book_copy_array_all[array[i]]
                    end
                    @book_copy_filteredv2 = @near_availabled_book_copies
                  end
                end
              end

            else
              @book_copy_filteredv2 = book_copy_array_all.select { |book| book.category == cate }
            end
          end

            respond_to do |format|
              format.html{}
              format.js{}
            end

          end
        end
      end
