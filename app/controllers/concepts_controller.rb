# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ConceptsController < ApplicationController
  before_action :require_login
  before_action :set_concept, only: %w[show manage edit update change_parent_concept]

  def index
    @concepts = current_user.concepts.order(:name)
  end

  def show
    @parent_concept = @concept.parent_concept
    @books = @concept.books.ordered
    @cloze_notes = @concept.cloze_notes.includes(:article)
  end

  def manage
    @user_other_concepts = current_user.concepts.ordered
  end

  def change_parent_concept
    parent_concept = current_user.concepts.find_by(id: params[:parent_concept_id])
    if parent_concept
      parent_concept.concepts << @concept
      redirect_to manage_concept_path(@concept), flash: { notice: "Parent concept updated" }
    else
      not_found_or_unauthorized
    end
  end

  def new
    @concept = Concept.new
  end

  def edit; end

  def create
    @concept = current_user.concepts.new(concept_params)
    if @concept.save
      redirect_to concepts_path, flash: { notice: "#{@concept.name} created successfully" }
    else
      flash.now[:alert] = @concept.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @concept.update(concept_params)
      redirect_to concepts_path, flash: { notice: "#{@concept.name} updated successfully" }
    else
      flash.now[:alert] = @concept.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def concept_params
    params.require(:concept).permit(:name)
  end

  def set_concept
    @concept = current_user.concepts.find_by(id: params[:id])
    return if @concept

    not_found_or_unauthorized
  end
end
