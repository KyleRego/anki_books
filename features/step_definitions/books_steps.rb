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

When "I visit the My Books page" do
  visit books_path
end
