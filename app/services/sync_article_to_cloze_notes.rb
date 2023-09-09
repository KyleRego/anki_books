# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity

##
# Syncs the cloze sentences of the article with its cloze notes
class SyncArticleToClozeNotes
  def self.perform(article:, user:)
    new(article:, user:).perform
  end

  attr_reader :article, :concepts

  attr_accessor :sentence_concepts_matches, :cloze_note_sentence_matches, :synced_cloze_note_ids

  def initialize(article:, user:)
    @article = article
    @concepts = user.concepts
    @sentence_concepts_matches = []
    @cloze_note_sentence_matches = []
    @synced_cloze_note_ids = []
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

    private

    def concept_names
      concepts.map(&:name).join(", ")
    end

    def inspect
      "\"SentenceConceptsMatch article_sentence: #{sentence} concepts: #{concept_names}\""
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
      "\"ClozeNoteSentenceMatch article_sentence: #{article_sentence} cloze_note_sentence: #{cloze_note.sentence} distance: #{distance}\""
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

      levenshtein_ordered_cloze_notes = article
                                        .cloze_notes
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
    # sentence_concepts_matches.each { |f| p f }
    # uniq_cloze_note_sentence_matches.each { |f| p f }
    # puts

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
      cloze_note = article.cloze_notes.create!(sentence: sentence_concept_match.sentence)
      cloze_note.concepts = sentence_concept_match.concepts
      synced_cloze_note_ids << cloze_note.id
    end

    article.cloze_notes.where.not(id: synced_cloze_note_ids).destroy_all
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
