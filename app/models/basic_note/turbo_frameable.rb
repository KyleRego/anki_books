# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Methods related to the custom HTML Turbo Frame elements for basic notes.
module BasicNote::TurboFrameable
  TURBO_FIRST_NEW_BASIC_NOTE_ID = "turbo-first-basic-note"
  TURBO_NEW_SIBLING_BASIC_NOTE_ID_PREFIX = "turbo-new-basic-note-"
  TURBO_BASIC_NOTE_ID_PREFIX = "turbo-basic-note-"

  def turbo_id
    "#{TURBO_BASIC_NOTE_ID_PREFIX}#{id}"
  end

  def new_sibling_note_turbo_id
    "#{TURBO_NEW_SIBLING_BASIC_NOTE_ID_PREFIX}#{id}"
  end
end
