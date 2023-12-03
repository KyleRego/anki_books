# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class RenameClozeNotesConceptsTable < ActiveRecord::Migration[7.0]
  def change
    rename_table :cloze_notes_concepts, :concepts_notes
  end
end
