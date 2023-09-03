# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
class DeleteAnkiPackageJob < ApplicationJob
  queue_as :default

  def perform(anki_deck_file_path:)
    raise ArgumentError unless anki_deck_file_path.end_with?(".apkg")

    raise ArgumentError unless anki_deck_file_path.match?(CreateUserAnkiPackage.path_to_anki_package_regex)

    directory_to_delete = Pathname.new(anki_deck_file_path).dirname

    FileUtils.remove_entry_secure(directory_to_delete)
  end
end
