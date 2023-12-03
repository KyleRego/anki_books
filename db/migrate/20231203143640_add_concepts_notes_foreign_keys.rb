# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddConceptsNotesForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "concepts_notes", "notes"
    add_foreign_key "concepts_notes", "concepts"
  end
end
