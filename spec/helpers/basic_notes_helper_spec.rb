# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotesHelper" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "#turbo_name_for_basic_note" do
    it "returns a string with the note's anki_id" do
      expect(helper.turbo_name_for_basic_note(basic_note)).to eq "basic-note-#{basic_note.id}"
    end
  end
end
