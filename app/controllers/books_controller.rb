# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login

  def show
    @book = Book.find params[:id]
    @articles = @book.articles
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      current_user.books << @book
      redirect_to user_books_path(current_user)
    else
      render :new
    end
  end

  # TODO: Edit and update actions

  private

  def book_params
    params.require(:book).permit(:title)
  end
end
