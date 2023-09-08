# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Syncs the cloze sentences of the article with its cloze notes
class SyncArticleToClozeNotes
  def self.perform(article:, user:)
    new(article:, user:).perform
  end

  attr_reader :article, :concept_names

  def initialize(article:, user:)
    @article = article
    @concept_names = user.concepts.pluck(:name)
  end

  def perform
    concept_names.each do |concept_name|
      sentences = article.cloze_sentences(concept_name:)

      # rubocop:disable Lint/UselessAssignment
      sentences.each do |sentence|
        levenshtein_ordered_cloze_notes = ClozeNote
                                          .select("*, levenshtein(sentence, '#{sentence}'::text) AS distance")
                                          .order("distance ASC")
        # rubocop:enable Lint/UselessAssignment
      end
    end
  end
end
