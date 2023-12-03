# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class RenameConceptsNotesClozeNoteIdColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :concepts_notes, :cloze_note_id, :note_id
  end
end
