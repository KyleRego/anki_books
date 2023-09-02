# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "PATCH /concepts/:id", "#update" do
  subject(:patch_concepts_update) { patch concept_path(concept), params: { concept: { name: } } }

  let(:concept) { create(:concept, user: create(:user)) }
  let(:name) { "New concept name" }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:concept) { create(:concept, user:) }

    it "updates the concept" do
      expect { patch_concepts_update }.to change(Concept, :count).by 1
      expect(user.concepts.last.name).to eq name
    end

    context "when the name parameter is blank" do
      let(:name) { "" }

      it "does not update the concept and shows a flash alert" do
        patch_concepts_update
        expect(concept.name).not_to eq ""
        expect(flash[:alert]).not_to be_nil
      end
    end
  end
end
