# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe Book, "#move_ordinal_children_to_new_parent" do
  subject(:move_ordinal_children_to_new_parent) do
    article.move_ordinal_children_to_new_parent(children:, new_parent:)
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }
  let(:children) { article.basic_notes.limit(4) }
  let(:new_parent) { create(:article, book: article.book) }

  before { create_list(:basic_note, 8, article:) }

  it "moves children to new parent preserving order and correctly shifts the other basic notes" do
    lowest_child = children.order(:ordinal_position).first
    highest_child = children.order(:ordinal_position).last
    move_ordinal_children_to_new_parent
    expect(book.correct_children_ordinal_positions?).to be true
    expect(new_parent.correct_children_ordinal_positions?).to be true
    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 3)).to eq highest_child
  end

  context "when the children to position are all of the old article's basic notes" do
    let(:children) { article.basic_notes }

    it "moves the children to position to the new parent preserving their order" do
      lowest_child = children.order(:ordinal_position).first
      highest_child = children.order(:ordinal_position).last
      move_ordinal_children_to_new_parent
      expect(book.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 7)).to eq highest_child
    end
  end

  context "when the new parent already had basic notes" do
    before { create_list(:basic_note, 5, article: new_parent) }

    it "moves the children to position to the new parent preserving their order" do
      lowest_child = children.order(:ordinal_position).first
      highest_child = children.order(:ordinal_position).last
      move_ordinal_children_to_new_parent
      expect(book.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 5)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 8)).to eq highest_child
    end
  end

  context "when the article being transferred to does not belong to the same book" do
    let(:new_parent) { create(:article) }

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_exception ArgumentError
    end
  end

  context "when the children to position do not belong to article" do
    let(:children) do
      article = create(:article)
      create_list(:basic_note, 4, article:)
      article.basic_notes
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end

  context "when some of the children to position do not belong to article" do
    let(:children) do
      article = create(:article)
      other_article = create(:article)
      create_list(:basic_note, 4, article:)
      create_list(:basic_note, 4, article: other_article)
      article.basic_notes + other_article.basic_notes
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end

  context "when new parent article does not belong to same book as article" do
    let(:new_parent) { create(:article, book: create(:book)) }

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end
end
# rubocop:enable RSpec/ExampleLength
