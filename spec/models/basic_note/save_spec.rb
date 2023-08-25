# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#save" do
  let(:article) { create(:article) }

  it "gives the basic note an anki_id and anki_guid when saving a basic note with these nil" do
    basic_note = build(:basic_note, article:, anki_id: nil, anki_guid: nil)
    basic_note.save
    expect(basic_note.anki_id).not_to be_nil
    expect(basic_note.anki_guid).not_to be_nil
  end

  it "does not change the anki_id and anki_guid when saving a basic note with these" do
    basic_note = create(:basic_note, article:)
    anki_id = basic_note.anki_id
    anki_guid = basic_note.anki_guid
    expect(basic_note.anki_id).to eq anki_id
    expect(basic_note.anki_guid).to eq anki_guid
  end
end
# rubocop:enable RSpec/MultipleExpectations
