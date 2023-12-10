# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class BasicNotesController < ApplicationController
  before_action :require_login, only: %i[create edit update new destroy]
  before_action :require_turbo_request, except: %i[destroy]
  before_action :set_article, only: %i[create edit update new destroy]
  before_action :require_user_can_access_article, only: %i[create edit update new destroy]
  before_action :set_basic_note, only: %i[edit update destroy]
  before_action :require_user_can_access_note, only: %i[edit update destroy]

  def new
    # Turbo-Frame header has the id of the turbo frame element
    # and the last 36 characters of this are the id of the basic note
    # which is the previous sibling. If it's the very first new basic note
    # turbo frame element, it is not the id of a previous sibling.
    sibling_note_id = request.headers["Turbo-Frame"].last(36)
    @previous_sibling = if sibling_note_id == Note.ordinal_position_zero_turbo_dom_id
                          nil
                        else
                          Note.find(sibling_note_id)
                        end
    @basic_note = @article.basic_notes.new
  end

  def edit
    @on_study_cards = true if request.referer&.end_with?("study_cards")
  end

  def create
    @basic_note = @article.basic_notes.new(basic_note_params)
    @basic_note.ordinal_position = @article.notes_count
    @previous_sibling = @article.notes.find_by(ordinal_position: ordinal_position_param - 1)

    if @basic_note.save
      @article.reposition_ordinal_child(child: @basic_note, new_ordinal_position: ordinal_position_param)
    else
      turbo_id = @previous_sibling ? @previous_sibling.new_next_note_sibling_after_note_turbo_id : Note.ordinal_position_zero_turbo_dom_id
      render turbo_stream: turbo_stream.replace(turbo_id,
                                                template: "basic_notes/new",
                                                locals: { basic_note: @basic_note })
    end
  end

  def update
    if @basic_note.update(basic_note_params)
      if params[:options][:on_study_cards] == "true"
        render turbo_stream: turbo_stream.replace(@basic_note.turbo_dom_id,
                                                  partial: "study_cards/basic_note",
                                                  locals: { basic_note: @basic_note })
      else
        @note = @basic_note
        render partial: "articles/note/show"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # TODO: Flash message on successful basic note deletion
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
