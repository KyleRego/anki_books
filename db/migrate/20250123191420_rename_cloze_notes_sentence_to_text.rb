# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2025 Kyle Rego

# frozen_string_literal: true

class RenameClozeNotesSentenceToText < ActiveRecord::Migration[7.0]
  def change
    change_table :notes do |t|
      t.rename :sentence, :cloze_text
    end
  end
end
