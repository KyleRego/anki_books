# frozen_string_literal: true

require "rails_helper"

RSpec.describe BasicNote, "#valid?" do
  let(:article) { create(:article) }

  it "is valid with a front and back" do
    basic_note = build(:basic_note, article:)
    expect(basic_note).to be_valid
  end

  it "is valid with an anki_id that is 13 digits" do
    basic_note = build(:basic_note, article:, anki_id: "1122334456789")
    expect(basic_note).to be_valid
  end

  it "is not valid without a front" do
    basic_note = build(:basic_note, article:, front: nil)
    expect(basic_note).not_to be_valid
  end

  it "is not valid without a back" do
    basic_note = build(:basic_note, article:, back: nil)
    expect(basic_note).not_to be_valid
  end

  it "is not valid with an anki_id that is 9 digits" do
    basic_note = build(:basic_note, article:, anki_id: 123_456_789)
    expect(basic_note).not_to be_valid
  end

  it "is not valid with the same ordinal_position as a different note of the article" do
    existing_basic_note = create(:basic_note, article:)
    basic_note = build(:basic_note, article:, ordinal_position: existing_basic_note.ordinal_position)
    expect(basic_note).not_to be_valid
  end
end
