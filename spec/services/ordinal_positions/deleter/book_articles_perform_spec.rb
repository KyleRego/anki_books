# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe OrdinalPositions::Deleter::BookArticles, ".perform" do
  subject(:perform_delete_child) do
    described_class.perform(child_to_delete:)
  end

  let(:book) { create(:book) }

  context "when the child to delete is the book's only article" do
    let(:child_to_delete) { book.articles.first }

    before { create(:article, book:) }

    it "deletes the article" do
      expect { perform_delete_child }.to change(Article, :count).by(-1)
    end
  end

  context "when the child to delete is the book's first article" do
    let(:child_to_delete) { book.articles.find_by(ordinal_position: 0) }

    before { create_list(:article, 5, book:) }

    it "deletes the article and shifts all of the other articles down" do
      perform_delete_child
      expect(book.articles.pluck(:ordinal_position)).to eq [0, 1, 2, 3]
    end
  end

  context "when the child to delete is a middle article of the book" do
    let(:child_to_delete) { book.articles.find_by(ordinal_position: 3) }

    before { create_list(:article, 5, book:) }

    it "deletes the article and shifts all of the other articles down" do
      perform_delete_child
      expect(book.articles.pluck(:ordinal_position)).to eq [0, 1, 2, 3]
    end
  end
end
