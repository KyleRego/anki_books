# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#move_ordinal_children_to_new_parent" do
  subject(:move_ordinal_children_to_new_parent) do
    source_article.move_ordinal_children_to_new_parent(children:, new_parent:)
  end

  let(:book) { create(:book) }
  let(:source_article) { create(:article, book:) }
  let(:children) { source_article.basic_notes.limit(4) }
  let(:new_parent) { create(:article, book: source_article.book) }

  before { create_list(:basic_note, 8, article: source_article) }

  context "when article has both basic notes and cloze notes" do
    before do
      create_list(:cloze_note, 2, article: source_article)
      create_list(:basic_note, 2, article: source_article)
      create_list(:cloze_note, 3, article: source_article)
      create_list(:basic_note, 4, article: source_article)
      create_list(:cloze_note, 3, article: source_article)
      create_list(:basic_note, 7, article: source_article)
    end

    let(:children) do
      source_article.notes.where(ordinal_position: [2, 3, 4, 5, 6])
    end

    it "moves children to target article preserving order and shifts source article notes" do
      note_to_check1 = source_article.notes.find_by(ordinal_position: 2)
      note_to_check2 = source_article.notes.find_by(ordinal_position: 3)
      note_to_check3 = source_article.notes.find_by(ordinal_position: 4)
      note_to_check4 = source_article.notes.find_by(ordinal_position: 5)
      note_to_check5 = source_article.notes.find_by(ordinal_position: 6)

      move_ordinal_children_to_new_parent

      expect(source_article.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(note_to_check1.reload.article).to eq new_parent
      expect(note_to_check2.reload.ordinal_position).to eq 1
      expect(note_to_check3.reload.ordinal_position).to eq 2
      expect(note_to_check4.reload.ordinal_position).to eq 3
      expect(note_to_check5.reload.ordinal_position).to eq 4
    end
  end

  it "moves children to target article preserving order and shifts source article basic notes" do
    lowest_child = children.ordered.first
    highest_child = children.ordered.last

    move_ordinal_children_to_new_parent

    expect(book.correct_children_ordinal_positions?).to be true
    expect(new_parent.correct_children_ordinal_positions?).to be true
    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 3)).to eq highest_child
  end

  context "when children basic notes are all of the source article's basic notes" do
    let(:children) { source_article.basic_notes }

    it "moves the children to target article preserving their order" do
      lowest_child = children.ordered.first
      highest_child = children.ordered.last

      move_ordinal_children_to_new_parent

      expect(source_article.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 7)).to eq highest_child
    end
  end

  context "when target article already has basic notes" do
    before { create_list(:basic_note, 5, article: new_parent) }

    it "moves children to target article preserving their order" do
      lowest_child = children.ordered.first
      highest_child = children.ordered.last
      move_ordinal_children_to_new_parent

      expect(source_article.correct_children_ordinal_positions?).to be true
      expect(new_parent.correct_children_ordinal_positions?).to be true

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 5)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 8)).to eq highest_child
    end
  end

  context "when target article does not belong to the same book as source article" do
    let(:new_parent) { create(:article, book: create(:book)) }

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_exception ArgumentError
    end
  end

  context "when the children basic notes do not belong to source article" do
    let(:children) do
      article = create(:article)
      create_list(:basic_note, 4, article:)
      article.basic_notes
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end

  context "when some but not all children do not belong to source article" do
    let(:children) do
      other_article = create(:article)
      create_list(:basic_note, 4, article: source_article)
      create_list(:basic_note, 4, article: other_article)
      source_article.basic_notes + other_article.basic_notes
    end

    it "raises an ArgumentError" do
      expect { move_ordinal_children_to_new_parent }.to raise_error ArgumentError
    end
  end
end
