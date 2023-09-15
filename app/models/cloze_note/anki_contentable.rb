# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Anki content generated for Anki cloze deletion notes
module ClozeNote::AnkiContentable
  def anki_text
    result = sentence
    concepts.order(:name).each_with_index do |concept, index|
      result = result.gsub(concept.name, "{{c#{index + 1}::#{concept.name}}}")
    end
    result
  end

  def anki_back_extra
    "<br>#{article_link}<br>#{last_downloaded_at_stamp}"
  end

  private

  def article_link
    "<a href=\"#{article_url(article)}\">Article</a>"
  end

  def last_downloaded_at_stamp
    "Last downloaded at: #{DateTime.current.to_fs(:short)}"
  end
end
