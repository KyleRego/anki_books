# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ClozeNotesController < ApplicationController
  include ClozeNotesHelper

  before_action :require_login
  before_action :require_turbo_request
  before_action :find_article_from_article_id_param
  before_action :find_cloze_note_from_cloze_note_id_param, only: %w[edit update]

  def new
    @cloze_note = @article.cloze_notes.new
  end

  def edit; end

  def create
    @cloze_note = @article.cloze_notes.new(cloze_note_params)
    @cloze_note.ordinal_position = @article.notes_count
    return if @cloze_note.save

    flash.now[:alert] = @cloze_note.errors.full_messages.first
    render turbo_stream: turbo_stream.replace(new_cloze_note_turbo_id,
                                              template: "cloze_notes/new",
                                              locals: { cloze_note: @cloze_note })
  end

  def update
    if @cloze_note.update(cloze_note_params)
      render partial: "articles/cloze_note/show"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def find_article_from_article_id_param
    @article = current_user.articles.find_by(id: params[:article_id])
    return if @article

    not_found_or_unauthorized
  end

  def find_cloze_note_from_cloze_note_id_param
    @cloze_note = @article.cloze_notes.find_by(id: params[:id])
    return if @cloze_note

    not_found_or_unauthorized
  end

  def cloze_note_params
    params.require(:cloze_note).permit(:sentence)
  end
end
