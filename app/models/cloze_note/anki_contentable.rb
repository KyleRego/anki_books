# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for Anki cloze deletion notes
module ClozeNote::AnkiContentable
  def anki_text
    result = sentence
    parent_concepts = Concept.where(id: concepts.pluck(:parent_concept_id))

    cloze_counter = 0
    concepts.order(:name).each do |concept|
      next if parent_concepts.include?(concept)

      result = result.gsub(concept.name, "{{c#{cloze_counter + 1}::#{concept.name}}}")
      cloze_counter += 1
    end
    result
  end

  def anki_back_extra
    "<br>#{last_downloaded_at_stamp}"
  end

  private

  def article_link
    "<a href=\"#{article_url(article)}\">Anki Books</a>"
  end

  def last_downloaded_at_stamp
    "Downloaded from #{article_link}: #{DateTime.current.strftime('%b %d %I:%M %z')}"
  end
end
