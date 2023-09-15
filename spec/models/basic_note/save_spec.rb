# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#save" do
  let(:article) { create(:article) }

  it "saves with a anki_guid if anki_guid was nil" do
    basic_note = build(:basic_note, article:, anki_guid: nil)
    basic_note.save
    expect(basic_note.anki_guid).not_to be_nil
  end

  it "does not change anki_guid if anki_guid was not nil" do
    basic_note = create(:basic_note, article:)
    anki_guid = basic_note.anki_guid
    expect(basic_note.anki_guid).to eq anki_guid
  end
end
