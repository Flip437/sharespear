class BookCopiesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_book_copy, only: %i[show destroy]

  def show
    @url = "http://covers.openlibrary.org/b/isbn/#{@book_copy.isbn}.jpg"
    @post_array = @book_copy.posts
  end

  def new; end

  def search_book_or_author
    @book_infos_table = SearchBookService.search_books(params[:title])

    render :new
  end

  def create
    new_book_copy = BookCopy.new(book_copy_params.to_h)
    new_book_copy.user = current_user
    new_book_copy.status = BookCopy::AVAILABLE

    if new_book_copy.save
      flash[:success] = "Livre ajouté à votre bibliothèque:)"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Erreur d'ajout du livre :("
      redirect_to new_book_copy_path
    end

  end

  def destroy
    if @book_copy.destroy
      flash[:success] = "Livre supprimé :)"
      redirect_to user_path(current_user)
    else
      flash[:error] = @book_copy.errors.full_messages
      redirect_to user_path(current_user)
    end
  end

  private

  def book_copy_params
    params.require(:book_copy).permit(
      :title,
      :author,
      :description,
      :category,
      :photo_link,
      :isbn
    )
  end

  def find_book_copy
    @book_copy = BookCopy.find(params[:id])
  end
end
