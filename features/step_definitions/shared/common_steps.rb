# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# TODO: Split this into more organized shared step definitions

When "I visit the root path" do
  visit "/"
end

When "I refresh the page" do
  visit current_path
  sleep 1 if @test_article&.basic_notes&.any?
end

When "I fill in the {string} field with {string}" do |field, value|
  fill_in field, with: value
end

When "I choose {string} from the {string} select" do |option, name|
  page.select(option, from: name)
end

When "I click on the image {string} on the page" do |string|
  find("img[src$='#{string}']").click
end

When "I click on the span with text {string}" do |string|
  find("span", text: string).click
end

When "I type {string} on the focused element" do |keys|
  page.driver.browser.switch_to.active_element.send_keys(keys)
end

When "I press the key {string}" do |key|
  find("body").send_keys([key])
end

When "I use the ctrl + {string} keyboard shortcut" do |string|
  page.send_keys([:control, string])
end

Then "I should be on the root path" do
  expect(page).to have_current_path "/"
end

Then "I should see {string}" do |text|
  expect(page).to have_content(text)
end

Then "I should see {string} {int} times" do |text, count|
  expect(page).to have_content(text, count:)
end

Then "I should see an input with value {string}" do |string|
  expect(page).to have_selector("input[type='submit'][value='#{string}']")
end

Then "I should not see an input with value {string}" do |string|
  expect(page).not_to have_selector("input[type='submit'][value='#{string}']")
end

Then "I should see a {string} placeholder" do |placeholder|
  expect(page).to have_selector("input[placeholder='#{placeholder}']")
end

Then "I should see the text {string} linking to {string}" do |text, url|
  expect(page).to have_link(text, href: url)
end

Then "I should see {string} in bold" do |text|
  expect(page).to have_css("strong", text:)
end

Then "I should see {string} in italics" do |text|
  expect(page).to have_css("em", text:)
end

Then "I should see {string} with a strikethrough" do |text|
  expect(page).to have_css("del", text:)
end

Then "I should see {string} as a quote" do |text|
  expect(page).to have_css("blockquote", text:)
end

Then "I should see {string} but not as a quote" do |text|
  expect(page).to have_content(text)
  expect(page).to_not have_css("blockquote", text:)
end

Then "I should see a {string} heading with the text {string}" do |heading_element, text|
  expect(page).to have_css(heading_element, text:)
end

Then "I should not see {string}" do |text|
  expect(page).not_to have_content(text)
end

Then "I should see an unordered list with the list item {string}" do |list_item|
  expect(page).to have_css("ul li", text: list_item)
end

Then "I should see an ordered list with the list item {string}" do |list_item|
  expect(page).to have_css("ol li", text: list_item)
end

Then "I should see a nested list element with text {string} under the list element with text {string}" do |nested_text, parent_text|
  parent_element = find("li", text: parent_text)
  expect(parent_element).to have_css("li", text: nested_text)
end
Then "I should not see the image {string} on the page" do |string|
  expect(page).to_not have_css("img[src$='#{string}']")
end

Then "I should see the textarea placeholder {string}" do |string|
  expect(page).to have_css("textarea[placeholder='#{string}']")
end
