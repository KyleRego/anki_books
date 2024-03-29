# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Module methods to help with processing text with Anki cloze note syntax
module ClozeTextHelperModule
  CLOZE_SENTENCE_START = /(?<=\A|\n|\. )/
  CLOZE_MARKERS_CONTAINER = /\{\{c\d::(.*?)\}\}/
  CLOZE_SENTENCE_END = /\."?/

  # TODO: See about making those constants private to this module

  def self.cloze_markers_container_regex
    CLOZE_MARKERS_CONTAINER
  end

  def self.cloze_sentence_regular_expression
    /(#{CLOZE_SENTENCE_START}[^.\n]*#{CLOZE_MARKERS_CONTAINER}[^.\n]*#{CLOZE_SENTENCE_END})/o
  end

  def self.split_text_to_cloze_sentences(text:)
    text.scan(cloze_sentence_regular_expression).map(&:first)
  end

  def self.extract_concept_names_from_text(text:)
    text.scan(CLOZE_MARKERS_CONTAINER).flatten
  end
end
