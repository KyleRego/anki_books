# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe OrdinalPositions::Validator::BookArticles, ".perform" do
  subject(:perform_ordinal_position_validation) do
    described_class.perform(parent:)
  end

  let!(:parent) { create(:book) }

  it "is valid when the book has no articles" do
    expect(perform_ordinal_position_validation).to be true
  end

  context "when the book has one article at position 0" do
    before { create(:article, book: parent) }

    it "is valid" do
      expect(perform_ordinal_position_validation).to be true
    end
  end

  context "when the book has one article at position 1" do
    before { create(:article, ordinal_position: 1, book: parent) }

    it "is invalid" do
      expect(perform_ordinal_position_validation).to be false
    end
  end

  context "when the book has one article at position -1" do
    before { create(:article, ordinal_position: -1, book: parent) }

    it "is invalid" do
      expect(perform_ordinal_position_validation).to be false
    end
  end

  context "when the book has 2 articles and an ordinal position missing between them" do
    before do
      create(:article, ordinal_position: 0, book: parent)
      create(:article, ordinal_position: 2, book: parent)
    end

    it "is invalid" do
      expect(perform_ordinal_position_validation).to be false
    end
  end
end
