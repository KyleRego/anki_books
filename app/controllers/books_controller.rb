# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, except: %w[index new create]
  before_action :set_articles, only: %w[show manage reorder_articles]

  def index
    @books = current_user.books
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = current_user.books.create(book_params)
    if @book.save
      redirect_to books_path
    else
      flash.now[:alert] = "A book must have a title."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to books_path
    else
      # Reload the book so that the top nav link to the book (the title) has text.
      @book.reload
      flash.now[:alert] = "A book must have a title."
      render :edit, status: :unprocessable_entity
    end
  end

  def manage; end

  def reorder_articles; end

  def change_article_ordinal_position
    @book = current_user.books.find(params[:id])
    article = @book.articles.find(params[:article_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if OrdinalPositionSetter::BookArticles.perform(parent: @book, child_to_position: article, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def set_book
    @book = current_user.books.find_by(id: params[:id])
    return if @book

    flash[:alert] = "Book was not found."
    redirect_to root_path
  end

  def set_articles
    @articles = @book.ordered_articles
  end
end
