# frozen_string_literal: true

# :nodoc:
class CreateUserAnkiDeck
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.perform(user:, anki_deck_name:, target_directory:)
    AnkiRecord::AnkiPackage.new(name: anki_deck_name, target_directory:) do |collection|
      deck = collection.find_deck_by name: "Default"
      note_type = collection.find_note_type_by name: "Basic"

      user.books.each do |book|
        book.articles.each do |article|
          article.basic_notes.each do |basic_note|
            note = AnkiRecord::Note.new(note_type:, deck:)
            note.front = basic_note.front
            note.back = basic_note.back
            note.guid = basic_note.anki_guid
            note.save
          end
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
