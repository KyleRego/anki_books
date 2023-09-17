# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe BasicNote, "#valid?" do
  subject(:basic_note) { build(:basic_note, article:, front:, back:) }

  let(:article) { create(:article) }
  let(:front) { "What is the front?" }
  let(:back) { "This is the back." }

  it { is_expected.to be_valid }

  context "when article is nil" do
    let(:article) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when front is nil" do
    let(:front) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when back is nil" do
    let(:back) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when ordinal position is nil" do
    before { basic_note.ordinal_position = nil }

    it { is_expected.not_to be_valid }
  end

  context "when ordinal position is the same as a different note of the same article" do
    before do
      basic_note.ordinal_position = create(:basic_note, article:).ordinal_position
    end

    it { is_expected.not_to be_valid }
  end

  context "when anki_guid is the same as an existing note" do
    before do
      basic_note.anki_guid = create(:basic_note, article:).anki_guid
    end

    it { is_expected.not_to be_valid }
  end

  context "when ordinal position is negative" do
    before { basic_note.ordinal_position = -1 }

    it { is_expected.not_to be_valid }
  end
end
