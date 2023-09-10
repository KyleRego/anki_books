# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: cloze_notes_concepts
#
#  id            :uuid             not null, primary key
#  cloze_note_id :uuid             not null
#  concept_id    :uuid             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (cloze_note_id => cloze_notes.id)
#  fk_rails_...  (concept_id => concepts.id)
#
class ClozeNotesConcept < ApplicationRecord
  belongs_to :cloze_note
  belongs_to :concept
end
