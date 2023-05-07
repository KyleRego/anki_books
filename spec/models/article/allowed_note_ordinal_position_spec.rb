# frozen_string_literal: true

require "rails_helper"

RSpec.describe Article, "#allowed_note_ordinal_position?" do
  context "when the article has 4 notes" do
    let(:article) { create(:article) }

    # rubocop:disable RSpec/MultipleExpectations
    # rubocop:disable RSpec/ExampleLength
    it "returns true for 0 through 3 and false for -1 and 4" do
      create_list(:basic_note, 4, article:)
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: -1)).to be false
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: 0)).to be true
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: 1)).to be true
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: 2)).to be true
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: 3)).to be true
      expect(article.allowed_note_ordinal_position?(note_ordinal_position: 4)).to be false
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end
end
