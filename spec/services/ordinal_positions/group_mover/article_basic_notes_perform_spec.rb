# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe OrdinalPositions::GroupMover::ArticleBasicNotes, ".perform" do
  subject(:perform_move_group_to_new_parent) do
    described_class.perform(new_parent:, old_parent:, children_to_position:)
  end

  let(:old_parent) { create(:article) }
  let(:children_to_position) { old_parent.basic_notes.limit(4) }
  let(:new_parent) { create(:article, book: old_parent.book) }

  before { create_list(:basic_note, 8, article: old_parent) }

  it "moves the children to position to the new parent preserving their order and adjusts the old parent children" do
    lowest_child = children_to_position.order(:ordinal_position).first
    highest_child = children_to_position.order(:ordinal_position).last
    expect(perform_move_group_to_new_parent).to be true
    expect(old_parent.basic_notes.order(:ordinal_position).pluck(:ordinal_position)).to eq [0, 1, 2, 3]
    expect(new_parent.basic_notes.order(:ordinal_position).pluck(:ordinal_position)).to eq [0, 1, 2, 3]

    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
    expect(new_parent.basic_notes.reload.find_by(ordinal_position: 3)).to eq highest_child
  end

  context "when the children to position are all of the old article's basic notes" do
    let(:children_to_position) { old_parent.basic_notes }

    it "moves the children to position to the new parent preserving their order and adjusts the old parent children" do
      lowest_child = children_to_position.order(:ordinal_position).first
      highest_child = children_to_position.order(:ordinal_position).last
      expect(perform_move_group_to_new_parent).to be true
      expect(old_parent.basic_notes.pluck(:ordinal_position)).to eq []
      expect(new_parent.basic_notes.order(:ordinal_position).pluck(:ordinal_position)).to eq [0, 1, 2, 3, 4, 5, 6, 7]

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 0)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 7)).to eq highest_child
    end
  end

  context "when the new parent already had basic notes" do
    before { create_list(:basic_note, 5, article: new_parent) }

    it "moves the children to position to the new parent preserving their order and adjusts the old parent children" do
      lowest_child = children_to_position.order(:ordinal_position).first
      highest_child = children_to_position.order(:ordinal_position).last
      expect(perform_move_group_to_new_parent).to be true
      expect(old_parent.basic_notes.order(:ordinal_position).pluck(:ordinal_position)).to eq [0, 1, 2, 3]
      expect(new_parent.basic_notes.order(:ordinal_position).pluck(:ordinal_position)).to eq [0, 1, 2, 3, 4, 5, 6, 7, 8]

      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 5)).to eq lowest_child
      expect(new_parent.basic_notes.reload.find_by(ordinal_position: 8)).to eq highest_child
    end
  end

  context "when the article being transferred to does not belong to the same book" do
    let(:new_parent) { create(:article) }

    it "throws an error" do
      expect { perform_move_group_to_new_parent }.to raise_exception ArgumentError
    end
  end

  context "when the children to position do not belong to the old parent" do
    let(:children_to_position) do
      article = create(:article)
      create_list(:basic_note, 4, article:)
      article.basic_notes
    end

    it "throws an error" do
      expect { perform_move_group_to_new_parent }.to raise_exception "All children to position must belong to old parent"
    end
  end
end
# rubocop:enable RSpec/ExampleLength
