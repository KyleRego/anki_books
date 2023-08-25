# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

When "I click the {string} link" do |link|
  click_link link
  sleep 0.5
end

When "I click the last {string} link" do |link|
  all(:link, link).last.click
  sleep 0.5
end

When(/^I click the (\d+)(?:st|nd|rd|th)? link with text "(.*?)"$/) do |position, text|
  index = position.to_i - 1
  links = all("a", text:)
  link = links[index]
  link.click
end

Then "I should see a {string} link" do |text|
  expect(page).to have_link(text)
end

Then "I should not see a {string} link" do |text|
  expect(page).not_to have_link(text)
end

Then "I should see {int} links with the text {string}" do |number, text|
  links = all("a", text:)
  expect(links.count).to eq number
end
