# frozen_string_literal: true

# :nodoc:
class DeleteAnkiDeckJob < ApplicationJob
  queue_as :default

  def perform(anki_deck_file_path:)
    return unless anki_deck_file_path.end_with?(".apkg")

    FileUtils.rm_f(anki_deck_file_path)
  end
end
