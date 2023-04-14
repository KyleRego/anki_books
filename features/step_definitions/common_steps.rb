# frozen_string_literal: true

Given "I visit the root path" do
  visit "/"
end

Then "I should see {string}" do |text|
  expect(page).to have_content(text)
end

Then "I should not see {string}" do |text|
  expect(page).not_to have_content(text)
end

When "I click the {string} link" do |link|
  click_link link
end
