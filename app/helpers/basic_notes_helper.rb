# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def turbo_name_for_basic_note(note)
    "basic-note-#{note.anki_id}"
  end
end
