# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class CreateClozeNotesConcepts < ActiveRecord::Migration[7.0]
  def change
    create_table :cloze_notes_concepts, id: :uuid do |t|
      t.uuid :cloze_note_id
      t.uuid :concept_id

      t.timestamps

      t.index [:cloze_note_id, :concept_id], unique: true
    end
  end
end
