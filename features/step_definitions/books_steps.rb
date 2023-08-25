# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Given "the test user has a book called {string}" do |book_title|
  create(:book, title: book_title, users: [@test_user])
end

Given "the book {string} has {int} numbered articles" do |book_title, int|
  book = Book.find_by(title: book_title)
  int.times do |i|
    title = "Article #{i}"
    create(:article, book:, title:)
  end
end

When "I visit the Books page" do
  visit books_path
end
