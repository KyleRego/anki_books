# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def first_basic_note_turbo_id
    BasicNote::TurboFrameable::TURBO_NEW_BASIC_NOTE_ID_PREFIX
  end
end
