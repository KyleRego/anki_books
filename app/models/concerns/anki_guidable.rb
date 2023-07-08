# frozen_string_literal: true

# :nodoc:
module AnkiGuidable
  extend ActiveSupport::Concern

  def anki_globally_unique_id
    AnkiRecord::Helpers::AnkiGuidHelper.globally_unique_id
  end
end
