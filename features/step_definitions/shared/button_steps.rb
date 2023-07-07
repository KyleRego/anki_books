# frozen_string_literal: true

When "I click the {string} button" do |button|
  click_button button
  sleep 0.5
end

When "I click the {string} button and accept the confirmation" do |string|
  accept_confirm do
    click_button(string)
  end
end

When "I click the {string} button and dismiss the confirmation" do |string|
  dismiss_confirm do
    click_button(string)
  end
end

Then "the {string} button should be disabled" do |button|
  expect(page).to have_button(button, disabled: true)
end
