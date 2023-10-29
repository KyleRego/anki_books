# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module AnkiPackages
  ##
  # Shared methods for create Anki package jobs
  # that are unrelated to Anki Record types
  module SharedAnkiPackageJobMethods
    def self.path_to_anki_package_regex
      %r{\A/tmp/\d{13}/anki_books_(article_)?package_\d{13}.apkg\z}
    end

    include AnkiTimestampable

    private

    def created_anki_deck_path
      "#{target_directory}/#{name}.apkg"
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
end
