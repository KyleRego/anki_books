# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

book = Book.create!(title: "System book")
Article.create!(title: "Homepage system article", system: true, book:)

user = User.create!(username: "test user", email: "test@example.com", password: "1234asdf!!!!")
user.books << book

5.times do |i|
  normal_article = book.articles.create!(title: "Normal article #{i}")
  10.times do |j|
    front = "front of article #{i} note #{j}"
    back = "back of article #{i} note #{j}"
    normal_article.basic_notes.create!(front:, back:, ordinal_position: j)
  end
end
