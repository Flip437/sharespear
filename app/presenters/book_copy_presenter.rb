class BookCopyPresenter
	def initialize(book_copy)
		@book_copy = book_copy
	end

	def book_copy_status_babdge
		if @book_copy.status = BookCopy::AVAILABLE
			'<span class="badge badge-success">Disponible</span>'.html_safe
		else
			'<span class="badge badge-warning">Empreinté</span>'.html_safe
		end
	end
end
