# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength

##
# Syncs the cloze sentences of the article with its cloze notes
class SyncArticleToClozeNotes
  def self.perform(article:, user:)
    new(article:, user:).perform
  end

  attr_reader :article, :concepts

  attr_accessor :sentence_concepts_matches, :cloze_note_sentence_matches

  def initialize(article:, user:)
    @article = article
    @concepts = user.concepts
    @sentence_concepts_matches = []
    @cloze_note_sentence_matches = []
  end

  ##
  # A mapping between an article cloze sentence and concepts
  class SentenceConceptsMatch
    def initialize(sentence:)
      @sentence = sentence
      @concepts = []
    end

    attr_reader :sentence, :concepts

    def <<(concept)
      @concepts << concept
    end

    private

    def concept_names
      concepts.map(&:name).join(", ")
    end

    def inspect
      "\"Match sentence: #{sentence} concepts: #{concept_names}\""
    end
  end

  ##
  # A mapping between an article cloze sentence and one of the article's cloze notes
  class ClozeNoteSentenceMatch
    def initialize(sentence:, cloze_note:, distance:)
      @sentence = sentence
      @cloze_note = cloze_note
      @distance = distance
    end

    attr_reader :distance

    private

    attr_reader :cloze_note, :sentence

    def inspect
      "\"Match cloze: #{sentence} article: #{cloze_note.sentence} distance: #{distance}\""
    end
  end

  def perform
    concepts.each do |concept|
      concept_name = concept.name
      article_cloze_sentences = article.cloze_sentences(concept_name:)
      article_cloze_sentences.each do |article_cloze_sentence|
        match = sentence_concepts_matches.find { |sc_match| sc_match.sentence == article_cloze_sentence }
        match ||= SentenceConceptsMatch.new(sentence: article_cloze_sentence)

        match << concept
        sentence_concepts_matches << match
      end
    end

    sentence_concepts_matches.each do |sentence_concepts_match|
      sentence = sentence_concepts_match.sentence

      levenshtein_ordered_cloze_notes = ClozeNote
                                        .select("*, levenshtein(sentence, '#{sentence}'::text) AS distance")
                                        .order("distance ASC")

      levenshtein_ordered_cloze_notes.each do |cloze_note_with_distance|
        cloze_note_sentence_matches << ClozeNoteSentenceMatch.new(sentence:,
                                                                  cloze_note: cloze_note_with_distance,
                                                                  distance: cloze_note_with_distance.distance)
      end
    end

    # rubocop:disable Lint/UselessAssignment
    sorted_cloze_note_sentence_matches = cloze_note_sentence_matches.sort_by(&:distance)
    cloze_note_sentence_matches = sorted_cloze_note_sentence_matches
    # rubocop:enable Lint/UselessAssignment

    # p sentence_concepts_matches
    # p cloze_note_sentence_matches
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
