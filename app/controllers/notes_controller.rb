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
    @note_type = params[:note_type]

    if @note_type.nil? || VALID_NOTE_TYPES.exclude?(@note_type)
      @note_type = BASIC_NOTE_TYPE_PARAM
    end
  end

  private

  # TODO: This is duplicated
  def set_article
    @article = Article.find_by(id: params[:article_id])
    return if @article

    not_found_or_unauthorized
  end
end
