# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Concept, "#valid?" do
  it "is valid with a name and user" do
    concept = build(:concept, name: "Example Title", user: create(:user))
    expect(concept).to be_valid
  end

  it "is invalid without a user" do
    concept = build(:concept, name: "Example Title", user: nil)
    expect(concept).not_to be_valid
  end

  it "is invalid with an empty string name" do
    concept = build(:concept, name: "", user: create(:user))
    expect(concept).to be_invalid
  end

  it "is invalid without a name" do
    concept = build(:concept, name: nil, user: create(:user))
    expect(concept).to be_invalid
  end
end
