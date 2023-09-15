# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#valid?" do
  subject(:basic_note) { build(:cloze_note, article:, sentence:, concepts:) }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:sentence) { "The half life of caffeine is about 5 hours." }
  let(:concepts) { [create(:concept, name: "caffeine", user:)] }

  context "when anki_guid is the same as a different cloze note" do
    let(:other_cloze_note) { create(:cloze_note, article:) }

    it "returns false" do
      basic_note.anki_guid = other_cloze_note.anki_guid
      expect(basic_note).not_to be_valid
    end
  end
end
