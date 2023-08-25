# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#ordered_notes" do
  let(:book) { create(:book) }

  it "returns the notes ordered by ordinal position when the book has one article" do
    article = create(:article, book:)
    create_list(:basic_note, 5, article:)
    expect(book.ordered_notes).to eq article.ordered_notes
  end

  it "returns the notes ordered by ordinal positions of the articles when the book has many articles" do
    5.times do
      article = create(:article, book:)
      create(:basic_note, article:)
    end
    expect(book.ordered_notes.pluck(:article_id)).to eq book.ordered_articles.pluck(:id)
  end

  it "returns first the basic notes of the first article in order" do
    5.times do
      article = create(:article, book:)
      create_list(:basic_note, 3, article:)
    end
    expect(book.ordered_notes.first(3).pluck(:id)).to eq book.articles.find_by(ordinal_position: 0).ordered_notes.pluck(:id)
  end
end
