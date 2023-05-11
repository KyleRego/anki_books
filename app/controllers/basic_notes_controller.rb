# frozen_string_literal: true

##
# Handles actions related to Basic notes. Basic notes do not have any
# standalone views so all requests this handles should come through Turbo.
class BasicNotesController < ApplicationController
  include BasicNotesHelper

  before_action :require_turbo_request
  before_action :require_login, only: %i[create edit update]
  before_action :set_article, only: %i[new create show edit update]
  before_action :set_basic_note, only: %i[show edit update]

  def show; end

  def new
    turbo_id = request.headers["Turbo-Frame"]
    sibling_note_id = turbo_id.slice(TURBO_NEW_BASIC_NOTE_ID_PREFIX.length..-1)
    @previous_sibling = BasicNote.find_by(id: sibling_note_id)
    @basic_note = @article.basic_notes.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @basic_note = @article.basic_notes.new(basic_note_params)
    @basic_note.ordinal_position = @article.notes_count
    new_ordinal_position = params[:ordinal_position].to_i
    @previous_sibling = @article.basic_notes.find_by(ordinal_position: new_ordinal_position - 1)
    if @basic_note.save && @article.allowed_note_ordinal_position?(note_ordinal_position: new_ordinal_position)
      order_notes_and_render_appropriate_turbo_stream(new_ordinal_position:)
    else
      render turbo_stream: turbo_stream.replace(turbo_id_for_new_basic_note(sibling: @previous_sibling),
                                                template: "basic_notes/new", locals: { basic_note: @basic_note })
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    if @basic_note.update(basic_note_params)
      redirect_to article_basic_note_path(@article, @basic_note)
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

  # rubocop:disable Metrics/MethodLength
  def order_notes_and_render_appropriate_turbo_stream(new_ordinal_position:)
    @article.move_note_to_new_ordinal_position_and_shift_notes(note: @basic_note, new_ordinal_position:)
    if new_ordinal_position.zero?
      render turbo_stream: turbo_stream.before(turbo_id_for_new_basic_note(sibling: nil),
                                               template: "basic_notes/show",
                                               locals: { basic_note: @basic_note })
    else
      previous_sibling = @article.basic_notes.find_by(ordinal_position: new_ordinal_position - 1)
      render turbo_stream: turbo_stream.before(turbo_id_for_new_basic_note(sibling: previous_sibling),
                                               template: "basic_notes/show",
                                               locals: { basic_note: @basic_note })
    end
  end
  # rubocop:enable Metrics/MethodLength
end
