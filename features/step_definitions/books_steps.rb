# frozen_string_literal: true

Given "I have a book with the title {string}" do |string|
  book = Book.create!(title: string)
  @test_user.books << book
end

Given "I have a book with the title {string} and {int} numbered articles" do |string, int|
  book = Book.create!(title: string)
  int.times do |i|
    title = "Article #{i}"
    create(:article, book:, title:)
  end
  @test_user.books << book
end
