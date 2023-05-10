# frozen_string_literal: true

When "I drag the note at the ordinal position {string} to ordinal position {string}" do |string, string2|
  notes = page.all "[id^=#{BasicNotesHelper::TURBO_BASIC_NOTE_ID_PREFIX}]"
  dragged_note = notes[string.to_i].find("[draggable=\"true\"]")
  target_dropzone = notes[string2.to_i].find(".note-droppable-area")
  dragged_note.drag_to target_dropzone
end

Then "I should see the note with front {string} at ordinal position {string}" do |string, string2|
  notes = page.all "[id^=#{BasicNotesHelper::TURBO_BASIC_NOTE_ID_PREFIX}]"
  note_at_specified_ordinal_position = notes[string2.to_i].find("[draggable=\"true\"]")
  # There is an issue with the Capybara #drag_to method that seems to be upstream
  # in Selenium or possibly the drivers used by Selenium. A workaround may be possible
  # and there may be a specific driver not affected by the issue but not sure yet.
  pending
  expect(note_at_specified_ordinal_position.text).to include string
end
