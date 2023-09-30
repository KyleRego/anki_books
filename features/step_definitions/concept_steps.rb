# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Given "the user {string} has a concept called {string}" do |username, concept_name|
  user = User.find_by(username:)
  create(:concept, name: concept_name, user:)
end
