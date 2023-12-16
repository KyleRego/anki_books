# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for basic notes
module HasAnkiContentable::BasicNote
  extend ActiveSupport::Concern

  def anki_front
    format_for_input_to_anki(field: front)
  end

  def anki_back
    format_for_input_to_anki(field: back)
  end

  def url
    "#{article_url(article)}##{turbo_dom_id}"
  end

  private

  def format_for_input_to_anki(field:)
    html_escape(field).gsub("\n", "<br>")
  end
end
