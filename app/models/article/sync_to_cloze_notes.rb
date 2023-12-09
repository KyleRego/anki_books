# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "text"

# Some of this can be reused possibly, so I'm leaving it here for now.
# Article::SyncToClozeNotes was a module included into Article
# when the cloze notes were created from sentences in the article
##
# A mapping between an article cloze sentence and one of the article's cloze notes
class ClozeNoteSentenceMatch
  def initialize(article_sentence:, cloze_note:, distance:)
    @article_sentence = article_sentence
    @cloze_note = cloze_note
    @distance = distance
  end

  attr_reader :distance, :article_sentence, :cloze_note

  private

  def inspect
    # :nocov:
    "\"ClozeNoteSentenceMatch article_sentence: #{article_sentence} cloze_note_sentence: #{cloze_note.sentence} distance: #{distance}\""
    # :nocov:
  end
end

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity

##
# Module for methods related to extracting cloze notes from articles
module Article::SyncToClozeNotes
  ##
  # Returns the article content with Anki cloze deletion markers removed
  # TODO: This should only hide markers if they are correctly contained
  # inside a sentence that will be used to create a cloze note
  def content_without_cloze_markers
    ActionText::Content.new content.body&.to_html&.gsub(CLOZE_MARKERS_CONTAINER, '\1')
  end

  ##
  # Returns an array of strings which are the sentences that match the cloze sentence regular expression
  def cloze_sentences
    content.to_plain_text
  end

  ##
  # Returns an array of ClozeSentenceConcepts structs that represent the sentences and
  # what concepts are present in them
  def cloze_sentence_concepts_structs
    cloze_sentences.map do |cloze_sent|
      concepts = 
      ClozeSentenceConcepts.new(sentence: cloze_sent, concepts:)
    end
  end



  public

  ##
  # Syncs the cloze sentences of the article with its cloze notes
  def sync_to_cloze_notes(users:)
    cloze_sent_concepts_structs = cloze_sentence_concepts_structs
    note_cloze_sentence_match = []
    synced_cloze_note_ids = []

    users.each do |user|
      cloze_sent_concepts_structs.each do |cloze_sent_concepts_struct|
        cloze_sent_concepts_struct.cloze_note_synced = false

        concepts_for_cloze_note = []
        cloze_sent_concepts_struct.concepts.each do |concept_name|
          existing_concept = user.concepts.where("lower(name) = ?", concept_name.downcase).first
          concepts_for_cloze_note << (existing_concept || user.concepts.create!(name: concept_name))
        end
        cloze_sent_concepts_struct.concepts = concepts_for_cloze_note

        cloze_sentence = cloze_sent_concepts_struct.sentence

        # rubocop:disable Style/MultilineBlockChain
        levenshtein_ordered_cloze_notes = cloze_notes.map do |cloze_note|
          [cloze_note, Text::Levenshtein.distance(cloze_sentence, cloze_note.sentence)]
        end.sort_by do |_, distance|
          distance
        end
        # rubocop:enable Style/MultilineBlockChain

        levenshtein_ordered_cloze_notes.each do |cloze_note_with_distance|
          note_cloze_sentence_match << ClozeNoteSentenceMatch.new(article_sentence: cloze_sentence,
                                                                  cloze_note: cloze_note_with_distance[0],
                                                                  distance: cloze_note_with_distance[1])
        end
      end
    end

    sorted_note_cloze_sentence_match = note_cloze_sentence_match.sort_by(&:distance)
    best_cloze_note_sentence_matches = sorted_note_cloze_sentence_match.group_by do |cloze_note_sentence_match|
      cloze_note_sentence_match.cloze_note.sentence
    end.values.map(&:first).group_by(&:article_sentence).values.map(&:first)

    best_cloze_note_sentence_matches.each do |cloze_note_sentence_match|
      article_sentence = cloze_note_sentence_match.article_sentence
      cloze_sent_concepts_struct = cloze_sent_concepts_structs.find { |sc_match| sc_match.sentence == article_sentence }
      cloze_note = cloze_note_sentence_match.cloze_note
      cloze_note.concepts = cloze_sent_concepts_struct.concepts
      cloze_note.update!(sentence: article_sentence)
      cloze_sent_concepts_struct.cloze_note_synced = true
      synced_cloze_note_ids << cloze_note.id
    end

    cloze_sent_concepts_structs.select { |sc_match| sc_match.cloze_note_synced == false }.each do |cloze_sent_concepts_struct|
      article_sentence = cloze_sent_concepts_struct.sentence
      cloze_note = cloze_notes.create!(sentence: article_sentence, concepts: cloze_sent_concepts_struct.concepts,
                                       ordinal_position: notes_count)
      synced_cloze_note_ids << cloze_note.id
    end

    cloze_notes.where.not(id: synced_cloze_note_ids).destroy_all
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
