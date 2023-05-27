# frozen_string_literal: true

# :nodoc:
class ArticlesController < ApplicationController
  before_action :require_login, only: %i[edit create update change_note_ordinal_position manage destroy]
  before_action :set_article, only: %i[show edit update change_note_ordinal_position study_cards manage destroy]

  def show
    redirect_to root_path, status: :moved_permanently if @article.system

    @basic_notes = @article.notes
  end

  def new
    @book = Book.find(params[:book_id])
    @article = Article.new(title: "My new article")
  end

  def edit
    @book = @article.book
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article.custom_path
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to @article.system ? root_path : @article.custom_path
    else
      @book = @article.book
      render :edit
    end
  end

  def destroy
    if @article.system
      head :unprocessable_entity
    else
      @book = @article.book
      @article.destroy
      redirect_to @book.custom_path
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

  def manage; end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
    @book = @article.book
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
