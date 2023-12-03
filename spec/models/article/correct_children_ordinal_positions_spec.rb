# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#correct_children_ordinal_positions?" do
  subject(:valid_child_ordinal_positions) do
    article.correct_children_ordinal_positions?
  end

  let(:book) { create(:book) }
  let!(:article) { create(:article, book:) }

  it "returns true when article has no basic notes" do
    expect(valid_child_ordinal_positions).to be true
  end

  context "when article has one basic note with ordinal position 0" do
    before { create(:basic_note, article:, ordinal_position: 0) }

    it "returns true" do
      expect(valid_child_ordinal_positions).to be true
    end
  end

  context "when article has one basic note with ordinal position 1" do
    before { create(:basic_note, article:, ordinal_position: 1) }

    it "returns false" do
      expect(valid_child_ordinal_positions).to be false
    end
  end

  context "when article has two basic notes with ordinal positions 0 and 2" do
    before do
      create(:basic_note, article:, ordinal_position: 0)
      create(:basic_note, article:, ordinal_position: 2)
    end

    it "returns false" do
      expect(valid_child_ordinal_positions).to be false
    end
  end

  context "when article has three cloze notes at positions 0, 1, and 2" do
    before do
      create(:cloze_note, article:, ordinal_position: 0)
      create(:cloze_note, article:, ordinal_position: 1)
      create(:cloze_note, article:, ordinal_position: 2)
    end

    it "returns true" do
      expect(valid_child_ordinal_positions).to be true
    end
  end

  context "when article has alternating basic and cloze notes at positions 0-5" do
    before do
      create(:basic_note, article:, ordinal_position: 0)
      create(:cloze_note, article:, ordinal_position: 1)
      create(:basic_note, article:, ordinal_position: 2)
      create(:cloze_note, article:, ordinal_position: 3)
      create(:basic_note, article:, ordinal_position: 4)
    end

    it "returns true" do
      expect(valid_child_ordinal_positions).to be true
    end
  end

  context "when article has a cloze note at a too far position" do
    before do
      create(:basic_note, article:, ordinal_position: 0)
      create(:cloze_note, article:, ordinal_position: 1)
      create(:basic_note, article:, ordinal_position: 2)
      create(:cloze_note, article:, ordinal_position: 3)
      create(:basic_note, article:, ordinal_position: 4)

      create(:cloze_note, article:, ordinal_position: 7)
    end

    it "returns false" do
      expect(valid_child_ordinal_positions).to be false
    end
  end
end
