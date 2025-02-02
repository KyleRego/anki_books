# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe ClozeNote, "#valid?" do
  subject(:cloze_note) { build(:cloze_note, article:, cloze_text:, concepts:) }

  let(:user) { create(:user) }
  let(:book) { create(:book, users: [user]) }
  let(:article) { create(:article, book:) }
  let(:cloze_text) { "The half life of caffeine is about 5 hours." }
  let(:concepts) { [create(:concept, name: "caffeine", user:)] }

  it { is_expected.to be_valid }

  context "when article is nil" do
    let(:article) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when sentence is an empty string" do
    let(:cloze_text) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when sentence is nil" do
    let(:cloze_text) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when anki_guid is the same as a different cloze note" do
    before do
      cloze_note.anki_guid = create(:cloze_note, article:).anki_guid
    end

    it { is_expected.not_to be_valid }
  end
end
