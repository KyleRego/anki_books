# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ClozeNotesController < ApplicationController
  before_action :require_login
  before_action :require_turbo_request
  before_action :find_article_from_article_id_param
  before_action :find_cloze_note_from_cloze_note_id_param, only: %w[edit update]

  def new
    sibling_note_id = request.headers["Turbo-Frame"].last(36)
    @previous_sibling = if sibling_note_id == Note.ordinal_position_zero_turbo_dom_id
                          nil
                        else
                          Note.find(sibling_note_id)
                        end
    @cloze_note = @article.cloze_notes.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @cloze_note = @article.cloze_notes.new(cloze_note_params)
    @cloze_note.ordinal_position = @article.notes_count
    @previous_sibling = @article.cloze_notes.find_by(ordinal_position: ordinal_position_param - 1)
    
    if @cloze_note.save
      @article.reposition_ordinal_child(child: @cloze_note, new_ordinal_position: ordinal_position_param)
    else
      flash.now[:alert] = @cloze_note.errors.full_messages.first
      turbo_id = @previous_sibling ? @previous_sibling.new_next_sibling_note_turbo_id : Note.ordinal_position_zero_turbo_dom_id
      render turbo_stream: turbo_stream.replace(turbo_id,
                                                template: "cloze_notes/new",
                                                locals: { cloze_note: @cloze_note })
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    if @cloze_note.update(cloze_note_params)
      @note = @cloze_note
      render partial: "articles/note/show"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ordinal_position_param
    # @ordinal_position_param ||= params[:ordinal_position].to_i
    0
  end

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
