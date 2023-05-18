# frozen_string_literal: true

Given "I have a book with the title {string}" do |string|
  book = Book.create!(title: string)
  @test_user.books << book
end
