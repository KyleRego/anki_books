# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#valid?" do
  subject(:book) { build(:book, title:) }

  let(:title) { "Example title" }

  it { is_expected.to be_valid }

  context "when title is an empty string" do
    let(:title) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when title is nil" do
    let(:title) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when parent_book_id is the book's id" do
    before do
      book.save
      book.parent_book_id = book.id
    end

    it "is invalid" do
      expect(book).not_to be_valid
    end
  end

  context "when parent_book_id is to child book of this book" do
    before do
      child_book = create(:book, parent_book: book)
      book.parent_book_id = child_book.id
    end

    it "is invalid" do
      expect(book).not_to be_valid
    end
  end

  context "when parent_book_id is to a child of a child" do
    before do
      child_book = create(:book, parent_book: book)
      nested_child_book = create(:book, parent_book: child_book)
      book.parent_book_id = nested_child_book.id
    end

    it "is invalid" do
      pending "implementation"
      expect(book).not_to be_valid
    end
  end
end
