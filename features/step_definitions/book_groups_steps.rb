# frozen_string_literal: true

Given "the test user has a book group called {string}" do |book_title|
  create(:book_group, title: book_title, users: [@test_user])
end

Given "the book {string} belongs to the {string} book group" do |book_title, book_group_title|
  book = Book.find_by(title: book_title)
  book_group = BookGroup.find_by(title: book_group_title)
  book_group.books << book
end
