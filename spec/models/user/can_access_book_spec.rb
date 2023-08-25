# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#can_access_book?" do
  subject { user.can_access_book?(book:) }

  let(:user) { create(:user) }

  context "when the book is one of the user's books" do
    let(:book) { create(:book, users: [user]) }

    it { is_expected.to be true }
  end

  context "when the book is not one of the user's books" do
    let(:book) { create(:book, users: []) }

    it { is_expected.to be false }
  end
end
