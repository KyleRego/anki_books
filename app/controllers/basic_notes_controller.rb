# frozen_string_literal: true

# :nodoc:
class BasicNotesController < ApplicationController
  include BasicNotesHelper

  before_action :require_turbo_request
  before_action :require_login, only: %i[create edit update]
  before_action :set_article, only: %i[new create show edit update]
  before_action :set_basic_note, only: %i[show edit update]

  def show; end

  def new
    turbo_id = request.headers["Turbo-Frame"]
    sibling_note_id = turbo_id.slice(first_basic_note_turbo_id.length..-1)
    @previous_sibling = BasicNote.find_by(id: sibling_note_id)
    @basic_note = @article.basic_notes.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  def create
    @basic_note = @article.basic_notes.new(basic_note_params)
    @basic_note.ordinal_position = @article.notes_count

    if @basic_note.valid? && OrdinalPositionSetter::ArticleBasicNotes.perform(parent: @article, child_to_position: @basic_note,
                                                                              new_ordinal_position: ordinal_position_param)
      render_appropriate_turbo_stream_for_create(new_ordinal_position: ordinal_position_param)
    else
      @previous_sibling = @article.basic_notes.find_by(ordinal_position: ordinal_position_param - 1)
      turbo_id = @previous_sibling ? @previous_sibling.new_note_sibling_turbo_id : first_basic_note_turbo_id
      render turbo_stream: turbo_stream.replace(turbo_id,
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

  def ordinal_position_param
    @ordinal_position_param ||= params[:ordinal_position].to_i
  end

  def render_appropriate_turbo_stream_for_create(new_ordinal_position:)
    if new_ordinal_position.zero?
      render turbo_stream: turbo_stream.replace(first_basic_note_turbo_id,
                                                template: "basic_notes/show",
                                                locals: { basic_note: @basic_note })
    else
      previous_sibling = @article.basic_notes.find_by(ordinal_position: new_ordinal_position - 1)
      render turbo_stream: turbo_stream.after(previous_sibling.turbo_id,
                                              template: "basic_notes/show",
                                              locals: { basic_note: @basic_note })
    end
  end

  def first_basic_note_turbo_id
    BasicNote::TurboFrameable::TURBO_NEW_BASIC_NOTE_ID_PREFIX
  end
end
