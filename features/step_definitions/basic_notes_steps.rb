# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

def reorderable_basic_note_unit_selector
  ".reorderable-basic-note-unit"
end

When "I click {string} on the basic note" do |string|
  within(reorderable_basic_note_unit_selector) do
    click_link string
  end
end

When "I fill in the basic note edit form with the following data:" do |table|
  within(reorderable_basic_note_unit_selector) do
    table.hashes.each do |row|
      fill_in row["Field"], with: row["Value"]
    end
  end
end

When "I fill in the study cards basic note edit form with the following data:" do |table|
  table.hashes.each do |row|
    fill_in row["Field"], with: row["Value"]
  end
end

Then "I should see {string} in a basic note" do |text|
  page.assert_selector(reorderable_basic_note_unit_selector, text:)
end

Then "the article's basic note with front {string} should be at ordinal position {string}" do |front, position|
  expect(@current_article.basic_notes.find_by(front:).ordinal_position).to eq position.to_i
end

Then(/I should see the (\d+)(?:st|nd|rd|th)? basic note of the article has front "(.*?)"$/) do |position, text|
  index = position.to_i - 1
  basic_notes = all(reorderable_basic_note_unit_selector)
  expect(basic_notes[index].text).to include(text)
end

When "I drag the note at position {string} to the dropzone at position {string}" do |position1, position2|
  notes = page.all reorderable_basic_note_unit_selector
  dragged_note = notes[position1.to_i].find("[draggable=\"true\"]")
  # There are two dropzones in the reorderable unit, so one is chosen randomly, as either works.
  dropzones = notes[position2.to_i].all(".note-droppable-area")
  target_dropzone = dropzones[rand(dropzones.length)]
  dragged_note.drag_to(target_dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the front of the note at position {string} should be {string}" do |position, front|
  notes = page.all reorderable_basic_note_unit_selector
  note_at_specified_ordinal_position = notes[position.to_i].find("[draggable=\"true\"]")
  expect(note_at_specified_ordinal_position.text).to include front
end
