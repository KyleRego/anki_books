# frozen_string_literal: true

# :nodoc:
class DeleteAnkiDeckJob < ApplicationJob
  queue_as :default

  def perform(anki_deck_file_path:)
    raise ArgumentError unless anki_deck_file_path.end_with?(".apkg")

    raise ArgumentError unless anki_deck_file_path.match?(CreateUserAnkiDeck.path_to_anki_package_regex)

    directory_to_delete = Pathname.new(anki_deck_file_path).dirname

    FileUtils.remove_entry_secure(directory_to_delete)
  end
end
