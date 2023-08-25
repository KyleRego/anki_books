# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
module AnkiGuidable
  extend ActiveSupport::Concern

  def anki_globally_unique_id
    AnkiRecord::Helpers::AnkiGuidHelper.globally_unique_id
  end
end
