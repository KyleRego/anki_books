# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class MoveBasicNotesToNotes < ActiveRecord::Migration[7.0]
  def up
    execute <<~SQL
      INSERT INTO notes (id, front, back, ordinal_position, article_id, created_at, updated_at, anki_guid)
      SELECT id, front, back, ordinal_position, article_id, created_at, updated_at, anki_guid
      FROM basic_notes;
    SQL
  end
end
