# frozen_string_literal: true

require "anki_record"

AnkiRecord::AnkiPackage.create(name: "anki_books_source_code_deck") do |anki21_database|
  deck = AnkiRecord::Deck.new(name: "Anki Books source", anki21_database:)
  deck.save

  note_type = AnkiRecord::NoteType.new(name: "Code source type", anki21_database:)

  AnkiRecord::NoteField.new(name: "Code", note_type:)
  AnkiRecord::NoteField.new(name: "Notes", note_type:)

  card_template = AnkiRecord::CardTemplate.new(name: "Code and notes", note_type:)
  card_template.question_format = "{{Code}}"
  card_template.answer_format = "{{Code}}<hr id=answer>{{Notes}}"

  css = <<~CSS
    .card {
      font-family: monospace;
      font-size: 20px;
      text-align: left;
      color: black;
      background-color: white;
    }
  CSS
  note_type.css = css
  note_type.save

  Dir.glob("**/*") do |file|
    next unless file.end_with?(".rb", ".js")
    next if file.include?("db/migrate")
    next if file.include?("public/assets")

    file = File.open(file)

    contents = file.read
    note_code_content = "#{file.path}<br><br><pre><code>#{contents}</code></pre>"

    note = AnkiRecord::Note.new(note_type:, deck:)
    note.code = note_code_content
    note.save

    file.close
  end
end
