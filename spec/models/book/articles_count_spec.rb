# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#articles_count" do
  it "returns 0 when the book has no articles" do
    book = create(:book)
    expect(book.articles_count).to eq 0
  end

  it "returns 1 when the book has one article" do
    book = create(:book)
    create(:article, book:)
    expect(book.articles_count).to eq 1
  end
end
