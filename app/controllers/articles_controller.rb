# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
# :nodoc:
class ArticlesController < ApplicationController
  before_action :require_login
  before_action :set_article, except: %i[index new create]

  def index
    @book = Book.find_by(id: params[:book_id])
    if @book && current_user.can_access_book?(book: @book)
      @articles = @book.ordered_articles
    else
      not_found_or_unauthorized
    end
  end

  def show
    if @article.system
      redirect_to root_path, status: :moved_permanently
    else
      @basic_notes = @article.ordered_notes
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
      flash[:notice] = "Article updated successfully."
      redirect_to @article.system ? root_path : article_path(@article)
    else
      @book = @article.book
      flash.now[:alert] = "The article must have a title."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.system
      head :unprocessable_entity
    else
      OrdinalPositions::Deleter::BookArticles.perform(child_to_delete: @article)
      redirect_to book_articles_path(@book)
    end
  end

  def change_note_ordinal_position
    note = BasicNote.find(params[:note_id])
    unless @current_user.can_access_note?(note:)
      head :unprocessable_entity
      return
    end

    new_ordinal_position = params[:new_ordinal_position].to_i
    if @article.id == note.article_id
      if OrdinalPositions::AddChildAtPosition.perform(parent: @article, child_to_position: note, new_ordinal_position:)
        head :ok
      else
        head :unprocessable_entity
      end
    elsif OrdinalPositions::MoveChildToNewParent.perform(new_parent: @article, child_to_position: note, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def study_cards
    if @article.system
      redirect_to homepage_study_cards_path, status: :moved_permanently
    else
      @basic_notes = @article.ordered_notes
    end
  end

  def manage
    @other_books = current_user.books.where.not(id: @book.id)
    @other_articles = @book.ordered_articles.where.not(id: @article.id)
  end

  def change_book
    @target_book = current_user.books.find_by(id: params[:book_id])

    # rubocop:disable Lint/DuplicateBranch
    if !@target_book
      head :unprocessable_entity
    elsif @target_book == @book
      head :ok
    elsif OrdinalPositions::MoveChildToNewParent.perform(new_parent: @target_book,
                                                         child_to_position: @article,
                                                         new_ordinal_position: @target_book.articles_count)
      redirect_to book_articles_path(@book), flash: { notice: "#{@article.title} successfully moved to #{@target_book.title}" }
    else
      # :nocov:
      head :unprocessable_entity
      # :nocov:
    end
    # rubocop:enable Lint/DuplicateBranch
  end

  def transfer_basic_notes
    target_article = @book.articles.find_by(id: params[:target_article_id])

    if target_article.nil?
      not_found_or_unauthorized
    else
      children_to_position = @article.basic_notes.where(id: params[:basic_note_ids])

      OrdinalPositions::GroupMover::ArticleBasicNotes.perform(new_parent: target_article,
                                                              old_parent: @article,
                                                              children_to_position:)
      redirect_to manage_article_path(@article), flash: { notice: "Selected basic notes moved to #{target_article.title}." }
    end
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      not_found_or_unauthorized
    elsif @article.system
      @book = @article.book
      nil
    else
      @book = @article.book
      return if current_user.can_access_book?(book: @book)

      not_found_or_unauthorized
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :book_id)
  end
end
# rubocop:enable Metrics/ClassLength
