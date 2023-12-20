# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

UPDATE_CHILD_BOOKS_SELECTOR = "#update-child-books-area"

Given "the user {string} has a book called {string}" do |username, book_title|
  user = User.find_by(username:)
  create(:book, title: book_title, users: [user])
end

Given "the book {string} has {int} numbered articles" do |book_title, int|
  book = Book.find_by(title: book_title)
  int.times do |i|
    title = "Article #{i}"
    create(:article, book:, title:)
  end
end

Given "the book {string} is a child of the book {string}" do |child_title, parent_title|
  child = Book.find_by(title: child_title)
  parent = Book.find_by(title: parent_title)
  child.update(parent_book_id: parent.id)
end

When "I visit the Books page" do
  visit books_path
end

Given "I scroll to the update child books area" do
  update_child_books_area = page.find(UPDATE_CHILD_BOOKS_SELECTOR)
  scroll_to update_child_books_area
end

Given "I check the child book checkbox labeled {string}" do |string|
  within(UPDATE_CHILD_BOOKS_SELECTOR) do
    check string
  end
end
