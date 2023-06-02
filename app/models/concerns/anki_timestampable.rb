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
