# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#valid_ordinal_position_for_new_note?" do
  context "when the article has 4 notes" do
    let(:article) { create(:article) }

    # rubocop:disable RSpec/MultipleExpectations
    # rubocop:disable RSpec/ExampleLength
    it "returns true for 0 through 4 and false for -1 and 5" do
      create_list(:basic_note, 4, article:)
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: -1)).to be false
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 0)).to be true
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 1)).to be true
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 2)).to be true
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 3)).to be true
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 4)).to be true
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 5)).to be false
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end

  context "when the article has 0 notes" do
    let(:article) { create(:article) }

    it "returns true for ordinal position 0" do
      expect(article.valid_ordinal_position_for_new_note?(note_ordinal_position: 0)).to be true
    end
  end
end
