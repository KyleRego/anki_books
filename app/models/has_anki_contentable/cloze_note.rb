# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for Anki cloze deletion notes
module HasAnkiContentable::ClozeNote
  extend ActiveSupport::Concern

  def anki_text
    html_escape(sentence)
  end

  def url
    article_url(article)
  end
end
