# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  TURBO_BASIC_NOTE_ID_PREFIX = "turbo-basic-note-"

  def turbo_id_for_basic_note(note)
    "#{TURBO_BASIC_NOTE_ID_PREFIX}#{note.id}"
  end

  # TODO: Use Stimulus only for new note and remove this method.
  def turbo_id_for_new_basic_note
    "turbo-new-basic-note"
  end
end
