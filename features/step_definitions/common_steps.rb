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
