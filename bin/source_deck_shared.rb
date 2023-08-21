# frozen_string_literal: true

# rubocop:disable Naming/ConstantName
Package_name = "anki_books_source_code_deck"
Deck_name = "Anki Books source"
Note_type_name = "Anki Books source type"
File_extensions_to_keep = [".rb", ".js"].freeze
Patterns_to_exclude_from = ["db/migrate", "public/assets"].freeze
# rubocop:enable Naming/ConstantName

def setup_note_type(anki21_database:)
  note_type = AnkiRecord::NoteType.new(name: Note_type_name, anki21_database:)

  AnkiRecord::NoteField.new(name: "Code", note_type:)
  AnkiRecord::NoteField.new(name: "File", note_type:)

  card_template = AnkiRecord::CardTemplate.new(name: "Template 1", note_type:)
  card_template.question_format = "{{Code}}"
  card_template.answer_format = "{{Code}}<hr id=answer>{{File}}"

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
  note_type
end

def file_should_be_skipped?(file:)
  return true unless File_extensions_to_keep.any? { |ext| file.end_with?(ext) }

  return true if Patterns_to_exclude_from.any? { |pat| file.include?(pat) }

  false
end
