# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# This will leave the ordinal positions of notes in a state that it can then be fixed by the FixOrdinalPositionsJob
class MoveClozeNotesToNotes < ActiveRecord::Migration[7.0]
  def up
    execute <<~SQL
      INSERT INTO notes (id, sentence, ordinal_position, article_id, created_at, updated_at, anki_guid, type)
      SELECT id, sentence, (round(random() * 100000)), article_id, created_at, updated_at, anki_guid, 'ClozeNote'
      FROM cloze_notes cn;
    SQL
  end
end
