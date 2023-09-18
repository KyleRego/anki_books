# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "books/manage" do
  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }

  before do
    assign(:book, book)
    assign(:articles, Article.none)
    assign(:book_current_domains, Domain.none)
    assign(:user_domains, Domain.none)
    assign(:book_current_concepts, Concept.none)
    assign(:user_concepts, Concept.none)
    assign(:user_other_books, create_list(:book, 1, users: [user]))
  end

  context "when the book has no articles" do
    it "does not show 'Reorder articles:'" do
      render
      expect(rendered).not_to have_text("Reorder articles")
    end

    it "does not show 'Transfer articles to a different book:'" do
      render
      expect(rendered).not_to have_text("Transfer articles to a different book:")
    end
  end

  context "when the book has only one article" do
    before do
      create(:article, book:)
      assign(:articles, book.articles)
    end

    it "does not show 'Reorder articles:'" do
      render
      expect(rendered).not_to have_text("Reorder articles")
    end
  end

  context "when the book has an article and the user has other books" do
    before do
      create(:article, book:)
      assign(:articles, book.articles)
      assign(:user_other_books, create_list(:book, 1, users: [user]))
    end

    it "shows 'Transfer articles to a different book:'" do
      render
      expect(rendered).to have_text("Transfer articles to a different book:")
    end
  end

  context "when the book has two articles" do
    before do
      create_list(:article, 2, book:)
      assign(:articles, book.articles)
    end

    it "does show 'Reorder articles:'" do
      render
      expect(rendered).to have_text("Reorder articles")
    end
  end
end
