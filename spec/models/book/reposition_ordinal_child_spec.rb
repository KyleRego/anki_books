# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#reposition_ordinal_child" do
  subject(:reposition_ordinal_child) do
    book.reposition_ordinal_child(child: article, new_ordinal_position:)
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  context "when book has two articles" do
    before { create_list(:article, 2, book:) }

    context "when the article at position 0 is moved to position 1" do
      let(:article) { book.articles.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 1 }

      it "returns true and repositions the articles" do
        expect(reposition_ordinal_child).to be true
        expect(article.reload.ordinal_position).to eq 1
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the article at position 1 is moved to position 0" do
      let(:article) { book.articles.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 0 }

      it "returns true and repositions the articles" do
        expect(reposition_ordinal_child).to be true
        expect(article.reload.ordinal_position).to eq 0
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new ordinal position is 2" do
      let(:article) { book.articles.take }
      let(:new_ordinal_position) { 2 }

      it "returns false and does not reposition the articles" do
        expect(reposition_ordinal_child).to be false
        expect(book.articles.find_by(ordinal_position: 2)).to be_nil
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the article has the desired new ordinal position already" do
      let(:article) { book.articles.take }
      let(:new_ordinal_position) { article.ordinal_position }

      it "returns true and leaves the notes with the same positions" do
        expect(reposition_ordinal_child).to be true
        expect(article.reload.ordinal_position).to eq new_ordinal_position
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the article does not belong to the book" do
      let(:other_book) { create(:book) }
      let(:article) { create(:article, book: other_book) }
      let(:new_ordinal_position) { 0 }

      it "raises an ArgumentError and does not change the article" do
        expect { reposition_ordinal_child }.to raise_error ArgumentError
        expect(article.reload.book).to eq other_book
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the article is not persisted yet" do
      let(:article) { build(:article, book:) }
      let(:new_ordinal_position) { 0 }

      it "raises an ArgumentError and does not change the article" do
        expect { reposition_ordinal_child }.to raise_error ArgumentError
        expect(article.new_record?).to be true
        expect(book.correct_children_ordinal_positions?).to be true
      end
    end
  end
end
