# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Given "I am logged in as the user {string} with password: {string}" do |username, password|
  user = User.find_by(username:)
  visit login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: password
  click_button "Log in"
  sleep 0.5
end

Given "there is a user {string}, email {string}, and password {string}" do |string, string2, string3|
  User.create!(username: string, email: string2, password: string3)
end
