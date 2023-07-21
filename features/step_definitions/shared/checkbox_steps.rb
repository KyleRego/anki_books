# frozen_string_literal: true

When "I check the checkbox labeled {string}" do |string|
  check(string)
end

When "I uncheck the checkbox labeled {string}" do |string|
  uncheck(string)
end

Then "the checkbox labeled {string} should be checked" do |string|
  expect(page).to have_field(string, checked: true)
end

Then "the checkbox labeled {string} should not be checked" do |string|
  expect(page).to have_field(string, checked: false)
end
