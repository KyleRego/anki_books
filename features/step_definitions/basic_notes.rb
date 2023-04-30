# frozen_string_literal: true

Then "I should see {string} in a basic note" do |text|
  page.assert_selector("[id^='basic-note-']", text:)
end

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
