# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#can_access_note?" do
  subject { user.can_access_note?(note:) }

  let(:user) { create(:user) }

  context "when note is a basic note" do
    let(:note) do
      article = create(:article, book:)
      create(:basic_note, article:)
    end

    context "when note is to an article of one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it { is_expected.to be true }
    end

    context "when note is to an article that does not belong to one of the user's books" do
      let(:book) { create(:book, users: []) }

      it { is_expected.to be false }
    end
  end

  context "when note is a cloze note" do
    let(:note) do
      article = create(:article, book:)
      create(:cloze_note, article:)
    end

    context "when note is to an article of one of the user's books" do
      let(:book) { create(:book, users: [user]) }

      it { is_expected.to be true }
    end

    context "when note is to an article that does not belong to one of the user's books" do
      let(:book) { create(:book, users: []) }

      it { is_expected.to be false }
    end
  end
end
