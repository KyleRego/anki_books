# frozen_string_literal: true

Then "I should see {string} in a basic note" do |text|
  page.assert_selector("[id^='basic-note-']", text:)
end
