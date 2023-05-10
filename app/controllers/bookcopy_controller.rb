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
    #TODO
    #not wortking since session is not fill with books anymore
    #TODO
    numero_selected = params[:numero_selected]
    book_information = session[:book_info][numero_selected.to_i]


    new_book_copy = BookCopy.create(
      title:  book_information[0],
      author: book_information[1],
      description: book_information[2],
      status: 1,
      category: book_information[3],
      user_id: current_user.id,
      photo_link: book_information[4],
      isbn: book_information[5]
    )

    if new_book_copy
      flash[:success] = "Livre ajouté à votre bibliothèque:)"
      redirect_to new_bookcopy_path
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

end
