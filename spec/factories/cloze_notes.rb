# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

TEST_SENTENCE = "Cloze note test sentence."

FactoryBot.define do
  factory :cloze_note do
    sentence { TEST_SENTENCE }
  end
end
