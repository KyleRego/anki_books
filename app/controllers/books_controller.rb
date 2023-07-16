# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, except: %w[index new create]
  before_action :set_articles, only: %w[show manage change_book_groups]

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
      # TODO: Use errors.full_messages method
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

  def manage
    current_book_groups = @book.book_groups
    @book_groups_options = current_user.book_groups.map do |book_group|
      id = book_group.id
      title = book_group.title
      selected = current_book_groups.include?(book_group)
      { id:, title:, selected: }
    end
  end

  def change_article_ordinal_position
    @book = current_user.books.find(params[:id])
    article = @book.articles.find(params[:article_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if OrdinalPositions::Setter::BookArticles.perform(parent: @book, child_to_position: article, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  # rubocop:disable Metrics/AbcSize
  def change_book_groups
    target_book_groups = current_user.book_groups.where(id: params[:book_groups_ids])
    target_book_groups.each { |book_group| book_group.books << @book unless book_group.books.include?(@book) }
    stale_book_groups_books = current_user.book_groups.where.not(id: params[:book_groups_ids])
    stale_book_groups_books.each { |book_group| book_group.books.delete(@book) }
    redirect_to manage_book_path(@book)
  end
  # rubocop:enable Metrics/AbcSize

  def study_cards
    @basic_notes = @book.ordered_notes
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
