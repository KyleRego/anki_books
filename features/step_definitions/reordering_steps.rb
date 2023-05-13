# frozen_string_literal: true

When "I drag the note at position {string} to the dropzone at position {string}" do |position1, position2|
  notes = page.all "[id^=#{BasicNotesHelper::TURBO_BASIC_NOTE_ID_PREFIX}]"
  dragged_note = notes[position1.to_i].find("[draggable=\"true\"]")
  target_dropzone = notes[position2.to_i].find(".note-droppable-area")
  dragged_note.drag_to(target_dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the front of the note at position {string} should be {string}" do |position, front|
  notes = page.all "[id^=#{BasicNotesHelper::TURBO_BASIC_NOTE_ID_PREFIX}]"
  note_at_specified_ordinal_position = notes[position.to_i].find("[draggable=\"true\"]")
  expect(note_at_specified_ordinal_position.text).to include front
end

Then "I should not see two adjacent New note links" do
  expect(page.text).not_to include "New note\nNew note"
end
