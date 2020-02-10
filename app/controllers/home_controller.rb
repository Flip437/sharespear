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


        @avatar_array = ['sharespeare1.png', 'sharespeare2.png','sharespeare3.png','sharespeare4.png','sharespeare5.png','sharespeare6.png','sharespeare7.png','sharespeare8.png']


        if current_user


          zip = current_user.zip_code
          @zip_name = ""

          if zip=="69001"
            @zip_name = "Lyon 1 - Terreaux"
          end
          if zip=="69002"
            @zip_name = "Lyon 2 - Bellecour"
          end
          if zip=="69003"
            @zip_name = "Lyon 3 - La Part-Dieu"
          end
          if zip=="69004"
            @zip_name = "Lyon 4 - Croix-Rousse"
          end
          if zip=="69005"
            @zip_name = "Lyon 5 - Vieux Lyon"
          end
          if zip=="69006"
            @zip_name = "Lyon 1 - Terreaux"
          end
          if zip=="69007"
            @zip_name = "Lyon 7 - Jean Macé"
          end
          if zip=="69008"
            @zip_name = "Lyon 8 - Monplaisir"
          end
          if zip=="69009"
            @zip_name = "Lyon 9 - Vaise"
          end
          if zip=="69100"
            @zip_name = "Villeurbanne"
          end
          if zip=="69100"
            @zip_name = "Villeurbanne"
          end
          if zip=="69300"
            @zip_name = "Caluire-et-Cuire"
          end
          if zip=="69142"
            @zip_name = "La Mulatière"
          end
          if zip=="69160"
            @zip_name = "Tassin-la-Demi-Lune"
          end
          if zip=="69130"
            @zip_name = "Écully"
          end
          if zip=="69600"
            @zip_name = "Oullins"
          end
          if zip=="69500"
            @zip_name = "Bron"
          end

          user_around_tab = User.where(zip_code: zip, deleted_at: nil)


          book_copy_array_all = []

          if user_around_tab.first.book_copies

            user_around_tab.each { |n| book_copy_array_all = (book_copy_array_all << n.book_copies).flatten! }
            @book_copy_array = []

            book_copy_array_all.reject! {|book| book.status == 2}

            @length_tab_book_copy_all = book_copy_array_all.length

            if @length_tab_book_copy_all >20

              array = []
              20.times do |i|
                array[i] = i
              end
              array = array.shuffle

              20.times do |i|
                @book_copy_array[i] = book_copy_array_all[array[i]]
              end

            else
              array = []

              @length_tab_book_copy_all.times do |i|
                array[i] = i
              end
              array = array.shuffle
              @length_tab_book_copy_all.times do |i|
                @book_copy_array[i] = book_copy_array_all[array[i]]
              end
            end

            @length_tab_book_copy =  @book_copy_array.length

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

              @book_copy_filteredv2 = @book_copy_array
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
        
                  puts book_copy_array_all.inspect
                  @book_copy_array = []
                  book_copy_array_all.reject! {|book| book.status == 2}
                  @length_tab_book_copy_all = book_copy_array_all.length
                  if @length_tab_book_copy_all >20

                    array = []
                    20.times do |i|
                      array[i] = i
                    end
                    array = array.shuffle

                    20.times do |i|
                      @book_copy_array[i] = book_copy_array_all[array[i]]
                    end
                    @book_copy_filteredv2 = @book_copy_array

                  else
                    array = []

                    @length_tab_book_copy_all.times do |i|
                      array[i] = i
                    end
                    array = array.shuffle
                    @length_tab_book_copy_all.times do |i|
                      @book_copy_array[i] = book_copy_array_all[array[i]]
                    end
                    @book_copy_filteredv2 = @book_copy_array
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
