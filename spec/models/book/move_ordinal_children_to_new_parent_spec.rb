# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe Book, "#move_ordinal_children_to_new_parent" do
  subject(:move_ordinal_children_to_new_parent) do
    book.move_ordinal_children_to_new_parent(children:, new_parent:)
  end

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:children) { book.articles.limit(4) }
  let(:new_parent) { create(:book, users: [user]) }

  before { create_list(:article, 8, book:) }

  context "when children articles are some of the source book's articles" do
    let(:children) do
      book.articles.where(ordinal_position: [0, 2, 5, 6])
    end

    it "moves the children to target book preserving their order and shifts other source book articles" do
      lowest_child = children.ordered.first
      highest_child = children.ordered.last
      move_ordinal_children_to_new_parent
      expect(book.reload.correct_children_ordinal_positions?).to be true
      expect(new_parent.reload.correct_children_ordinal_positions?).to be true
      expect(new_parent.articles.reload.find_by(ordinal_position: 0)).to eq lowest_child
      expect(new_parent.articles.reload.find_by(ordinal_position: 3)).to eq highest_child
    end
  end

  context "when children articles are all of the source book's articles" do
    let(:children) { book.articles }

    it "moves the children to target book preserving their order" do
      lowest_child = children.ordered.first
      highest_child = children.ordered.last
      move_ordinal_children_to_new_parent
      expect(book.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.articles.reload.find_by(ordinal_position: 0)).to eq lowest_child
      expect(new_parent.articles.reload.find_by(ordinal_position: 7)).to eq highest_child
    end
  end

  context "when the target book already has articles" do
    before { create_list(:article, 5, book: new_parent) }

    it "moves children to target book preserving their order" do
      lowest_child = children.ordered.first
      highest_child = children.ordered.last
      move_ordinal_children_to_new_parent
      expect(book.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.articles.reload.find_by(ordinal_position: 5)).to eq lowest_child
      expect(new_parent.articles.reload.find_by(ordinal_position: 8)).to eq highest_child
    end
  end

  context "when the children do not belong to source book" do
    let(:children) do
      book = create(:book)
      create_list(:article, 4, book:)
      book.articles
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end

  context "when some of the children to position do not belong to source book" do
    let(:children) do
      book = create(:book)
      other_book = create(:book)
      create_list(:article, 4, book:)
      create_list(:article, 4, book: other_book)
      book.articles + other_book.articles
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end
end
# rubocop:enable RSpec/ExampleLength
