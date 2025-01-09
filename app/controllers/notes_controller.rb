# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2025 Kyle Rego

# frozen_string_literal: true

##
# Handles actions common to all notes
class NotesController < ApplicationController
  before_action :set_article

  BASIC_NOTE_TYPE = "BasicNote"
  CLOZE_NOTE_TYPE = "ClozeNote"
  VALID_NOTE_TYPES = [BASIC_NOTE_TYPE, CLOZE_NOTE_TYPE].freeze

  def new
    # TODO: This should be last note type that the user used
    @note_type = BASIC_NOTE_TYPE
  end

  def switch_note_type
    @note_type = params[:note_type]

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
end
