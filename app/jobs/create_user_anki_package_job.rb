# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength

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

    AnkiRecord::AnkiPackage.create(name:, target_directory:) do |anki21_database|
      deck = AnkiRecord::Deck.new(anki21_database:, name: "Anki Books")
      deck.save

      basic_note_type = anki21_database.find_note_type_by(name: "Basic")

      user.basic_notes.each do |basic_note|
        anki_note = AnkiRecord::Note.new(note_type: basic_note_type, deck:)
        anki_note.front = basic_note.anki_front
        anki_note.back = basic_note.anki_back
        anki_note.guid = basic_note.anki_guid
        anki_note.save
      end

      cloze_note_type = anki21_database.find_note_type_by(name: "Cloze")

      user.cloze_notes.each do |cloze_note|
        anki_note = AnkiRecord::Note.new(note_type: cloze_note_type, deck:)
        anki_note.text = cloze_note.sentence
        anki_note.back_extra = cloze_note.anki_back_extra
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
    Rails.logger.info "@target_directory for new Anki package is #{@target_directory}"
    FileUtils.mkdir_p(@target_directory)
    @target_directory
  end

  def timestamp
    @timestamp ||= anki_milliseconds_timestamp
  end
end
# rubocop:enable Metrics/MethodLength
