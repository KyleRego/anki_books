# frozen_string_literal: true

# :nodoc:
class BasicNotesController < ApplicationController
  include BasicNotesHelper

  before_action :require_login, only: %i[create edit update new]
  before_action :require_turbo_request
  before_action :set_article, only: %i[create edit update new show]
  before_action :require_user_can_access_article, only: %i[create edit update new]
  before_action :set_basic_note, only: %i[show edit update]
  before_action :require_user_can_access_note, only: %i[edit update]

  def show; end

  def new
    # Turbo-Frame header has the id of the turbo frame element
    # and the last 36 characters of this are the id of the basic note
    # which is the previous sibling. If it's the very first new basic note
    # turbo frame element, it is not the id of a previous sibling.
    sibling_note_id = request.headers["Turbo-Frame"].last(36)
    @previous_sibling = if sibling_note_id == first_new_basic_note_turbo_id
                          nil
                        else
                          BasicNote.find(sibling_note_id)
                        end
    @basic_note = @article.basic_notes.new
  end

  def edit
    @on_study_cards = true if request.referer&.end_with?("study_cards")
  end

  def create
    @basic_note = @article.basic_notes.new(basic_note_params)
    @basic_note.ordinal_position = @article.notes_count
    @previous_sibling = @article.basic_notes.find_by(ordinal_position: ordinal_position_param - 1)

    unless @basic_note.valid? && OrdinalPositions::AddChildAtPosition.perform(parent: @article,
                                                                              child_to_position: @basic_note,
                                                                              new_ordinal_position: ordinal_position_param)
      turbo_id = @previous_sibling ? @previous_sibling.new_sibling_note_turbo_id : first_new_basic_note_turbo_id
      render turbo_stream: turbo_stream.replace(turbo_id,
                                                template: "basic_notes/new",
                                                locals: { basic_note: @basic_note })
    end
  end

  def update
    if @basic_note.update(basic_note_params)
      if params[:options][:on_study_cards] == "true"
        render turbo_stream: turbo_stream.replace(@basic_note.turbo_id,
                                                  partial: "study_cards/basic_note",
                                                  locals: { basic_note: @basic_note })
      else
        redirect_to article_basic_note_path(@article, @basic_note)
      end
    else
      render :edit, status: :unprocessable_entity
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

  def require_user_can_access_article
    current_user.can_access_article?(article: @article)
  end

  def require_user_can_access_note
    current_user.can_access_note?(note: @basic_note)
  end
end
