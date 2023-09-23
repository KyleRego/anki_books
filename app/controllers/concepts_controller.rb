# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ConceptsController < ApplicationController
  before_action :require_login
  before_action :set_concept, except: %w[index new create]

  def index
    @concepts = current_user.concepts.order(:name)
  end

  def show
    @cloze_notes = @concept.cloze_notes.includes(:article)
    @articles = @concept.articles.order(:title)
  end

  def manage
    @user_other_concepts = current_user.concepts.ordered
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

  def destroy
    @concept.destroy!
    redirect_to concepts_path
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
