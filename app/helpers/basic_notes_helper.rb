# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  TURBO_NEW_BASIC_NOTE_ID_PREFIX = "turbo-new-basic-note-"
  TURBO_BASIC_NOTE_ID_PREFIX = "turbo-basic-note-"

  def turbo_id_for_basic_note(note)
    "#{TURBO_BASIC_NOTE_ID_PREFIX}#{note.id}"
  end

  def turbo_id_for_new_basic_note(sibling:)
    return "#{TURBO_NEW_BASIC_NOTE_ID_PREFIX}#{sibling.id}" if sibling

    TURBO_NEW_BASIC_NOTE_ID_PREFIX
  end
end
