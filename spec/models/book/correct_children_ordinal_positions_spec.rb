# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Book, "#correct_children_ordinal_positions?" do
  subject(:valid_child_ordinal_positions) do
    book.correct_children_ordinal_positions?
  end

  let(:book) { create(:book) }

  it "returns true when book has no articles" do
    expect(valid_child_ordinal_positions).to be true
  end

  context "when book has one article with ordinal position 0" do
    before { create(:article, book:, ordinal_position: 0) }

    it "returns true" do
      expect(valid_child_ordinal_positions).to be true
    end
  end

  context "when book has one article with ordinal position 1" do
    before { create(:article, book:, ordinal_position: 1) }

    it "returns false" do
      expect(valid_child_ordinal_positions).to be false
    end
  end

  context "when book has two articles with ordinal positions 0 and 2" do
    before do
      create(:article, book:, ordinal_position: 0)
      create(:article, book:, ordinal_position: 2)
    end

    it "returns false" do
      expect(valid_child_ordinal_positions).to be false
    end
  end
end
