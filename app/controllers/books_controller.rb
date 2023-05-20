# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book_and_articles, only: %w[show manage_articles]

  def show; end

  def new
    @book = Book.new
  end

  def create
    if (@book = current_user.books.create(book_params))
      redirect_to user_books_path(current_user)
    else
      render :new
    end
  end

  def manage_articles; end

  # TODO: Edit and update actions

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def book_articles
    @book.articles.order(:title)
  end

  def set_book_and_articles
    @book = Book.find(params[:id])
    @articles = book_articles
  end
end
