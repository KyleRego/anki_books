# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Represents an Anki cloze note
# == Schema Information
#
# Table name: cloze_notes
#
#  id         :uuid             not null, primary key
#  sentence   :text             not null
#  article_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  anki_guid  :string           not null
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
class ClozeNote < Note
  include HasAnkiContentable::ClozeNote

  include ERB::Util
  include Rails.application.routes.url_helpers

  def cloze_sentence_answer
    sentence.gsub(ClozeTextHelperModule.cloze_markers_container_regex, '\1')
  end

  def cloze_sentence_question
    sentence.gsub(ClozeTextHelperModule.cloze_markers_container_regex, "[...]")
  end
end
