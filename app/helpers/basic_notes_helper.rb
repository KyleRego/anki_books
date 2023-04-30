# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def turbo_name_for_basic_note(note)
    "basic-note-#{note.anki_id}"
  end

  def turbo_frame_for_new_basic_note
    "new_basic_note"
  end
end
