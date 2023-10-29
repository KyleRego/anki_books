# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

module AnkiRecord
  class NoteType # :nodoc:
    attr_accessor :id
  end
end

module AnkiPackages
  ##
  # Shared methods for create Anki package jobs
  # that are related to the Anki Record classes and Anki notes
  module AnkiNotes
    private

    def anki_books_basic_note_type(anki21_database:)
      basic_note_type = AnkiRecord::NoteType.new(anki21_database:,
                                                 name: "Anki Books Basic Note")
      # Since we are always creating the Anki package from scratch currently
      # (with the note types being identical) for the import to update existing
      # notes, we need to set the id of the note type so that it is always the same
      # If the note type changes, the id value here should be changed too.
      # Also see comment in anki_books_cloze_note_type
      basic_note_type.id = "1697018590578"
      AnkiRecord::NoteField.new(note_type: basic_note_type, name: "Front")
      AnkiRecord::NoteField.new(note_type: basic_note_type, name: "Back")
      AnkiRecord::NoteField.new(note_type: basic_note_type, name: "URL")
      AnkiRecord::NoteField.new(note_type: basic_note_type, name: "Downloaded at")
      template = AnkiRecord::CardTemplate.new(note_type: basic_note_type,
                                              name: "Template 1")
      template.question_format = "{{Front}}"
      template.answer_format = <<~TEMPLATE
        {{FrontSide}}

        <hr id=answer>

        {{Back}}
        <br>
        <br>
        <a href="{{URL}}">Source</a>
      TEMPLATE

      css = <<~CSS
          .card {
            font-family: arial;
            font-size: 20px;
            text-align: center;
            color: black;
        }
      CSS
      basic_note_type.css = css
      basic_note_type
    end

    def create_anki_basic_note(basic_note:, anki_basic_note_type:, deck:, timestamp:)
      anki_note = AnkiRecord::Note.new(note_type: anki_basic_note_type, deck:)
      anki_note.front = basic_note.anki_front
      anki_note.back = basic_note.anki_back
      anki_note.url = basic_note.url
      anki_note.downloaded_at = timestamp
      anki_note.guid = basic_note.anki_guid
      anki_note.save
    end

    def anki_books_cloze_note_type(anki21_database:)
      cloze_note_type = AnkiRecord::NoteType.new(anki21_database:,
                                                 name: "Anki Books Cloze")
      # See comment in anki_books_basic_note_type
      cloze_note_type.id = "1697018590595"
      cloze_note_type.cloze = true
      AnkiRecord::NoteField.new(note_type: cloze_note_type, name: "Text")
      AnkiRecord::NoteField.new(note_type: cloze_note_type, name: "Back Extra")
      AnkiRecord::NoteField.new(note_type: cloze_note_type, name: "URL")
      AnkiRecord::NoteField.new(note_type: cloze_note_type, name: "Downloaded at")
      template = AnkiRecord::CardTemplate.new(note_type: cloze_note_type,
                                              name: "Template 1")

      template.question_format = "{{cloze:Text}}"
      template.answer_format = <<~TEMPLATE
        {{cloze:Text}}<br>
        {{Back Extra}}
        <br>
        <a href="{{URL}}">Source</a>
      TEMPLATE

      css = <<~CSS
        .card {
            font-family: arial;
            font-size: 20px;
            text-align: center;
            color: black;
        }
        .cloze {
            font-weight: bold;
            color: blue;
        }
        .nightMode .cloze {
            color: lightblue;
        }
      CSS

      cloze_note_type.css = css
      cloze_note_type
    end

    def create_anki_cloze_note(cloze_note:, anki_cloze_note_type:, deck:, timestamp:)
      anki_note = AnkiRecord::Note.new(note_type: anki_cloze_note_type, deck:)
      anki_note.text = cloze_note.anki_text
      anki_note.back_extra = ""
      anki_note.url = cloze_note.url
      anki_note.downloaded_at = timestamp
      anki_note.guid = cloze_note.anki_guid
      anki_note.save
    end
  end
end
# rubocop:enable Metrics/MethodLength
