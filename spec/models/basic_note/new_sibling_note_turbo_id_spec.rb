# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#new_sibling_note_turbo_id" do
  let(:article) { create(:article) }
  let(:basic_note) { create(:basic_note, article:) }

  it "returns a string appended with the note argument's id when passed a sibling note" do
    expect(basic_note.new_sibling_note_turbo_id).to eq("turbo-new-basic-note-#{basic_note.id}")
  end
end
