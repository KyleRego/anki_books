# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class CreateUserAnkiDeck
  def self.path_to_anki_package_regex
    %r{\A/tmp/\d{13}/anki_books_package_\d{13}.apkg\z}
  end

  def self.perform(user:)
    new(user:).perform
  end

  include AnkiTimestampable

  attr_reader :user

  def initialize(user:)
    @user = user
  end

  # rubocop:disable Metrics/AbcSize
  def perform
    AnkiRecord::AnkiPackage.create(name:, target_directory:) do |anki21_database|
      deck = AnkiRecord::Deck.new(anki21_database:, name: "Anki Books")
      deck.save

      note_type = anki21_database.find_note_type_by name: "Basic"

      user.notes.each do |basic_note|
        anki_note = AnkiRecord::Note.new(note_type:, deck:)
        anki_note.front = basic_note.anki_front
        anki_note.back = basic_note.anki_back
        anki_note.guid = basic_note.anki_guid
        anki_note.save
      end
    end
    created_anki_deck_path
  end
  # rubocop:enable Metrics/AbcSize

  private

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
end
