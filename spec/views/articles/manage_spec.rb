# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "articles/manage" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }

  before do
    assign(:article, article)
    assign(:book, book)
    assign(:user_other_books, Book.none)
    assign(:article_basic_notes, article.basic_notes.ordered)
    assign(:book_other_articles, Article.none)
  end

  it "includes a link to the articles of the article's book in the nav" do
    render template: "articles/manage", layout: "layouts/application"
    expect(rendered).to have_selector("a[href=\"#{book_path(book)}\"]")
  end

  it "does not show 'Transfer basic notes to a different article:' when the article has no basic notes" do
    render
    expect(rendered).not_to have_text("Transfer basic notes to a different article:")
  end

  context "when article has a basic note" do
    before { create(:basic_note, article:) }

    it "shows 'Transfer basic notes to a different article:'" do
      render
      expect(rendered).to have_text("Transfer basic notes to a different article:")
    end
  end
end
