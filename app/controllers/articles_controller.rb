# frozen_string_literal: true

##
# ArticlesController handles actions related to articles.
class ArticlesController < ApplicationController
  before_action :require_login, only: %i[edit create update change_note_ordinal_position]
  before_action :set_article, only: %i[show edit update change_note_ordinal_position]

  def show
    @basic_notes = @article.basic_notes.order(:anki_id)
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
    @basic_notes = @article.basic_notes.order(:anki_id)
  end

  def change_note_ordinal_position
    # TODO: Change the note's ordinal position and also adjust the rest of the notes.
    # note = @article.basic_notes.find(params[:note_id])
    # new_position = params[:new_ordinal_position].to_i

    # head :ok
  end

  private

  def set_article
    @article = Article.find_by id: params[:id]
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
