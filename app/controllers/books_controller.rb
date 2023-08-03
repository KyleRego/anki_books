# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, except: %w[index new create]
  before_action :set_articles, only: %w[show manage change_domains]

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
      redirect_to books_path, flash: { notice: "#{@book.title} created successfully" }
    else
      flash.now[:alert] = @book.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to books_path, flash: { notice: "#{@book.title} updated successfully" }
    else
      # Reload the book so that the top nav link to the book (the title) has text.
      @book.reload
      flash.now[:alert] = @book.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  def manage
    current_domains = @book.domains
    @domains_options = current_user.domains.map do |domain|
      id = domain.id
      title = domain.title
      selected = current_domains.include?(domain)
      { id:, title:, selected: }
    end
  end

  def change_article_ordinal_position
    @book = current_user.books.find(params[:id])
    article = @book.articles.find(params[:article_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if OrdinalPositions::SetChildPosition.perform(parent: @book, child_to_position: article, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def change_domains
    @book.domains = current_user.domains.where(id: params[:domains_ids])
    redirect_to manage_book_path(@book), flash: { notice: "Domains updated" }
  end

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

    redirect_to root_path, flash: { alert: "Book not found" }
  end

  def set_articles
    @articles = @book.ordered_articles
  end
end
