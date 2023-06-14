# frozen_string_literal: true

# :nodoc:
module BooksHelper
  attr_reader :book

  def show_link_to_book_in_top_nav?
    book&.persisted? && !current_page?(book_path(book))
  end

  def show_link_to_my_books_in_top_nav?
    !current_page?(books_path)
  end
end
