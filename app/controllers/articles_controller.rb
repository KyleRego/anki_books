# frozen_string_literal: true

# :nodoc:
class ArticlesController < ApplicationController
  before_action :require_login, except: %i[homepage study_cards]
  before_action :set_article, except: %i[new create homepage]
  before_action :check_user_can_access_article, except: %i[new create homepage]

  def show
    if @article.system
      redirect_to root_path, status: :moved_permanently
    else
      @basic_notes = @article.notes
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
      @book = @article.book
      @article.destroy
      redirect_to book_path(@book)
    end
  end

  def homepage
    # TODO: Probably move the system boolean to books, possibly calling
    # it homepage and having the homepage be a book once the larger book
    # view is completed.
    @article = Article.find_by(system: true)
    @basic_notes = @article.notes
  end

  def change_note_ordinal_position
    note = @article.basic_notes.find(params[:note_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if OrdinalPositions::Setter::ArticleBasicNotes.perform(parent: @article, child_to_position: note, new_ordinal_position:)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def study_cards
    @basic_notes = @article.notes
  end

  def manage
    @other_books = current_user.books.where.not(id: @article.book.id)
  end

  # rubocop:disable Metrics/MethodLength
  def change_book
    @target_book = current_user.books.find_by(id: params[:book_id])

    # rubocop:disable Lint/DuplicateBranch
    if !@target_book
      head :unprocessable_entity
    elsif @target_book == @book
      head :ok
    elsif OrdinalPositions::Mover::BookArticles.perform(new_parent: @target_book,
                                                        child_to_position: @article,
                                                        new_ordinal_position: @target_book.articles_count)
      flash[:notice] = "Article moved to #{@target_book.title}."
      redirect_to manage_article_path(@article)
    else
      head :unprocessable_entity
    end
    # rubocop:enable Lint/DuplicateBranch
  end
  # rubocop:enable Metrics/MethodLength

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def check_user_can_access_article
    if @article.nil?
      not_found_or_unauthorized
    elsif @article.system
      @book = @article.book
      nil
    else
      @book = @article.book
      return if current_user&.books&.include?(@book)

      not_found_or_unauthorized
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, :book_id)
  end
end
