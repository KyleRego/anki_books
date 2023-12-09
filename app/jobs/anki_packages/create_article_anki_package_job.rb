# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module AnkiPackages
  ##
  # Job for creating the Anki package of a single article
  class CreateArticleAnkiPackageJob < ApplicationJob
    include AnkiNotes
    include SharedAnkiPackageJobMethods

    queue_as :default

    # rubocop:disable Metrics/AbcSize
    def perform(article:)
      downloaded_at_timestamp = DateTime.current.strftime("%b %d %I:%M %z")

      AnkiRecord::AnkiPackage.create(name:, target_directory:) do |anki21_database|
        deck = AnkiRecord::Deck.new(anki21_database:, name: "Anki Books")
        deck.save

        anki_basic_note_type = anki_books_basic_note_type(anki21_database:)
        anki_basic_note_type.save

        article.basic_notes.each do |basic_note|
          create_anki_basic_note(basic_note:, anki_basic_note_type:, anki_deck: deck, timestamp: downloaded_at_timestamp)
        end

        anki_cloze_note_type = anki_books_cloze_note_type(anki21_database:)
        anki_cloze_note_type.save

        article.cloze_notes.each do |cloze_note|
          create_anki_cloze_note(cloze_note:, anki_cloze_note_type:, anki_deck: deck, timestamp: downloaded_at_timestamp)
        end
      end
      created_anki_deck_path
    end
    # rubocop:enable Metrics/AbcSize

    private

    def name
      @name ||= "anki_books_article_package_#{timestamp}"
    end
  end
end
