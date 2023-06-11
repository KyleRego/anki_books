# frozen_string_literal: true

# :nodoc:
class ArticlesController < ApplicationController
  before_action :require_login, except: %i[homepage study_cards]
  before_action :set_article, except: %i[new create homepage]
  before_action :check_article_was_found, except: %i[new create homepage]
  before_action :set_book, except: %i[new create homepage]
  before_action :check_book_belongs_to_user, except: %i[new create homepage study_cards]

  def show
    if @article.system
      redirect_to root_path, status: :moved_permanently
    else
      @basic_notes = @article.notes
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @article = Article.new(title: "My new article")
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if !current_user.books.include?(@article.book)
      redirect_to_homepage_no_access
    elsif @article.save
      redirect_to article_path(@article)
    else
      @book = Book.find(params[:article][:book_id])
      flash.now[:alert] = "An article must have a title."
      render :new, status: :unprocessable_entity
    end
  end

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
    # Plan is to have more than one system article in the future.
    # For now, just have one and it will serve as the homepage.
    @article = Article.find_by(system: true)
    @basic_notes = @article.notes
  end

  def change_note_ordinal_position
    note = @article.basic_notes.find(params[:note_id])
    new_ordinal_position = params[:new_ordinal_position].to_i
    if valid_change_note_ordinal_position_input?(note:, new_ordinal_position:)
      @article.move_note_to_new_ordinal_position_and_shift_notes(note:, new_ordinal_position:)
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

  def change_book
    @target_book = current_user.books.find_by(id: params[:book_id])
    # TODO: Probably also check here the target book is not already the article's book
    if @target_book
      @article.update(book: @target_book)
      flash[:notice] = "Article moved to #{@target_book.title}."
      redirect_to manage_article_path(@article)
    else
      head :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def check_article_was_found
    redirect_to_homepage_not_found unless @article
  end

  def set_book
    @book = @article.book
  end

  def check_book_belongs_to_user
    redirect_to_homepage_no_access unless current_user.books.include?(@book)
  end

  def article_params
    params.require(:article).permit(:title, :content, :book_id)
  end

  def valid_change_note_ordinal_position_input?(note:, new_ordinal_position:)
    return false unless @article.current_ordinal_position_range_includes?(note_ordinal_position: new_ordinal_position)

    return false if note.ordinal_position == new_ordinal_position

    true
  end
end
