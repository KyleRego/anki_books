# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for basic notes
module BasicNote::AnkiContentable
  def anki_front
    format_for_input_to_anki(field: front)
  end

  def anki_back
    content = format_for_input_to_anki(field: back)
    "#{content}<br><br>#{note_link}"
  end

  private

  def format_for_input_to_anki(field:)
    html_escape(field).gsub("\n", "<br>")
  end

  def note_link
    "<a href=\"#{article_url(article)}##{turbo_id}\">Edit</a>"
  end
end
