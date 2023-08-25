# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#can_access_article?" do
  subject { user.can_access_article?(article:) }

  let(:user) { create(:user) }
  let(:article) { create(:article, book:) }

  context "when the article belongs to one of the user's books" do
    let(:book) { create(:book, users: [user]) }

    it { is_expected.to be true }
  end

  context "when the article does not belong to one of the user's books" do
    let(:book) { create(:book, users: []) }

    it { is_expected.to be false }
  end
end
