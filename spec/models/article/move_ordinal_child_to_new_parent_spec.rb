# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#move_ordinal_child_to_new_parent" do
  subject(:move_ordinal_child_to_new_parent) do
    article.move_ordinal_child_to_new_parent(child: basic_note, new_parent:, new_ordinal_position:)
  end

  context "when moving basic note from a article with one basic note to a article with no basic notes" do
    let(:article) { create(:article) }
    let(:basic_note) { create(:basic_note, article:) }
    let(:new_parent) { create(:article) }

    context "when the new position is 0" do
      let(:new_ordinal_position) { 0 }

      it "moves the basic note and returns true" do
        move_ordinal_child_to_new_parent
        expect(basic_note.reload.article).to eq new_parent
        expect(basic_note.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new position is -1" do
      let(:new_ordinal_position) { -1 }

      it "moves the basic note and puts it at the end of the article (ordinal position 0)" do
        move_ordinal_child_to_new_parent
        expect(basic_note.reload.article).to eq new_parent
        expect(basic_note.ordinal_position).to eq(new_parent.basic_notes_count - 1)
        expect(article.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the new position is 1" do
      let(:new_ordinal_position) { 1 }

      it "moves the basic note and puts it at the end of the article (ordinal position 0)" do
        move_ordinal_child_to_new_parent
        expect(basic_note.reload.article).to eq new_parent
        expect(basic_note.reload.ordinal_position).to eq 0
        expect(article.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when the child basic note does not belong to the caller article" do
      let(:other_article) { create(:article) }
      let(:basic_note) { create(:basic_note, article: other_article) }
      let(:new_ordinal_position) { 1 }

      it "raises an ArgumentError and does not move the basic note" do
        expect { move_ordinal_child_to_new_parent }.to raise_error ArgumentError
        expect(basic_note.reload.article).to eq other_article
        expect(basic_note.ordinal_position).to eq 0
      end
    end

    context "when the child basic note has not been persisted to the database" do
      let(:basic_note) { build(:basic_note, article:) }
      let(:new_ordinal_position) { 1 }

      it "raises an ArgumentError and does not move the basic note" do
        expect { move_ordinal_child_to_new_parent }.to raise_error ArgumentError
        expect(basic_note.new_record?).to be true
      end
    end
  end

  context "when moving basic note from a article with three basic notes to a article with three basic notes" do
    let(:article) { create(:article) }
    let(:basic_note) { create(:basic_note, article:) }
    let(:new_parent) { create(:article) }

    before do
      create_list(:basic_note, 3, article:)
      create_list(:basic_note, 3, article: new_parent)
    end

    context "when child is first basic note moved to be first basic note of new parent article" do
      let(:basic_note) { article.basic_notes.find_by(ordinal_position: 0) }
      let(:new_ordinal_position) { 0 }

      it "moves the basic note and shifts other basic notes correctly" do
        move_ordinal_child_to_new_parent
        expect(basic_note.reload.article).to eq new_parent
        expect(basic_note.reload.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end

    context "when child is second basic note moved to be third basic note of new parent article" do
      let(:basic_note) { article.basic_notes.find_by(ordinal_position: 1) }
      let(:new_ordinal_position) { 2 }

      it "moves the basic note and shifts other basic notes correctly" do
        move_ordinal_child_to_new_parent
        expect(basic_note.reload.article).to eq new_parent
        expect(basic_note.reload.ordinal_position).to eq new_ordinal_position
        expect(article.correct_children_ordinal_positions?).to be true
        expect(new_parent.correct_children_ordinal_positions?).to be true
      end
    end
  end
end
