# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

When "I check the checkbox for the basic note with front {string}" do |string|
  basic_note = BasicNote.find_by(front: string)
  check(basic_note.id)
end
