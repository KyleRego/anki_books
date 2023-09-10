# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddBooksConceptsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table "books_concepts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid "book_id", null: false
      t.uuid "concept_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["book_id", "concept_id"], name: "index_books_concepts_on_book_id_and_concept_id", unique: true
    end
  end
end
