# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Domain, "#valid?" do
  subject(:domain) { build(:domain, user:, title:) }

  let(:user) { create(:user) }
  let(:title) { "Example title" }

  it { is_expected.to be_valid }

  context "when user is nil" do
    let(:user) { nil }

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
