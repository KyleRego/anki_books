# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2025 Kyle Rego

# frozen_string_literal: true

##
# Handles actions common to all notes
# note_type param is the note type of an existing note being edited
# target_note_type is the type of note being created/switched to
class NotesController < ApplicationController
  before_action :set_article

  BASIC_NOTE_TYPE = BasicNote.name
  CLOZE_NOTE_TYPE = ClozeNote.name
  VALID_NOTE_TYPES = [BASIC_NOTE_TYPE, CLOZE_NOTE_TYPE].freeze

  def new
    @editing = false
    # TODO: This should be last note type that the user used
    @target_note_type = BASIC_NOTE_TYPE
    @note = BasicNote.new
  end

  def edit
    @editing = true
    @note_type = params[:note_type]
    @target_note_type = @note_type
    head :bad_request and return if VALID_NOTE_TYPES.exclude?(@target_note_type)

    load_note
  end

  def switch_note_type
    @target_note_type = params[:target_note_type]

    load_note if params[:id]

    render turbo_stream: [
      turbo_stream.replace("modal-header", partial: "modal_header"),
      turbo_stream.replace("modal-body", partial: "modal_body"),
      turbo_stream.replace("modal-footer", partial: "modal_footer")
    ]
  end

  private

  # TODO: This is duplicated
  def set_article
    @article = Article.find_by(id: params[:article_id])
    return if @article

    not_found_or_unauthorized
  end

  def load_note
    raise RuntimeError if @note_type.nil?

    @note = case @note_type
            when BASIC_NOTE_TYPE
              BasicNote.joins(:article).find_by(id: params[:id])
            when CLOZE_NOTE_TYPE
              ClozeNote.joins(:article).find_by(id: params[:id])
            end
  end
end
