# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Note, "#new_next_sibling_note_turbo_id" do
  subject(:new_next_sibling_note_turbo_id) do
    note.new_next_sibling_note_turbo_id
  end

  let(:article) { create(:article) }

  context "when note is a basic note" do
    let(:note) { create(:basic_note, ordinal_position: 0, article:) }

    it "returns next-note-sibling-after-note-_string for the note" do
      expect(new_next_sibling_note_turbo_id).to eq "next-note-sibling-after-note-#{note.id}"
    end
  end

  context "when note is a cloze note" do
    let(:note) { create(:cloze_note, ordinal_position: 0, article:) }

    it "returns next-note-sibling-after-note-id_string for the note" do
      expect(new_next_sibling_note_turbo_id).to eq "next-note-sibling-after-note-#{note.id}"
    end
  end
end
