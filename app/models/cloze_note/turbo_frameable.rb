# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the Turbo Frame elements for cloze notes.
module ClozeNote::TurboFrameable
  NEW_CLOZE_NOTE_TURBO_ID = "new-cloze-note"
  TURBO_BASIC_NOTE_ID_PREFIX = "cloze-note-"

  def turbo_id
    "#{TURBO_BASIC_NOTE_ID_PREFIX}#{id}"
  end
end
