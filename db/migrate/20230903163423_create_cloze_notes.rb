# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class CreateClozeNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :cloze_notes, id: :uuid do |t|
      t.text :sentence
      t.references :article, null: false, foreign_key: true, type: :uuid
      t.references :concept, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
