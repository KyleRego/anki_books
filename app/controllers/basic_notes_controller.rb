# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class BasicNotesController < ApplicationController
  before_action :require_login, only: %i[create update destroy]
  before_action :require_turbo_request, except: %i[destroy create]
  before_action :set_article, only: %i[create update destroy]
  before_action :require_user_can_access_article, only: %i[create update destroy]
  before_action :set_basic_note, only: %i[update destroy]
  before_action :require_user_can_access_note, only: %i[update destroy]

  def create
    @note = @article.basic_notes.new(basic_note_params)
    @note.ordinal_position = @article.notes_count
    @previous_sibling = @article.notes.find_by(ordinal_position: ordinal_position_param - 1)

    if @note.save # rubocop:disable Style/GuardClause
      @article.reposition_ordinal_child(child: @note, new_ordinal_position: ordinal_position_param)
    else
      render turbo_stream: turbo_stream.replace("note-form",
                                                partial: "basic_notes/form") and return
    end
  end

  def update
    if @basic_note.update(basic_note_params) # rubocop:disable Style/GuardClause
      @note = @basic_note
    else
      render turbo_stream: turbo_stream.replace("note-form",
                                                partial: "basic_notes/form"),
             status: :unprocessable_entity and return
    end
  end

  # TODO: Flash message on successful basic note deletion?
  def destroy
    @article.destroy_ordinal_child(child: @basic_note)
    redirect_to manage_article_path(@article)
  end

  private

  def set_article
    @article = Article.find_by(id: params[:article_id])
    return if @article

    not_found_or_unauthorized
  end

  def set_basic_note
    @basic_note = @article.basic_notes.find_by(id: params[:id])
    return if @basic_note

    not_found_or_unauthorized
  end

  def basic_note_params
    params.require(:basic_note).permit(:front, :back)
  end

  def ordinal_position_param
    @ordinal_position_param ||= params[:ordinal_position].to_i
  end

  def require_user_can_access_article
    return if current_user.can_access_article?(article: @article)

    not_found_or_unauthorized
  end

  def require_user_can_access_note
    return if current_user.can_access_note?(note: @basic_note)

    not_found_or_unauthorized
  end
end
