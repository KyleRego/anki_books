# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_26_151536) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "fuzzystrmatch"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.datetime "created_at", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "variation_digest", null: false
    t.uuid "blob_id", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "system", default: false, null: false
    t.uuid "book_id", null: false
    t.integer "ordinal_position", null: false
    t.boolean "reading", default: true, null: false
    t.boolean "writing", default: false, null: false
    t.boolean "complete", default: false, null: false
    t.index ["ordinal_position", "book_id"], name: "index_articles_on_ordinal_position_and_book_id", unique: true
    t.check_constraint "ordinal_position >= 0", name: "articles_ordinal_position_check"
  end

  create_table "basic_notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "front"
    t.text "back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "article_id", null: false
    t.integer "ordinal_position", null: false
    t.string "anki_guid", null: false
    t.index ["anki_guid"], name: "index_basic_notes_on_anki_guid", unique: true
    t.index ["ordinal_position", "article_id"], name: "index_basic_notes_on_ordinal_position_and_article_id", unique: true
    t.check_constraint "ordinal_position >= 0", name: "basic_notes_ordinal_position_check"
  end

  create_table "books", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "parent_book_id"
    t.boolean "public", default: false, null: false
  end

  create_table "books_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "user_id"], name: "index_books_users_on_book_id_and_user_id", unique: true
  end

  create_table "cloze_notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "sentence", null: false
    t.uuid "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "anki_guid", null: false
    t.index ["anki_guid"], name: "index_cloze_notes_on_anki_guid", unique: true
    t.index ["article_id"], name: "index_cloze_notes_on_article_id"
  end

  create_table "cloze_notes_concepts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "cloze_note_id", null: false
    t.uuid "concept_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloze_note_id", "concept_id"], name: "index_cloze_notes_concepts_on_cloze_note_id_and_concept_id", unique: true
  end

  create_table "concepts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index "lower((name)::text)", name: "index_concepts_on_lower_name", unique: true
    t.index ["user_id", "name"], name: "index_concepts_on_user_id_and_name", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "books"
  add_foreign_key "basic_notes", "articles"
  add_foreign_key "books", "books", column: "parent_book_id"
  add_foreign_key "books_users", "books"
  add_foreign_key "books_users", "users"
  add_foreign_key "cloze_notes", "articles"
  add_foreign_key "cloze_notes_concepts", "cloze_notes"
  add_foreign_key "cloze_notes_concepts", "concepts"
  add_foreign_key "concepts", "users"
end
