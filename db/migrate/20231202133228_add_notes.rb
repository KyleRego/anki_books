# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddNotes < ActiveRecord::Migration[7.0]
  def change
    create_table "notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.text "front"
      t.text "back"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "article_id", null: false
      t.integer "ordinal_position", null: false
      t.string "anki_guid", null: false
      t.index ["anki_guid"], name: "index_notes_on_anki_guid", unique: true
      t.index ["ordinal_position", "article_id"], name: "index_notes_on_ordinal_position_and_article_id", unique: true
      t.check_constraint "ordinal_position >= 0", name: "notes_ordinal_position_check"
    end
  end
end
