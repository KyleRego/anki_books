# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class RemoveClozeNotesForeignKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key "cloze_notes", "articles"
    remove_foreign_key "cloze_notes_concepts", "cloze_notes"
    remove_foreign_key "cloze_notes_concepts", "concepts"
  end
end
