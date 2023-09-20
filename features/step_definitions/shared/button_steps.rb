# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

When "I click the {string} button" do |string|
  click_button string
  sleep 0.5
end

When "I click the {string} button and accept the confirmation" do |string|
  accept_confirm do
    click_button(string)
  end
end

When(/^I click the (\d+)(?:st|nd|rd|th)? button with text "(.*?)" and accept the confirmation$/) do |position, text|
  index = position.to_i - 1
  buttons = all("button", text:)
  button = buttons[index]
  accept_confirm do
    button.click
  end
end

When "I click the {string} button and dismiss the confirmation" do |string|
  dismiss_confirm do
    click_button(string)
  end
end

Then "the {string} button should be disabled" do |string|
  expect(page).to have_button(string, disabled: true)
end
