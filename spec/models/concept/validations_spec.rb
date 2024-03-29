# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Concept, "#valid?" do
  subject(:concept) { build(:concept, name:, user:) }

  let(:name) { "example concept name" }
  let(:user) { create(:user) }

  it { is_expected.to be_valid }

  context "when user is nil" do
    let(:user) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when name is an empty string" do
    let(:name) { "" }

    it { is_expected.not_to be_valid }
  end

  context "when name is nil" do
    let(:name) { nil }

    it { is_expected.not_to be_valid }
  end

  context "when name is the same as one of the user's other concepts" do
    before { create(:concept, name:, user:) }

    it { is_expected.not_to be_valid }
  end

  context "when name is the same as one of the user's other concepts but with case difference" do
    before { create(:concept, name: name.upcase, user:) }

    it { is_expected.not_to be_valid }
  end
end
