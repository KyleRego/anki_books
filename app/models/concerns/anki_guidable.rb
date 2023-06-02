# frozen_string_literal: true

# :nodoc:
module AnkiGuidable
  extend ActiveSupport::Concern

  included do
    include AnkiRecord::NoteGuidHelper
  end

  def anki_guid
    globally_unique_id
  end
end
