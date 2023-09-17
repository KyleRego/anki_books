# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

##
# Module to contain the dependency on the AnkiRecord::Helpers::TimeHelper
# to a single place.
module AnkiTimestampable
  extend ActiveSupport::Concern

  included do
    include AnkiRecord::Helpers::TimeHelper

    def anki_milliseconds_timestamp
      milliseconds_since_epoch
    end
  end
end
