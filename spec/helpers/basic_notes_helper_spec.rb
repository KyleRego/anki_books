# frozen_string_literal: true

RSpec.describe "BasicNotesHelper" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  describe "#first_new_basic_note_turbo_id" do
    it "returns \"turbo-first-basic-note\"" do
      expect(helper.first_new_basic_note_turbo_id).to eq("turbo-first-basic-note")
    end
  end
end
