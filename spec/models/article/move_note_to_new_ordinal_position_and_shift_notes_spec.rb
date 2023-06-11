# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/MultipleExpectations
RSpec.describe Article, "#move_note_to_new_ordinal_position_and_shift_notes" do
  let(:article) { create(:article) }
  let!(:note_a) { create(:basic_note, article:) }
  let!(:note_b) { create(:basic_note, article:) }
  let!(:note_c) { create(:basic_note, article:) }
  let!(:note_d) { create(:basic_note, article:) }
  let!(:note_e) { create(:basic_note, article:) }

  it "switches the position of two notes that are adjacent" do
    article.move_note_to_new_ordinal_position_and_shift_notes(note: note_a, new_ordinal_position: 1)
    expect(note_a.reload.ordinal_position).to eq 1
    expect(note_b.reload.ordinal_position).to eq 0
  end

  it "switches the position of two notes that are adjacent in the other direction" do
    article.move_note_to_new_ordinal_position_and_shift_notes(note: note_b, new_ordinal_position: 0)
    expect(note_a.reload.ordinal_position).to eq 1
    expect(note_b.reload.ordinal_position).to eq 0
  end

  it "shifts two notes to a lower ordinal position" do
    article.move_note_to_new_ordinal_position_and_shift_notes(note: note_a, new_ordinal_position: 2)
    expect(note_a.reload.ordinal_position).to eq 2
    expect(note_b.reload.ordinal_position).to eq 0
    expect(note_c.reload.ordinal_position).to eq 1
  end

  it "shifts three notes to a higher ordinal position" do
    article.move_note_to_new_ordinal_position_and_shift_notes(note: note_d, new_ordinal_position: 0)
    expect(note_a.reload.ordinal_position).to eq 1
    expect(note_b.reload.ordinal_position).to eq 2
    expect(note_c.reload.ordinal_position).to eq 3
    expect(note_d.reload.ordinal_position).to eq 0
  end

  it "does not affect the ordinal positions of notes outside the interval of change" do
    article.move_note_to_new_ordinal_position_and_shift_notes(note: note_b, new_ordinal_position: 3)
    expect(note_a.reload.ordinal_position).to eq 0
    expect(note_e.reload.ordinal_position).to eq 4
  end
end
# rubocop:enable RSpec/MultipleExpectations
