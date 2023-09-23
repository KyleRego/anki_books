# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "text"

##
# A mapping between an article cloze sentence and concepts
class SentenceConceptsMatch
  def initialize(sentence:)
    @sentence = sentence
    @concepts = []
    @cloze_note_synced = false
  end

  attr_accessor :cloze_note_synced

  attr_reader :sentence, :concepts

  def <<(concept)
    @concepts << concept
  end

  def delete(concept:)
    @concepts.delete(concept)
  end

  def inspect
    # :nocov:
    concept_names = concepts.map(&:name).join(", ")
    "\"SentenceConceptsMatch article_sentence: #{sentence} concepts: #{concept_names}\""
    # :nocov:
  end
end

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
  # Returns an array of strings which are the matching sentences
  # of the article for the string +concept_name+
  def cloze_sentences(concept_name:)
    article_content = content.to_plain_text
    regex_for_concept = cloze_sentence_regex(concept_name:)
    article_content.scan(regex_for_concept).flatten
  end

  ##
  # Returns an array of SentenceConceptMatch objects. Best understood
  # by reading the output of the RSpec specifications with --format doc
  def cloze_sentence_concept_matches(concepts:)
    sentence_concepts_matches = []

    concepts.each do |concept|
      concept_name = concept.name
      article_cloze_sentences = cloze_sentences(concept_name:)
      article_cloze_sentences.each do |article_cloze_sentence|
        match = sentence_concepts_matches.find { |sc_match| sc_match.sentence == article_cloze_sentence }
        unless match
          match = SentenceConceptsMatch.new(sentence: article_cloze_sentence)
          sentence_concepts_matches << match
        end
        match << concept
      end
    end

    sentence_concepts_matches.each do |match|
      next unless match.concepts.count > 1

      sentence_with_concepts_edited_out = match.sentence

      concepts_ordered_by_decreasing_length = match.concepts.sort_by { |match_conc| match_conc.name.length }.reverse

      concepts_ordered_by_decreasing_length.each_with_index do |match_concept, index|
        match_conc_name = match_concept.name
        if index.zero? || sentence_with_concepts_edited_out =~ /\b#{match_conc_name}\b/
          sentence_with_concepts_edited_out = sentence_with_concepts_edited_out.gsub(match_conc_name, "")
        else
          match.delete(concept: match_concept)
        end
      end
    end

    sentence_concepts_matches
  end

  private

  CLOZE_SENTENCE_START = /(?<=\A|\n|\. )/
  CLOZE_SENTENCE_END = /\."?/

  def cloze_sentence_regex(concept_name:)
    /#{CLOZE_SENTENCE_START}[^.\n]*\b#{concept_name}\b[^.\n]*#{CLOZE_SENTENCE_END}/
  end

  public

  ##
  # Syncs the cloze sentences of the article with its cloze notes
  def sync_to_cloze_notes
    sentence_concepts_matches = cloze_sentence_concept_matches(concepts:)
    cloze_note_sentence_matches = []
    synced_cloze_note_ids = []

    sentence_concepts_matches.each do |sentence_concepts_match|
      article_sentence = sentence_concepts_match.sentence
      logger.debug(article_sentence)

      # TODO: Refactor this to use a struct or tuple or something
      # rubocop:disable Style/MultilineBlockChain
      levenshtein_ordered_cloze_notes = cloze_notes.map do |cloze_note|
        [cloze_note, Text::Levenshtein.distance(article_sentence, cloze_note.sentence)]
      end.sort_by do |_, distance|
        distance
      end
      # rubocop:enable Style/MultilineBlockChain

      levenshtein_ordered_cloze_notes.each do |cloze_note_with_distance|
        cloze_note_sentence_matches << ClozeNoteSentenceMatch.new(article_sentence:,
                                                                  cloze_note: cloze_note_with_distance[0],
                                                                  distance: cloze_note_with_distance[1])
      end
    end

    sorted_cloze_note_sentence_matches = cloze_note_sentence_matches.sort_by(&:distance)
    uniq_cloze_note_sentence_matches = sorted_cloze_note_sentence_matches.group_by do |cloze_note_sentence_match|
      cloze_note_sentence_match.cloze_note.sentence
    end.values.map(&:first).group_by(&:article_sentence).values.map(&:first)

    uniq_cloze_note_sentence_matches.each do |cloze_note_sentence_match|
      article_sentence = cloze_note_sentence_match.article_sentence
      sentence_concepts_match = sentence_concepts_matches.find { |sc_match| sc_match.sentence == article_sentence }
      cloze_note = cloze_note_sentence_match.cloze_note
      cloze_note.concepts = sentence_concepts_match.concepts
      cloze_note.update!(sentence: article_sentence)
      sentence_concepts_match.cloze_note_synced = true
      synced_cloze_note_ids << cloze_note.id
    end

    sentence_concepts_matches.select { |sc_match| sc_match.cloze_note_synced == false }.each do |sentence_concept_match|
      article_sentence = sentence_concept_match.sentence
      next if cloze_notes.find_by(sentence: article_sentence)

      cloze_note = cloze_notes.create!(sentence: article_sentence)
      cloze_note.concepts = sentence_concept_match.concepts
      synced_cloze_note_ids << cloze_note.id
    end

    cloze_notes.where.not(id: synced_cloze_note_ids).destroy_all
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
