# frozen_string_literal: true

When "I visit the root path" do
  visit "/"
end

When "I refresh the page" do
  visit current_path
end

When "I click the {string} link" do |link|
  click_link link
  sleep 0.5
end

When "I click the {string} button" do |button|
  click_button button
  sleep 0.5
end

When "I fill in the {string} field with {string}" do |field, value|
  fill_in field, with: value
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

Then "I should see {string}" do |text|
  expect(page).to have_content(text)
end

Then "I should see a {string} placeholder" do |placeholder|
  expect(page).to have_selector("input[placeholder='#{placeholder}']")
end

Then "I should see the text {string} linking to {string}" do |text, url|
  expect(page).to have_link(text, href: url)
end

Then "I should see the text {string} but it should not be a link" do |text|
  expect(page).to have_content(text)
  expect(page).to_not have_link(text)
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

Then "the {string} button should be disabled" do |button|
  expect(page).to have_button(button, disabled: true)
end

Then "I should see an unordered list with the list item {string}" do |list_item|
  expect(page).to have_css("ul li", text: list_item)
end

Then "I should see an ordered list with the list item {string}" do |list_item|
  expect(page).to have_css("ol li", text: list_item)
end

# rubocop:disable Layout/LineLength
Then "I should see a nested list element with text {string} under the list element with text {string}" do |nested_text, parent_text|
  parent_element = find("li", text: parent_text)
  expect(parent_element).to have_css("li", text: nested_text)
end
# rubocop:enable Layout/LineLength

Then "I should not see the image {string} on the page" do |string|
  expect(page).to_not have_css("img[src$='#{string}']")
end

Then "I should see the textarea placeholder {string}" do |string|
  expect(page).to have_css("textarea[placeholder='#{string}']")
end
