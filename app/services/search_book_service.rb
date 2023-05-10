module SearchBookService
  module_function
  MAX_RESULTS = 8
  GOOGLE_BOOK_API_BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def search_books(title)
    url = "#{GOOGLE_BOOK_API_BASE_URL}?q=#{title.to_s}&maxResults=#{MAX_RESULTS}"
    escaped_url = URI.parse(URI.escape(url))
    doc=JSON.load(open(escaped_url, 'User-Agent' => 'ruby'))
    books = doc["items"]
    return unless books

    book_infos_table=[]
    books.each do |book|
      book_infos_table << parse_book(book["volumeInfo"])
    end
    book_infos_table
  end

  def parse_book(book_infos)
    description=book_infos["description"].slice(1..300) if book_infos["description"] && book_infos["description"].length > 400
    photo = book_infos['imageLinks'] ? book_infos['imageLinks']['thumbnail'] : "no_picture_found_sk.png"
    book_infos["categories"].nil? ? category = "Other" : category = book_infos["categories"][0]
    description = book_infos["description"].nil? ? "..." : book_infos["description"]
    author = book_infos["authors"].nil? ? "~" : book_infos["authors"][0]
    title = book_infos["title"].nil? ? "~" : book_infos["title"]
    isbn = book_infos["industryIdentifiers"].nil? ? "~" : book_infos['industryIdentifiers'][0]['identifier']
    date = book_infos["publishedDate"].nil? ? "~" : book_infos['publishedDate']

    return {
      title: title,
      author: author,
      description: description,
      category: category,
      photo: photo,
      isbn: isbn,
      date: date
    }
  end
end
