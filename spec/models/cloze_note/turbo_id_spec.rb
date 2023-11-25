# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#turbo_id" do
  let(:article) { create(:article) }
  let(:cloze_note) { create(:cloze_note, article:) }

  it "returns a string with the note's id" do
    expect(cloze_note.turbo_id).to eq "cloze-note-#{cloze_note.id}"
  end
end
