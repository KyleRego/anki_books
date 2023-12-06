# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe Concept, "#save" do
  it "strips white space at the beginning and end of the concept name" do
    concept = build(:concept, name: "   e   ", user: create(:user))
    concept.save
    expect(concept.reload.name).to eq("e")
  end

  it "strips white space at the ends but leaves it in the middle" do
    concept = build(:concept, name: "   a b  ", user: create(:user))
    concept.save
    expect(concept.reload.name).to eq("a b")
  end
end
