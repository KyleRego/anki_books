# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

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
  # Syncs the cloze sentences of the article with its cloze notes
  def sync_to_cloze_notes
    concepts = book.concepts
    sentence_concepts_matches = []
    cloze_note_sentence_matches = []
    synced_cloze_note_ids = []

    concepts.each do |concept|
      concept_name = concept.name
      article_cloze_sentences = cloze_sentences(concept_name:)
      article_cloze_sentences.each do |article_cloze_sentence|
        match = sentence_concepts_matches.find { |sc_match| sc_match.sentence == article_cloze_sentence }
        match ||= SentenceConceptsMatch.new(sentence: article_cloze_sentence)

        match << concept
        sentence_concepts_matches << match
      end
    end

    sentence_concepts_matches.each do |sentence_concepts_match|
      sentence = sentence_concepts_match.sentence.gsub("'", "\\'")

      levenshtein_ordered_cloze_notes = cloze_notes
                                        .select("*, levenshtein(sentence, '#{sentence}'::text) AS distance")
                                        .order("distance ASC")
      levenshtein_ordered_cloze_notes.each do |cloze_note_with_distance|
        cloze_note_sentence_matches << ClozeNoteSentenceMatch.new(article_sentence: sentence,
                                                                  cloze_note: cloze_note_with_distance,
                                                                  distance: cloze_note_with_distance.distance)
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

  private

CLOZE_SENTENCE_START = /(?<=\A|\n|\. )/
CLOZE_SENTENCE_END = /\."?/

def cloze_sentence_regex(concept_name:)
  /#{CLOZE_SENTENCE_START}[^.\n]*\b#{concept_name}\b[^.\n]*#{CLOZE_SENTENCE_END}/
end

##
# A mapping between an article cloze sentence and concepts
class SentenceConceptsMatch
  def initialize(sentence:)
    @sentence = sentence
    @concepts = []
  end

  attr_accessor :cloze_note_synced

  attr_reader :sentence, :concepts

  def <<(concept)
    @concepts << concept
    @cloze_note_synced = false
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

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
