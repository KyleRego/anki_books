# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe User, "#find_existing_concept" do
  subject(:find_existing_concept) do
    user.find_existing_concept(concept_name:)
  end

  let(:user) { create(:user) }
  let(:concept_name) { " " }

  it "returns nil when user has no concepts" do
    expect(find_existing_concept).to be_nil
  end

  context "when user has a concept with name equal to concept_name" do
    let(:concept_name) { "neuron" }

    before { create(:concept, user:, name: "neuron") }

    it "returns the concept found by name" do
      expect(find_existing_concept.class).to eq Concept
      expect(find_existing_concept.name).to eq "neuron"
    end
  end

  context "when user does not have any concept that matches" do
    let(:concept_name) { "umbrella" }

    before { create(:concept, user:, name: "selenium") }

    it "returns nil" do
      expect(find_existing_concept).to be_nil
    end
  end

  context "when user has a concept with a lowercase name compared to the concept name" do
    let(:concept_name) { "HELLO" }

    before { create(:concept, user:, name: "hello") }

    it "returns the concept found by name" do
      expect(find_existing_concept.class).to eq Concept
      expect(find_existing_concept.name).to eq "hello"
    end
  end

  context "when user has a concept with an uppercase name compared to the concept name" do
    let(:concept_name) { "hello" }

    before { create(:concept, user:, name: "HELLO") }

    it "returns the concept found by name" do
      expect(find_existing_concept.class).to eq Concept
      expect(find_existing_concept.name).to eq "HELLO"
    end
  end
end
