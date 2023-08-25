# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "anki_record"
require_relative "source_deck_shared"

AnkiRecord::AnkiPackage.update(path: "./#{Package_name}.apkg") do |anki21_database|
  deck = anki21_database.find_deck_by(name: Deck_name)
  note_type = setup_note_type(anki21_database:)

  Dir.glob("**/*") do |file|
    next if file_should_be_skipped?(file:)

    file = File.open(file)

    contents = file.read
    note_code_content = "<pre><code>#{contents}</code></pre>"
    file_path = file.path

    note = anki21_database.find_notes_by_exact_text_match(text: file_path).first
    note ||= AnkiRecord::Note.new(note_type:, deck:)
    note.file = file_path
    note.code = note_code_content
    note.save

    file.close
  end
end
