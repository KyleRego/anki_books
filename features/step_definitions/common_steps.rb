# frozen_string_literal: true

Then "I should see {string}" do |text|
  expect(page).to have_content(text)
end

Then "I should not see {string}" do |text|
  expect(page).not_to have_content(text)
end

When "I click the {string} link" do |link|
  click_link link
end
