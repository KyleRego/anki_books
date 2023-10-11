# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ClassLength

module AnkiRecord
  class NoteType # :nodoc:
    attr_accessor :id
  end
end

# :nodoc:
class CreateUserAnkiPackageJob < ApplicationJob
  include AnkiTimestampable

  def self.path_to_anki_package_regex
    %r{\A/tmp/\d{13}/anki_books_package_\d{13}.apkg\z}
  end

  # rubocop:disable Metrics/AbcSize
  def perform(user:)
    # TODO: Use a callback to update article cloze notes on saving article
    user.articles.each do |article|
      article.sync_to_cloze_notes(user:)
    end

    downloaded_at_timestamp = DateTime.current.strftime("%b %d %I:%M %z")

    AnkiRecord::AnkiPackage.create(name:, target_directory:) do |anki21_database|
      deck = AnkiRecord::Deck.new(anki21_database:, name: "Anki Books")
      deck.save

      basic_note_type = anki_books_basic_note_type(anki21_database:)
      basic_note_type.save

      user.basic_notes.each do |basic_note|
        anki_note = AnkiRecord::Note.new(note_type: basic_note_type, deck:)
        anki_note.front = basic_note.anki_front
        anki_note.back = basic_note.anki_back
        anki_note.url = basic_note.url
        anki_note.downloaded_at = downloaded_at_timestamp
        anki_note.guid = basic_note.anki_guid
        anki_note.save
      end

      cloze_note_type = anki_books_cloze_note_type(anki21_database:)
      cloze_note_type.save

      user.cloze_notes.each do |cloze_note|
        anki_note = AnkiRecord::Note.new(note_type: cloze_note_type, deck:)
        anki_note.text = cloze_note.anki_text
        anki_note.back_extra = ""
        anki_note.url = cloze_note.url
        anki_note.downloaded_at = downloaded_at_timestamp
        anki_note.guid = cloze_note.anki_guid
        anki_note.save
      end
    end
    created_anki_deck_path
  end
  # rubocop:enable Metrics/AbcSize

  private

  attr_reader :user

  def created_anki_deck_path
    "#{target_directory}/#{name}.apkg"
  end

  def name
    @name ||= "anki_books_package_#{timestamp}"
  end

  def target_directory
    tmp_directory = Dir.tmpdir
    @target_directory = "#{tmp_directory}/#{timestamp}"
    FileUtils.mkdir_p(@target_directory)
    @target_directory
  end

  def timestamp
    @timestamp ||= anki_milliseconds_timestamp
  end

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
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ClassLength
