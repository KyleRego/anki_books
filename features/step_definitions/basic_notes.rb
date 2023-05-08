# frozen_string_literal: true

When "I click {string} on the basic note" do |string|
  within("[id^='basic-note-']") do
    click_link string
  end
end

When "I fill in the basic note edit form with the following data:" do |table|
  within("[id^='basic-note-']") do
    table.hashes.each do |row|
      fill_in row["Field"], with: row["Value"]
    end
  end
end

Then "I should see {string} in a basic note" do |text|
  page.assert_selector("[id^='basic-note-']", text:)
end

Then "the article's basic note with front {string} should be at ordinal position {string}" do |front, position|
  expect(@test_article.notes.find_by(front:).ordinal_position).to eq position.to_i
end

Then(/I should see the (\d+)(?:st|nd|rd|th)? basic note of the article has front "(.*?)"$/) do |position, text|
  index = position.to_i - 1
  basic_notes = all("[id^='basic-note-']")
  expect(basic_notes[index].text).to include(text)
end
