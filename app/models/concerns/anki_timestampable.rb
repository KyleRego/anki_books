# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# :nodoc:
module AnkiTimestampable
  extend ActiveSupport::Concern

  included do
    include AnkiRecord::Helpers::TimeHelper
  end

  def anki_milliseconds_timestamp
    milliseconds_since_epoch
  end
end
