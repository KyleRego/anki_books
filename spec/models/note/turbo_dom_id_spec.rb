# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Note, "#turbo_dom_id" do
  subject(:turbo_dom_id) do
    note.turbo_dom_id
  end

  let(:article) { create(:article) }

  context "when note is a basic note" do
    let(:note) { create(:basic_note, ordinal_position: 0, article:) }

    it "returns note-id_string for the note" do
      expect(turbo_dom_id).to eq "note-#{note.id}"
    end
  end

  context "when note is a cloze note" do
    let(:note) { create(:cloze_note, ordinal_position: 0, article:) }

    it "returns note-id_string for the note" do
      expect(turbo_dom_id).to eq "note-#{note.id}"
    end
  end
end
