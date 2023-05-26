# frozen_string_literal: true

# :nodoc:
class CreateUserAnkiDeck
  # rubocop:disable Metrics/MethodLength
  def self.perform(user:, anki_deck_name:, target_directory:)
    AnkiRecord::AnkiPackage.new(name: anki_deck_name, target_directory:) do |collection|
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
  end
  # rubocop:enable Metrics/MethodLength
end
