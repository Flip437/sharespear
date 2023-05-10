class BookcopyController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = BookCopy.find(params[:id])
    @url = 'http://covers.openlibrary.org/b/isbn/#{@book.isbn}.jpg'
    @post_array = @book.posts
  end

  def new; end

  def search_book_or_author
    book_title = params[:title]
    @book_infos_table = SearchBookService.search_books(book_title)

    render :new
  end

  def create
    new_book_copy = BookCopy.new(book_copy_params.to_h)
    new_book_copy.user = current_user
    new_book_copy.status = 1

    if new_book_copy.save
      flash[:success] = "Livre ajouté à votre bibliothèque:)"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Erreur d'ajout du livre :("
      redirect_to new_bookcopy_path
    end

  end

  def destroy

    book = BookCopy.find(params[:id])
    book.status=2
    borrows_book = Borrow.where({ book_copy_id: book.id })
    borrows_book.each do |book|
      book.borrow_status=2
      book.save
    end
    book.save

    if book.status==2
      flash[:success] = "Livre supprimé :)"
        redirect_to user_path(current_user.id)
    else
      flash[:error] = "Erreur de suppression :("
        redirect_to user_path(current_user.id)
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

end
