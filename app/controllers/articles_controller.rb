# frozen_string_literal: true

##
# ArticlesController handles actions related to articles.
class ArticlesController < ApplicationController
  before_action :require_login, only: %i[edit create update change_note_ordinal_position]
  before_action :set_article, only: %i[show edit update change_note_ordinal_position]

  def show
    @basic_notes = @article.basic_notes.order(:ordinal_position)
  end

  def edit; end

  def create
    @article = Article.create title: "My new article"
    redirect_to edit_article_path(@article, title: @article.title_slug)
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to article_path(@article, title: @article.title_slug)
    else
      render :edit
    end
  end

  def homepage
    # Plan is to have more than one system article in the future.
    # For now, just have one and it will serve as the homepage.
    @article = Article.find_by system: true
    @basic_notes = @article.basic_notes.order(:ordinal_position)
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

  private

  def set_article
    @article = Article.find_by id: params[:id]
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def valid_change_note_ordinal_position_input?(note:, new_ordinal_position:)
    return false if new_ordinal_position >= @article.notes_count || new_ordinal_position.negative?

    return false if note.ordinal_position == new_ordinal_position

    true
  end
end
