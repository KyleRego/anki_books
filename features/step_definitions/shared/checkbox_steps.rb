# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

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
