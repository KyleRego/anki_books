# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class BooksController < ApplicationController
  before_action :require_login
  before_action :set_book, except: %w[index new create]
  before_action :set_articles, only: %w[manage change_domains]

  def index
    @books = current_user.books
  end

  def show
    @use_book_version = true
    @book = Book.includes(articles: :basic_notes)
                .order("articles.ordinal_position")
                .order("basic_notes.ordinal_position").find(params[:id])
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
    @book_current_domains = @book.domains
    @user_domains = current_user.domains.ordered
    @book_current_concepts = @book.concepts.ordered
    @user_concepts = current_user.concepts.ordered
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

  def change_domains
    @book.domains = current_user.domains.where(id: params[:domains_ids])
    redirect_to manage_book_path(@book), flash: { notice: "Domains successfully updated" }
  end

  def change_concepts
    @book.concepts = current_user.concepts.where(id: params[:concepts_ids])
    redirect_to manage_book_path(@book), flash: { notice: "Concepts successfully updated" }
  end

  def study_cards
    @basic_notes = @book.ordered_basic_notes
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

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def set_book
    @book = current_user.books.find_by(id: params[:id])
    return if @book

    not_found_or_unauthorized
  end

  def set_articles
    @articles = @book.articles.ordered
  end
end
