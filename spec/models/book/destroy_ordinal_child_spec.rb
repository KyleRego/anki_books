# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#destroy_ordinal_child" do
  subject(:destroy_ordinal_child) do
    book.destroy_ordinal_child(child: article)
  end

  let(:book) { create(:book) }

  context "when the child article to delete does not belong to the book" do
    let(:other_book) { create(:book) }
    let!(:article) { create(:article, book: other_book) }

    it "raises an ArgumentError and does not delete the article" do
      expect { destroy_ordinal_child }.to raise_error ArgumentError
      expect { article.reload }.not_to raise_error
    end
  end

  context "when the child to delete is the book's only article" do
    let(:article) { book.articles.first }

    before { create(:article, book:) }

    it "deletes the article" do
      expect { destroy_ordinal_child }.to change(Article, :count).by(-1)
    end
  end

  context "when the child to delete is the book's first article" do
    let(:article) { book.articles.find_by(ordinal_position: 0) }

    before { create_list(:article, 5, book:) }

    it "deletes the article and shifts all of the other articles down" do
      expect { destroy_ordinal_child }.to change(Article, :count).by(-1)
      expect(book.correct_children_ordinal_positions?).to be true
    end
  end

  context "when the child to delete is a middle article of the book" do
    let(:article) { book.articles.find_by(ordinal_position: 3) }

    before { create_list(:article, 5, book:) }

    it "deletes the article and shifts all of the other articles down" do
      expect { destroy_ordinal_child }.to change(Article, :count).by(-1)
      expect(book.correct_children_ordinal_positions?).to be true
    end
  end
end
