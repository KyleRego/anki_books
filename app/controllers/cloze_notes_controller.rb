# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class ClozeNotesController < ApplicationController
  before_action :require_login
  before_action :require_turbo_request
  before_action :find_article_from_article_id_param
  before_action :find_cloze_note_from_cloze_note_id_param, only: %w[update]

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  def create
    @previous_sibling = @article.notes.find_by(ordinal_position: ordinal_position_param - 1)

    text = params[:cloze_note][:text]

    head :bad_request and return if text.blank?

    cloze_sentences = ::ClozeTextHelperModule.split_text_to_cloze_sentences(text:)

    if cloze_sentences.empty?
      @note = @article.cloze_notes.new(sentence: text)
      @note.errors.add(:base, :invalid, message: "Text must have at least one cloze sentence")
      @cloze_notes_text = text

      render turbo_stream: turbo_stream.replace("note-form",
                                                partial: "cloze_notes/form") and return 
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

    # TODO: This is a temporary workaround
    # Probably need to make only one cloze note record
    # and have cards created from that instead of what the above is doing
    @note = @cloze_notes.first
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength

  def update
    # TODO: This needs to validate that the edited
    # note still has valid cloze deletions
    if @cloze_note.update(cloze_note_params) # rubocop:disable Style/GuardClause
      @note = @cloze_note
    else
      render turbo_stream: turbo_stream.replace("note-form",
                                                partial: "cloze_notes/form",
                                                status: :unprocessable_entity) and return 
    end
  end

  private

  def cloze_note_params
    params.require(:cloze_note).permit(:text)
  end

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
