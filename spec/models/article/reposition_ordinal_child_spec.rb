# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#reposition_ordinal_child" do
  subject(:reposition_ordinal_child) do
    article.reposition_ordinal_child(child: note, new_ordinal_position:)
  end

  let(:book) { create(:book) }
  let(:article) { create(:article, book:) }

  context "when article has basic notes and cloze notes" do
    before do
      create(:basic_note, article:, ordinal_position: 0)
      create(:cloze_note, article:, ordinal_position: 1)
      create(:basic_note, article:, ordinal_position: 2)
      create(:cloze_note, article:, ordinal_position: 3)
    end

    context "when moving a basic note" do
      let(:note) { article.basic_notes.find_by(ordinal_position: 2) }
      let(:new_ordinal_position) { 1 }

      it "rearranges both basic notes and cloze notes to reposition the basic note" do
        expect(reposition_ordinal_child).to be true
        expect(note.reload.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when moving a cloze note" do
      let(:note) { article.cloze_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "rearranges both basic notes and cloze notes to reposition the cloze note" do
        expect(reposition_ordinal_child).to be true
        expect(note.reload.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end
  end

  context "when article has two basic notes" do
    before { create_list(:basic_note, 2, article:) }

    context "when the basic note at position 0 is moved to position 1" do
      let(:note) { article.basic_notes.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 1 }

      it "returns true and repositions the basic notes" do
        expect(reposition_ordinal_child).to be true
        expect(note.reload.ordinal_position).to eq 1
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the basic note at position 1 is moved to position 0" do
      let(:note) { article.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 0 }

      it "returns true and repositions the basic notes" do
        expect(reposition_ordinal_child).to be true
        expect(note.reload.ordinal_position).to eq 0
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new ordinal position is 2" do
      let(:note) { article.basic_notes.take }
      let(:new_ordinal_position) { 2 }

      it "returns false and does not reposition the basic notes" do
        expect(reposition_ordinal_child).to be false
        expect(article.basic_notes.find_by(ordinal_position: 2)).to be_nil
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the basic note has the desired new ordinal position already" do
      let(:note) { article.basic_notes.take }
      let(:new_ordinal_position) { note.ordinal_position }

      it "returns true and leaves the notes with the same positions" do
        expect(reposition_ordinal_child).to be true
        expect(note.reload.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the basic note does not belong to the article" do
      let(:other_article) { create(:article, book:) }
      let(:note) { create(:basic_note, article: other_article) }
      let(:new_ordinal_position) { 0 }

      it "raises an ArgumentError and does not change the basic note" do
        expect { reposition_ordinal_child }.to raise_error ArgumentError
        expect(note.reload.article).to eq other_article
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the basic note is not persisted yet" do
      let(:note) { build(:basic_note, article:) }
      let(:new_ordinal_position) { 0 }

      it "raises an ArgumentError and does not change the basic note" do
        expect { reposition_ordinal_child }.to raise_error ArgumentError
        expect(note.new_record?).to be true
        expect(article.correct_children_ordinal_positions?).to be true
      end
    end
  end
end
