# frozen_string_literal: true

##
# Methods related to the custom HTML Turbo Frame elements for basic notes.
module BasicNote::TurboFrameable
  TURBO_NEW_BASIC_NOTE_ID_PREFIX = "turbo-new-basic-note-"
  TURBO_BASIC_NOTE_ID_PREFIX = "turbo-basic-note-"

  def turbo_id
    "#{TURBO_BASIC_NOTE_ID_PREFIX}#{id}"
  end

  def new_note_sibling_turbo_id
    "#{TURBO_NEW_BASIC_NOTE_ID_PREFIX}#{id}"
  end
end
