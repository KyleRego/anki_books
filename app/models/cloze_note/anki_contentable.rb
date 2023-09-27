# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for Anki cloze deletion notes
module ClozeNote::AnkiContentable
  def anki_back_extra
    "<br>#{last_downloaded_info}"
  end

  private

  def last_downloaded_info
    "Downloaded from #{article_link}: #{DateTime.current.strftime('%b %d %I:%M %z')}"
  end

  def article_link
    "<a href=\"#{article_url(article)}\">Anki Books</a>"
  end
end
