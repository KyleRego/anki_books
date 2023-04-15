# frozen_string_literal: true

Given "I visit the root path" do
  visit "/"
end

Then "I should see {string}" do |text|
  expect(page).to have_content(text)
end

And "I should see {string} in bold" do |text|
  expect(page).to have_css("strong", text:)
end

And "I should see {string} in italics" do |text|
  expect(page).to have_css("em", text:)
end

And "I should see {string} with a strikethrough" do |text|
  expect(page).to have_css("del", text:)
end

Then "I should not see {string}" do |text|
  expect(page).not_to have_content(text)
end

When "I click the {string} link" do |link|
  click_link link
end

When "I click the {string} button" do |button|
  click_button button
end
