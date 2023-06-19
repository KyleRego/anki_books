# frozen_string_literal: true

When "I drag the note at position {string} to the dropzone at position {string}" do |position1, position2|
  notes = page.all "[id^=#{BasicNote::TurboFrameable::TURBO_BASIC_NOTE_ID_PREFIX}]"
  dragged_note = notes[position1.to_i].find("[draggable=\"true\"]")
  target_dropzone = notes[position2.to_i].find(".note-droppable-area")
  dragged_note.drag_to(target_dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the front of the note at position {string} should be {string}" do |position, front|
  notes = page.all "[id^=#{BasicNote::TurboFrameable::TURBO_BASIC_NOTE_ID_PREFIX}]"
  note_at_specified_ordinal_position = notes[position.to_i].find("[draggable=\"true\"]")
  expect(note_at_specified_ordinal_position.text).to include front
end

Then "I should not see two adjacent New note links" do
  expect(page.text).not_to include "New note\nNew note"
end

When "I drag the article with title {string} to below the article with title {string}" do |string, string2|
  dragged_article = page.find("[draggable=\"true\"]", text: string)

  article_above_dropzone = page.find("[draggable=\"true\"]", text: string2)
  dropzone = article_above_dropzone
             .ancestor("div.reorderable-unit")
             .find("[data-reorder-articles--article-dropzone-target=\"dropzone\"]")
  dragged_article.drag_to(dropzone, delay: 0.5, html5: true)
  sleep 0.5
end

Then "the title of the article at position {int} should be {string}" do |int, string|
  all_articles = page.all("[draggable=\"true\"]")
  expect(all_articles[int].text).to eq string
end
