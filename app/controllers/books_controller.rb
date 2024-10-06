# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  caches_action :show

  before_action :require_login, except: %w[show]
  before_action :set_public_book, only: %w[show]
  before_action :set_book, except: %w[index new create]
  before_action :set_articles, only: %w[manage]

  def index
    @books = current_user.books
    @root_books = current_user.books.where(parent_book_id: nil).order(:title)
  end

  def show
    @use_book_version = true
    @html_page_title = @book.title
  end

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
    @user_other_books = current_user.books.ordered
  end

  def change_article_ordinal_position
    @book = current_user.books.find(params[:id])
    article = @book.articles.find(params[:article_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if @book.reposition_ordinal_child(child: article, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def study_cards
    @notes = @book.ordered_notes
    render "study_cards/index"
  end

  def transfer_articles
    target_book = current_user.books.find_by(id: params[:target_book_id])

    if target_book.nil?
      not_found_or_unauthorized
    else
      children_to_position = @book.articles.where(id: params[:article_ids])
      @book.move_ordinal_children_to_new_parent(children: children_to_position, new_parent: target_book)
      redirect_to manage_book_path(@book), flash: { notice: "Selected articles moved to #{target_book.title}." }
    end
  rescue ArgumentError
    head :unprocessable_entity
  end

  # rubocop:disable Metrics/AbcSize
  def change_parent_book
    if params[:parent_book_id].blank?
      @book.update(parent_book_id: nil)
      redirect_to manage_book_path(@book), flash: { notice: "Parent book successfully removed" }
      return
    end

    parent_book = current_user.books.find_by(id: params[:parent_book_id])

    if parent_book.nil?
      not_found_or_unauthorized
      return
    end

    if parent_book == @book
      redirect_to manage_book_path(@book), flash: { alert: "Parent book cannot be itself" }
      return
    end

    parent_book.books << @book
    redirect_to manage_book_path(@book), flash: { notice: "Parent book updated for #{@book.title}." }
  end
  # rubocop:enable Metrics/AbcSize

  def update_child_books
    child_book_ids = params[:child_book_ids]
    @book.books = current_user.books.where(id: child_book_ids)
    redirect_to books_path, flash: { notice: "Child books updated for #{@book.title}." }
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def set_public_book
    @book = Book.where(allow_anonymous: true)
                .includes(articles: :notes)
                .order("articles.ordinal_position")
                .order("notes.ordinal_position")
                .find_by(id: params[:id])
  end

  def set_book
    return if @book

    if logged_in?
      @book ||= current_user.books
                            .includes(articles: :notes)
                            .order("articles.ordinal_position")
                            .order("notes.ordinal_position")
                            .find_by(id: params[:id])
      return if @book
    end

    not_found_or_unauthorized
  end

  def set_articles
    @articles = @book.articles.ordered
  end
end
