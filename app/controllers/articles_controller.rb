# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ArticlesController < ApplicationController
  # caches_action :show, :study_cards, if: -> { !logged_in? }
  before_action :require_login, except: %i[show study_cards random_article]

  before_action :set_article_and_book, except: %i[new create show study_cards random_article]

  def show
    @article = Article.includes(:book).find_by(id: params[:id])
    not_found_or_unauthorized && return unless @article

    @book = @article.book

    if @article.system
      redirect_to root_path, status: :moved_permanently
    elsif @book.allow_anonymous || current_user&.can_access_book?(book: @book)
      @notes = @article.notes.ordered
      ord_pos = @article.ordinal_position
      @previous_article = @book.articles.find_by(ordinal_position: ord_pos - 1)
      @next_article = @book.articles.find_by(ordinal_position: ord_pos + 1)
    else
      not_found_or_unauthorized
    end
    @html_page_title = @article.title
  end

  def study_cards
    @article = Article.includes(:book).find_by(id: params[:id])
    not_found_or_unauthorized && return unless @article

    @book = @article.book

    if @article.system
      redirect_to homepage_study_cards_path, status: :moved_permanently
    elsif @book.allow_anonymous || current_user&.can_access_book?(book: @book)
      @notes = @article.notes.ordered
      render "study_cards/index"
    else
      not_found_or_unauthorized
    end
  end

  def random_article
    if current_user
      article = current_user.random_reading_article

      if article
        redirect_to article_path(article)
      else
        flash[:notice] = "No incomplete reading articles found."
        redirect_to books_path
      end
    else
      article = Article.joins(:book)
                       .where(books: { allow_anonymous: true })
                       .order(Arel.sql("RANDOM()"))
                       .first
      redirect_to article
    end
  end

  def new
    @book = current_user.books.find(params[:book_id])
    @article = Article.new(title: "My new article")
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @article = Article.new(article_params)
    @book = Book.find(params[:article][:book_id])
    @article.ordinal_position = @book.articles_count

    if current_user.books.exclude?(@book)
      not_found_or_unauthorized
    elsif @article.save
      redirect_to article_path(@article)
    else
      flash.now[:alert] = "An article must have a title."
      render :new, status: :unprocessable_entity
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.system
      head :unprocessable_entity
    else
      @book.destroy_ordinal_child(child: @article)
      flash[:notice] = "Article successfully deleted."
      redirect_to book_path(@book), status: :see_other
    end
  end

  # TODO: If this can also move note to other article, it should
  # be renamed
  def change_note_ordinal_position
    note = Note.find(params[:note_id])
    unless @current_user.can_access_note?(note:)
      head :unprocessable_entity
      return
    end

    new_ordinal_position = params[:new_ordinal_position].to_i
    if @article.id == note.article_id
      if @article.reposition_ordinal_child(child: note, new_ordinal_position:)
        head :ok
      else
        head :unprocessable_entity
      end
    else
      # TODO: note.move_to_new_parent to remove LoD dependency
      note.article.move_ordinal_child_to_new_parent(new_parent: @article, child: note, new_ordinal_position:)
      head :ok
    end
  end

  def manage
    @user_other_books = current_user.books.where.not(id: @book.id)
    @article_basic_notes = @article.basic_notes.ordered
    @book_other_articles = @book.articles.ordered.where.not(id: @article.id)
  end

  def change_book
    @target_book = current_user.books.find_by(id: params[:book_id])

    if !@target_book
      head :unprocessable_entity
    elsif @target_book == @book
      head :ok
    else
      @book.move_ordinal_child_to_new_parent(new_parent: @target_book, child: @article,
                                             new_ordinal_position: @target_book.articles_count)
      redirect_to book_path(@book),
                  flash: { notice: "#{@article.title} successfully moved to #{@target_book.title}" }
    end
  end

  def transfer_notes
    target_article = @book.articles.find_by(id: params[:target_article_id])

    if target_article.nil?
      not_found_or_unauthorized
    else
      children_to_position = @article.notes.where(id: params[:basic_note_ids])
      @article.move_ordinal_children_to_new_parent(children: children_to_position, new_parent: target_article)
      redirect_to manage_article_path(@article), flash: { notice: "Selected basic notes moved to #{target_article.title}." }
    end
  rescue ArgumentError
    head :unprocessable_entity
  end

  private

  def set_article_and_book
    @article = current_user.articles.find_by(id: params[:id])
    if @article.nil?
      not_found_or_unauthorized
    else
      @book = @article.book
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :book_id, :reading, :writing, :complete)
  end
end
