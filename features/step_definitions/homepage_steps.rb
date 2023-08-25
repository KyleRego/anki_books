# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

HOMEPAGE_BASIC_NOTE_FRONT = "front of homepage basic note"
HOMEPAGE_BASIC_NOTE_BACK = "back of homepage basic note"

When "the homepage belongs to the book {string}" do |book_title|
  book = Book.find_by(title: book_title)
  system_article = Article.find_by(system: true)
  system_article.update(book:)
end

When "the homepage has a basic note" do
  create(:basic_note, article: @system_article, front: HOMEPAGE_BASIC_NOTE_FRONT, back: HOMEPAGE_BASIC_NOTE_BACK)
end

Then "I should not see a link to the homepage article's book" do
  expect(page).not_to have_content(@system_book.title)
end

Then "I should see the homepage" do
  expect(page).to have_content("This is the system article to serve as the homepage.")
end
