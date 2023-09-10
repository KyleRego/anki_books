# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Given "the test user has a concept called {string}" do |concept_name|
  create(:concept, name: concept_name, user: @test_user)
end

Given "the book {string} has the {string} concept" do |book_title, concept_name|
  book = Book.find_by(title: book_title)
  concept = Concept.find_by(name: concept_name)
  book.concepts << concept
end
