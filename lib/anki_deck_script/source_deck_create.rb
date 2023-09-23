# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "anki_record"
require_relative "source_deck_shared"

AnkiRecord::AnkiPackage.create(name: Package_name) do |anki21_database|
  deck = AnkiRecord::Deck.new(name: Deck_name, anki21_database:)
  deck.save

  note_type = setup_note_type(anki21_database:)

  Dir.glob("**/*") do |file|
    next if file_should_be_skipped?(file:)

    file = File.open(file)

    contents = file.read
    note_code_content = "<pre><code>#{contents}</code></pre>"

    note = AnkiRecord::Note.new(note_type:, deck:)
    note.file = "#{file.path}: #{DateTime.now.strftime('%b %d %I:%M %z')}"
    note.code = note_code_content
    note.save

    file.close
  end
end
