# frozen_string_literal: true

RSpec.describe BasicNote, "#turbo_id" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  it "returns a string with the note's id" do
    expect(basic_note.turbo_id).to eq "turbo-basic-note-#{basic_note.id}"
  end
end
