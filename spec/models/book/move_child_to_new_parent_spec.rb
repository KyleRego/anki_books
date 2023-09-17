# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#move_child_to_new_parent" do
  subject(:move_child_to_new_parent) do
    book.move_child_to_new_parent(child: article, new_parent:, new_ordinal_position:)
  end

  context "when moving article from a book with one article to a book with no articles" do
    let(:book) { create(:book) }
    let(:article) { create(:article, book:) }
    let(:new_parent) { create(:book) }

    context "when the new position is 0" do
      let(:new_ordinal_position) { 0 }

      it "moves the article and returns true" do
        move_child_to_new_parent
        expect(article.reload.book).to eq new_parent
        expect(article.ordinal_position).to eq new_ordinal_position
        expect(book.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new position is -1" do
      let(:new_ordinal_position) { -1 }

      it "moves the article and puts it at the end of the book (ordinal position 0)" do
        move_child_to_new_parent
        expect(article.reload.book).to eq new_parent
        expect(article.ordinal_position).to eq(new_parent.articles_count - 1)
        expect(book.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new position is 1" do
      let(:new_ordinal_position) { 1 }

      it "moves the article and puts it at the end of the book (ordinal position 0)" do
        move_child_to_new_parent
        expect(article.reload.book).to eq new_parent
        expect(article.reload.ordinal_position).to eq 0
        expect(book.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the child article does not belong to the caller book" do
      let(:other_book) { create(:book) }
      let(:article) { create(:article, book: other_book) }
      let(:new_ordinal_position) { 1 }

      it "raises an ArgumentError and does not move the article" do
        expect { move_child_to_new_parent }.to raise_error ArgumentError
        expect(article.reload.book).to eq other_book
        expect(article.ordinal_position).to eq 0
      end
    end

    context "when the child article has not been persisted to the database" do
      let(:article) { build(:article, book:) }
      let(:new_ordinal_position) { 1 }

      it "raises an ArgumentError and does not move the article" do
        expect { move_child_to_new_parent }.to raise_error ArgumentError
        expect(article.new_record?).to be true
      end
    end
  end

  context "when moving article from a book with three articles to a book with three articles" do
    let(:book) { create(:book) }
    let(:article) { create(:article, book:) }
    let(:new_parent) { create(:book) }

    before do
      create_list(:article, 3, book:)
      create_list(:article, 3, book: new_parent)
    end

    context "when child is first article moved to be first article of new parent book" do
      let(:article) { book.articles.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 0 }

      it "moves the article and shifts other articles correctly" do
        move_child_to_new_parent
        expect(article.reload.book).to eq new_parent
        expect(article.reload.ordinal_position).to eq new_ordinal_position
        expect(book.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when child is second article moved to be third article of new parent book" do
      let(:article) { book.articles.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "moves the article and shifts other articles correctly" do
        move_child_to_new_parent
        expect(article.reload.book).to eq new_parent
        expect(article.reload.ordinal_position).to eq new_ordinal_position
        expect(book.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end
  end
end
