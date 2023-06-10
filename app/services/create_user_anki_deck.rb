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

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def perform
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
