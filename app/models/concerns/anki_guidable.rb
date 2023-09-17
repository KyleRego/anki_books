# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Module to contain the dependency on AnkiRecord::Helpers::AnkiGuidHelper
# to a single place.
module AnkiGuidable
  extend ActiveSupport::Concern

  included do
    before_validation :set_anki_guid_if_nil

    validates :anki_guid, presence: true, uniqueness: true

    def anki_globally_unique_id
      AnkiRecord::Helpers::AnkiGuidHelper.globally_unique_id
    end

    private

    def set_anki_guid_if_nil
      self.anki_guid ||= anki_globally_unique_id
    end
  end
end
