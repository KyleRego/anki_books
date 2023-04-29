# frozen_string_literal: true

##
# Handles actions related to Basic notes.
class BasicNotesController < ApplicationController
  before_action :set_article, only: %i[new create show edit update]
  before_action :set_basic_note, only: %i[show edit update]

  def show; end

  def new
    @basic_note = @article.basic_notes.new
  end

  def edit; end

  def create
    @basic_note = @article.basic_notes.create(basic_note_params)

    if @basic_note
      redirect_to article_path(@article, title: @article.title_slug)
    else
      render :new
    end
  end

  def update
    if @basic_note.update(basic_note_params)
      redirect_to article_basic_note_path(@basic_note.article, @basic_note)
    else
      render :edit
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_basic_note
    @basic_note = @article.basic_notes.find(params[:id])
  end

  def basic_note_params
    params.require(:basic_note).permit(:front, :back)
  end
end
