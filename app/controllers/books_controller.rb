# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book_and_articles, only: %w[show manage]

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.create(book_params)
    if @book.save
      redirect_to user_books_path(current_user)
    else
      flash.now[:alert] = "A book must have a title."
      render :new, status: :unprocessable_entity
    end
  end

  def manage; end

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
