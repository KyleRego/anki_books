# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def first_new_basic_note_turbo_id
    BasicNote::TurboFrameable::TURBO_FIRST_NEW_BASIC_NOTE_ID
  end
end
