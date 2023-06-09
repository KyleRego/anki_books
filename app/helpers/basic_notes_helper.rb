# frozen_string_literal: true

# :nodoc:
module BasicNotesHelper
  def first_new_basic_note_turbo_id
    BasicNote::TurboFrameable::TURBO_FIRST_NEW_BASIC_NOTE_ID
  end

  def on_study_cards?
    request.path.end_with?("study_cards")
  end
end
