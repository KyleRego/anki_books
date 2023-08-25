# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

def turbo_basic_note_id_selector
  "[id^=#{BasicNote::TurboFrameable::TURBO_BASIC_NOTE_ID_PREFIX}]"
end

When "I click {string} on the basic note" do |string|
  within(turbo_basic_note_id_selector) do
    click_link string
  end
end

When "I fill in the basic note edit form with the following data:" do |table|
  within(turbo_basic_note_id_selector) do
    table.hashes.each do |row|
      fill_in row["Field"], with: row["Value"]
    end
  end
end

Then "I should see {string} in a basic note" do |text|
  page.assert_selector(turbo_basic_note_id_selector, text:)
end

Then "the article's basic note with front {string} should be at ordinal position {string}" do |front, position|
  expect(@current_article.basic_notes.find_by(front:).ordinal_position).to eq position.to_i
end

Then(/I should see the (\d+)(?:st|nd|rd|th)? basic note of the article has front "(.*?)"$/) do |position, text|
  index = position.to_i - 1
  basic_notes = all(turbo_basic_note_id_selector)
  expect(basic_notes[index].text).to include(text)
end

When "I drag the note at position {string} to the dropzone at position {string}" do |position1, position2|
  notes = page.all turbo_basic_note_id_selector
  dragged_note = notes[position1.to_i].find("[draggable=\"true\"]")
  target_dropzone = notes[position2.to_i].find(".note-droppable-area")
  dragged_note.drag_to(target_dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the front of the note at position {string} should be {string}" do |position, front|
  notes = page.all turbo_basic_note_id_selector
  note_at_specified_ordinal_position = notes[position.to_i].find("[draggable=\"true\"]")
  expect(note_at_specified_ordinal_position.text).to include front
end
