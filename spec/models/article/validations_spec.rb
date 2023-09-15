# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Article, "#valid?" do
  subject(:article) { build(:article, book:, title:) }

  let(:book) { create(:book) }
  let(:title) { "Example title" }

  it { is_expected.to be_valid }

  context "when book is nil" do
    let(:book) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when ordinal position is nil" do
    before { article.ordinal_position = nil }

    it { is_expected.not_to be_valid }
  end

  context "when title is an empty string" do
    let(:title) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when title is nil" do
    let(:title) { nil }

    it { is_expected.not_to be_valid }
  end
end
