# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ClozeNotesController < ApplicationController
  before_action :require_login
  before_action :require_turbo_request
  before_action :find_article_from_article_id_param
  before_action :find_cloze_note_from_cloze_note_id_param, only: %w[edit update]

  def new
    previous_sibling_note_id = request.headers["Turbo-Frame"].last(36)
    @previous_sibling = if previous_sibling_note_id == Note.new_ordinal_position_zero_note_turbo_id
                          nil
                        else
                          Note.find(previous_sibling_note_id)
                        end
    @cloze_note = @article.cloze_notes.new
  end

  def edit; end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def create
    @previous_sibling = @article.notes.find_by(ordinal_position: ordinal_position_param - 1)

    turbo_id = if @previous_sibling
                 @previous_sibling.new_next_note_sibling_after_note_turbo_id
               else
                 Note.new_ordinal_position_zero_note_turbo_id
               end

    text = params[:cloze_note][:text]

    if text.blank?
      @cloze_note = @article.cloze_notes.new
      @cloze_note.errors.add(:base, :invalid, message: "Text can't be blank")

      render turbo_stream: turbo_stream.replace(turbo_id, template: "cloze_notes/new") and return    
    end

    cloze_sentences = ::ClozeTextHelperModule.split_text_to_cloze_sentences(text:)

    if cloze_sentences.empty?
      @cloze_note = @article.cloze_notes.new
      @cloze_note.errors.add(:base, :invalid, message: "Text must have at least one cloze sentence")
      @cloze_notes_text = text

      render turbo_stream: turbo_stream.replace(turbo_id, template: "cloze_notes/new") and return
    end

    @cloze_notes = []

    cloze_sentences.each do |cloze_sentence|
      concept_names = ::ClozeTextHelperModule.extract_concept_names_from_text(text: cloze_sentence)
      concepts_for_cloze_note = []

      concept_names.each do |concept_name|
        concept = current_user.find_existing_concept(concept_name:)

        concept = current_user.concepts.create!(name: concept_name) if concept.nil?

        concepts_for_cloze_note << concept
      end

      cloze_note = @article.cloze_notes.new(sentence: cloze_sentence)
      cloze_note.ordinal_position = @article.notes_count
      cloze_note.save!
      cloze_note.concepts = concepts_for_cloze_note
      @article.reposition_ordinal_child(child: cloze_note, new_ordinal_position: ordinal_position_param)
      @cloze_notes << cloze_note
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength

  def update
    if @cloze_note.update(sentence: params[:cloze_note][:sentence])
      @note = @cloze_note
      render partial: "articles/note/show"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ordinal_position_param
    @ordinal_position_param ||= params[:ordinal_position].to_i
  end

  def find_article_from_article_id_param
    @article = current_user.articles.find_by(id: params[:article_id])
    return if @article

    not_found_or_unauthorized
  end

  def find_cloze_note_from_cloze_note_id_param
    @cloze_note = @article.cloze_notes.find_by(id: params[:id])
    return if @cloze_note

    not_found_or_unauthorized
  end
end
