class HomeController < ApplicationController
  before_action :authenticate_user!

  def new; end

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
    @displayed_categories_count = 2
    @avatar_array = ['sharespeare1.png', 'sharespeare2.png','sharespeare3.png','sharespeare4.png','sharespeare5.png','sharespeare6.png','sharespeare7.png','sharespeare8.png']
    @zip_name = User::ZIP_CODES_NAMES[current_user.zip_code]

    @near_availabled_book_copies = BookCopy.filtered_book_copies(current_user, permitted_params_for_filter)

    @categories = BookCopy.pluck(:category).uniq
    @user = User.find(current_user.id)

    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  private

  def permitted_params_for_filter
    return params.require(:selector).permit(:filter, :categories) if params[:selector]
  end
end
