# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

system_article_basic_notes = [
  ["What is the term for converting unsigned values into larger unsigned values (same number, representation with more bits)?",
   "Zero extension"],
  ["What is the class of Module in Ruby?", "Class"],
  ["What module in Ruby has the method which iterates through all of the objects known to the Ruby interpreter?", "ObjectSpace"],
  ["In 80x86 terminology, a word is how many bytes?", "2 bytes"],
  ["What is shared system isolation in service-oriented design?",
   "Services that have their own databases but are still running on shared systems"],
  ["What is the option to ls to sort the files in the output by file size?", "-S"],
  ["What is decimal 4 in binary using 3 bits?", "100"],
  ["What is the class of Object in Ruby?", "Class"],
  ["What is the normal merge strategy that merges two branches but can work when there is more than one possible merge base?", "Recursive"],
  ["After what packet in the TCP handshake can application data start being sent immediately?", "ACK"]
]
user = User.find_by(email: "test@example.com")
user ||= User.create!(username: "test user", email: "test@example.com", password: "1234asdf!!!!")

book_for_system_article = Book.create!(title: "Initial book with system article")
user.books << book_for_system_article

system_article = Article.create!(title: "Homepage system article", system: true, book: book_for_system_article, ordinal_position: 0)
# rubocop:disable Layout/LineLength
system_article.content = "<div class=\"trix-content\">\n  <h1>Hello world, this is the seeded system article. Login with the test user email: test@example.com and password: 1234asdf!!!!</h1>\n</div>\n"
# rubocop:enable Layout/LineLength
system_article.save!

system_article_basic_notes.each do |raw_basic_note|
  front = raw_basic_note.first
  back = raw_basic_note.last
  BasicNote.create!(article: system_article, front:, back:, ordinal_position: system_article.basic_notes_count)
end

book_for_testing_reordering = Book.create!(title: "Book for testing reordering")
user.books << book_for_testing_reordering

5.times do |i|
  article_for_testing_reordering = Article.create!(title: "Test reordering article #{i}", book: book_for_testing_reordering,
                                                   ordinal_position: i)
  10.times do |j|
    front = "Front of article #{i} note #{j}"
    back = "Back of article #{i} note #{j}"
    BasicNote.create!(article: article_for_testing_reordering, front:, back:, ordinal_position: j)
  end
end

book_with_a_lot_of_articles = Book.create!(title: "Book with a lot of articles")

5.times do |i|
  article_for_book_with_lots = Article.create!(title: "Test reordering article #{i}", book: book_with_a_lot_of_articles,
                                               ordinal_position: i)
  10.times do |j|
    front = "Front of article #{i} note #{j}"
    back = "Back of article #{i} note #{j}"
    BasicNote.create!(article: article_for_book_with_lots, front:, back:, ordinal_position: j)
  end
end
