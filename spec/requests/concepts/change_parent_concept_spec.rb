# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

RSpec.describe "GET /concepts/:id/change_parent_concept", "#change_parent_concept" do
  subject(:patch_concepts_change_parent_concept) do
    patch change_parent_concept_path(concept), params:
  end

  let(:user) { create(:user) }
  let(:params) { { parent_concept_id: parent_concept.id } }
  let(:parent_concept) { create(:concept, user:) }
  let(:concept) { create(:concept, user:) }

  include_examples "user is not logged in and needs to be"

  context "when user is logged in" do
    include_context "when the user is logged in"

    let(:concept) { create(:concept, user:) }

    it "returns a success response" do
      patch_concepts_change_parent_concept
      expect(response).to redirect_to(manage_concept_path(concept))
      expect(concept.reload.parent_concept).to eq parent_concept
    end

    context "when parent concept cannot be found because it was deleted" do
      before { parent_concept.destroy }

      it "redirects to the homepage" do
        patch_concepts_change_parent_concept
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
