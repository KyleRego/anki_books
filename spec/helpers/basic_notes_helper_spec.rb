# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BasicNotesHelper" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "#turbo_id_for_basic_note" do
    it "returns a string with the note's id" do
      expect(helper.turbo_id_for_basic_note(basic_note)).to eq "turbo-basic-note-#{basic_note.id}"
    end
  end

  describe "#turbo_id_for_new_basic_note" do
    it "returns \"turbo-new-basic-note-\" when passed nil" do
      expect(helper.turbo_id_for_new_basic_note(sibling: nil)).to eq("turbo-new-basic-note-")
    end

    it "returns a string appended with the note argument's id when passed a sibling note" do
      expect(helper.turbo_id_for_new_basic_note(sibling: basic_note)).to eq("turbo-new-basic-note-#{basic_note.id}")
    end
  end
end
