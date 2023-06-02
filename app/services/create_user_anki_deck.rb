# frozen_string_literal: true

# :nodoc:
class CreateUserAnkiDeck
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def self.perform(user:)
    AnkiRecord::AnkiPackage.new(name:, target_directory:) do |collection|
      deck = collection.find_deck_by name: "Default"
      note_type = collection.find_note_type_by name: "Basic"

      user.notes.each do |basic_note|
        anki_note = AnkiRecord::Note.new(note_type:, deck:)
        anki_note.front = basic_note.front
        anki_note.back = basic_note.back
        anki_note.guid = basic_note.anki_guid
        anki_note.save
      end
    end
    created_anki_deck_path
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  class << self
    include AnkiTimestampable

    private

    def created_anki_deck_path
      "#{target_directory}/#{name}.apkg"
    end

    def name
      @name ||= "anki_books_package_#{anki_milliseconds_timestamp}"
    end

    def target_directory
      Dir.tmpdir
    end
  end
end
