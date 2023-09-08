# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nocov:
class ClozeNotesConcept < ApplicationRecord
  belongs_to :cloze_note
  belongs_to :concept
end
