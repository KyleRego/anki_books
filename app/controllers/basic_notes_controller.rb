# frozen_string_literal: true

##
# Handles actions related to Basic notes.
class BasicNotesController < ApplicationController
  before_action :set_basic_note, only: %i[show edit update]

  def show; end

  def new
    @basic_note = BasicNote.new
  end

  def edit; end

  def create
    @basic_note = BasicNote.new(basic_note_params)
  end

  def update; end

  private

  def set_basic_note
    @basic_note = BasicNote.find(params[:id])
  end

  def basic_note_params
    params.require(:basic_note).permit(:front, :back)
  end
end
